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

namespace Igra
{
    public class ColorProvider
    {
        //public Color CustomGreen;
        //public Color CustomBlack = Color.FromArgb(255, 8, 8, 8);
        //public Color CustomRed;
        //public Color CustomBlue;
        //public Color CustomYellow;
        //public Color StrokeInactive = Color.FromArgb(255, 80, 80, 80);
        //public Color StrokeActive = 
        
        //public ColorProvider()
        //{
        //    //CustomGreen = (Color)Application.Current.Resources["Zelena"];
        //    CustomRed = (Color)Application.Current.Resources["Crvena"];
        //    CustomBlue = (Color)Application.Current.Resources["TamnoPlava"];
        //    CustomYellow = (Color)Application.Current.Resources["Zuta"];
        //}

        static public Color StrokeActive()
        {
            return Color.FromArgb(255, 255, 253, 253);
        }

        static public Color StrokeInactive()
        {
            return Color.FromArgb(255, 80, 80, 80);
        }

        static public Color CustomBlack()
        {
             return Color.FromArgb(255, 8, 8, 8);
        }

        static public Color CustomRed()
        {
             return (Color)Application.Current.Resources["Crvena"];
        }

        static public Color CustomBlue()
        {
             return (Color)Application.Current.Resources["TamnoPlava"];
        }

        static public Color CustomYellow()
        {
            return (Color)Application.Current.Resources["Zuta"];
        }

        static public Color CustomGreen()
        {
            return (Color)Application.Current.Resources["Zelena"];
        }
    }
}
