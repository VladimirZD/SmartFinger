using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Collections.Generic;
using Igra.Effects;
using System.Linq;
using System.Globalization;
using System.Threading;

namespace Igra
{

    public sealed class AppContext
    {
        private static AppContext _instance = null;
        private static readonly object syncRoot = new object();
        public const int LEVELTIME = 30;

        public Random RandomGenerator { get; set; }
        public List<TextBlock> TextControls { get; set; }
        public List<Ellipse> EllipseControls { get; set; }
        public List<TextBlock> SelectedItems { get; set; }

        public Setting<bool> Sound = new Setting<bool>("Sound", true);
        public Setting<bool> Vibrate = new Setting<bool>("Vibrate", false);
        public Setting<bool> LearningMode = new Setting<bool>("LearningMode", false);
        public Setting<bool> ShowSum = new Setting<bool>("ShowSum", false);
        public Setting<int> CurrentLevelIndex = new Setting<int>("CurrentLevel", 1);
        public Setting<int> CurrentStar = new Setting<int>("CurrentStar", 1);
        public Setting<int> StartLevel = new Setting<int>("StartLevel", 1);
        //public Setting<HighScore> HiScore = new Setting<HighScore>("HighScore", new HighScore(0, 0));
        public Setting<List<HighScore>> HiScore = new Setting<List<HighScore>>("HighScore",new List<HighScore>{new HighScore(1, 1, "Vladimir Mašala",false,false)
                                                                                            ,new HighScore(1, 1, "Siniša Pintek", true, false)
                                                                                            ,new HighScore(1, 2, "Vlad The impaler", false, true)
                                                                                            ,new HighScore(1, 2, "Domino", false, false)
                                                                                            });

//public Setting<List<HighScore>> HiScore = new Setting<List<HighScore>>("HighScore",new List<HighScore>{new HighScore(0,0)});
        public Setting<double> CurrentProgress = new Setting<double>("CurrentProgress", LEVELTIME);
        public Setting<string> LastPlayerName = new Setting<string>("LastPlayerName","Nepoznati junak");
        public Setting<string> Language = new Setting<string>("Language", "System default");

        public string SystemLanguage { get; set; }

        public static string GetVersion()
        {
            String appVersion = System.Reflection.Assembly.GetExecutingAssembly().FullName.Split('=')[1].Split(',')[0].ToString();
            return appVersion;
        }

        public bool IsNewHighScore(HighScore score)
        {
            bool retValue = false;
            List<HighScore> items = this.HiScore.Value;
            if (items.Count < 10)
            {
                retValue = true;
            }
            else
            {
                items = items.OrderByDescending(x => x.TotalScore).Where(x => x.TotalScore < score.TotalScore).ToList();
                if (items.Count != 0)
                { 
                    retValue = true;
                }
            }
            return retValue;
        }

        public void AddHighScore(HighScore score)
        {
            bool add = false;
            List<HighScore> items = this.HiScore.Value;
            if (items.Count < 10)
            {
                add = true;               
            }
            else
            {
                items = items.OrderByDescending(x => x.TotalScore).Where(x => x.TotalScore < score.TotalScore).ToList();
                if (items.Count != 0)
                {
                    this.HiScore.Value.Remove(items[items.Count-1]);
                   //items.RemoveAt(items.Count - 1); 
                    add = true;
                }
            }

            if (add)
            {
                this.HiScore.Value.Add(score);
            }
            
        }

        public HighScore GetLastHighScore()
        {
            HighScore retValue = null;
            if (this.HiScore.Value != null)
            { 
                retValue = this.HiScore.Value.OrderByDescending(x => x.TotalScore).Last();
            }
            return retValue;

        }

        private AppContext()
        {
            this.RandomGenerator = new Random();
            this.TextControls = new List<TextBlock>();
            this.EllipseControls = new List<Ellipse>();
            this.SelectedItems = new List<TextBlock>();
        }
        
        public TextBlock GetRandomTextBlock(List<TextBlock> controls,bool allowSelected)
        {
            TextBlock retValue = null;
            int index;
            while ((retValue == null) && controls!=null && controls.Count != 0)
            {
                index = AppContext.Instance.RandomGenerator.Next(0, controls.Count);
                retValue = controls[index];
                controls.RemoveAt(index);
                if (!allowSelected && this.SelectedItems.IndexOf(retValue) != -1)
                {
                    retValue = null;
                }
                
            }
            return retValue;
        }
        
        public void SetLanguage(string language)
        {
            CultureInfo ci = null;
            switch (language)
            {
                case "System default":
                    ci = new System.Globalization.CultureInfo(this.SystemLanguage);
                    break;
                case "Croatian":
                    ci = new System.Globalization.CultureInfo("hr-HR");
                    break;
                case "English":
                    ci = new System.Globalization.CultureInfo("en-US");
                    break;
                case "French":
                    ci = new System.Globalization.CultureInfo("fr-FR");
                    break;
                case "German":
                    ci = new System.Globalization.CultureInfo("de-DE");
                    break;
            }

            System.Threading.Thread.CurrentThread.CurrentCulture = ci;
            System.Threading.Thread.CurrentThread.CurrentUICulture = ci;
            ResetResources();
        }

        public void ResetControlsCollections()
        {
            this.TextControls.Clear();
        }

        private void ResetResources()
        {
            ((LocalizedStrings)App.Current.Resources["LocalizedStrings"]).ResetResources();
        }

   
        public static AppContext Instance
        {
            get
            {
                lock (syncRoot)
                {
                    if (_instance == null)
                    {
                        _instance = new AppContext();
                    }
                    return _instance;
                }
            }
            set
            {
                _instance = value;
            }
        }
    }

}