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

namespace Igra
{
    public partial class HighScorePage : PhoneApplicationPage
    {

        public HighScorePage()
        {
            InitializeComponent();
            RenderList();
        }

        private void RenderList()
        {
            
            List<HighScore> hiScores = AppContext.Instance.HiScore.Value.OrderByDescending(x=>x.TotalScore).ToList();
            foreach (HighScore item in hiScores)
            {
                int index = hiScores.IndexOf(item);
                TextBlock textBlock = new TextBlock();
                

                AddChildToGrid(textBlock, index, 0);
                //textBlock.FontSize = 22;
                textBlock.Text = (index+1).ToString() + ".\t" + item.Ime;
                textBlock = new TextBlock();
                AddChildToGrid(textBlock, index, 1);
                //textBlock.FontSize = 22;
                textBlock.Text = item.TotalScore.ToString();
                if (item.LearningMode || item.ShowSum)
                {
                    textBlock.Text += " *";
                }

            }
        }

        private void AddChildToGrid(FrameworkElement child, int row, int column)
        {
            Grid.SetRow(child,row);
            Grid.SetColumn(child, column);
            gridHigScore.Children.Add(child);
        }

    }
}
