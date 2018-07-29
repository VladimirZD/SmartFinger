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
    public partial class Menu : PhoneApplicationPage
    {
        
        public Menu()
        {
            InitializeComponent();
            AppContext.Instance.SystemLanguage = System.Threading.Thread.CurrentThread.CurrentCulture.Name;
            AppContext.Instance.SetLanguage((string)AppContext.Instance.Language.Value);
            //TODO ovo treba otkačiti pri deaktivaciji aplikacije
            this.ResumeGameShape.MouseLeftButtonDown += new MouseButtonEventHandler(ResumeGame);
            this.ResumeGameTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(ResumeGame);

            this.NewGameShape.MouseLeftButtonDown += new MouseButtonEventHandler(NewGame);
            this.NewGameTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(NewGame);

            this.HighScoreTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(ShowHighScore);
            this.HighScoreShape.MouseLeftButtonDown += new MouseButtonEventHandler(ShowHighScore);

            this.InstructionsTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(ShowInstructions);
            this.InstructionsShape.MouseLeftButtonDown += new MouseButtonEventHandler(ShowInstructions);

            this.OptionsTextBlock.MouseLeftButtonDown += new MouseButtonEventHandler(ShowOptions);
            this.OptionsShape.MouseLeftButtonDown += new MouseButtonEventHandler(ShowOptions);
            
            
        }

        void ShowOptions(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("/OptionsPage.xaml", UriKind.RelativeOrAbsolute));
        }

        void ResumeGame(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("/MainPage.xaml?NewGame=0", UriKind.RelativeOrAbsolute));
        }

        void NewGame(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("/MainPage.xaml?NewGame=True", UriKind.RelativeOrAbsolute));
        }

        void ShowHighScore(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("/HighScorePage.xaml", UriKind.RelativeOrAbsolute));
        }

        void ShowInstructions(object sender, MouseButtonEventArgs e)
        {
            NavigationService.Navigate(new Uri("/Instructions.xaml", UriKind.RelativeOrAbsolute));
        }
    }
}

