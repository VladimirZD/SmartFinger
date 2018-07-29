using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Phone.Controls;
using Igra.Resources;

namespace Igra
{
    public partial class OptionsPage : PhoneApplicationPage
    {
        String[] LanguageList = { "System default", "Croatian", "English","French","German"};
        

        public OptionsPage()
        {
            InitializeComponent();
            this.listLanguage.ItemsSource = LanguageList;
            LoadSettings();
            chkSound.Click += new RoutedEventHandler(chkSound_Click);
        }

        void chkSound_Click(object sender, RoutedEventArgs e)
        {
            //this.chkVibrate.IsEnabled = !chkSound.IsChecked.Value;
            //this.chkVibrate.IsChecked = this.chkVibrate.IsEnabled;
        }

        protected override void OnNavigatingFrom(System.Windows.Navigation.NavigatingCancelEventArgs e)
        {
            int level;
            bool cancel = true;
            if (int.TryParse(textStartLevel.Text,out level))
            {
                if (level > 0 && level <9) 
                {
                    cancel = false;
                }
            }
            if (cancel)
            {
                MessageBox.Show(AppResources.LevelNumberValidationError, AppResources.CaptionError, MessageBoxButton.OK);
            }
        }   
        private void LoadSettings()
        {
            chkLearningMode.IsChecked = (bool)AppContext.Instance.LearningMode.Value;
            chkVibrate.IsChecked = (bool)AppContext.Instance.Vibrate.Value;
            chkSound.IsChecked = (bool)AppContext.Instance.Sound.Value;
            chkShowSum.IsChecked = (bool)AppContext.Instance.ShowSum.Value;
            listLanguage.SelectedItem = (string)AppContext.Instance.Language.Value;
            textStartLevel.Text = AppContext.Instance.StartLevel.Value.ToString();
        }

        private void SaveSettings()
        {
            AppContext.Instance.LearningMode.Value = (bool) chkLearningMode.IsChecked;
            AppContext.Instance.Vibrate.Value = (bool)chkVibrate.IsChecked;
            AppContext.Instance.Sound.Value = (bool)chkSound.IsChecked;
            AppContext.Instance.ShowSum.Value = (bool)chkShowSum.IsChecked;
            AppContext.Instance.Language.Value = (string)listLanguage.SelectedItem.ToString();
            AppContext.Instance.StartLevel.Value = int.Parse(textStartLevel.Text);
        }

        protected override void OnNavigatedFrom(System.Windows.Navigation.NavigationEventArgs e)
        {
            SaveSettings();
            base.OnNavigatedFrom(e);
        }

        protected override void OnNavigatedTo(System.Windows.Navigation.NavigationEventArgs e)
        {
            
            base.OnNavigatedTo(e);
            LoadSettings();
        }

        private void listLanguage_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            AppContext.Instance.SetLanguage(listLanguage.SelectedItem.ToString());
        }

        private void textStartLevel_GotFocus(object sender, RoutedEventArgs e)
        {
            textStartLevel.SelectAll();
        }
    }
}
