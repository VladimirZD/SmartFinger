//using System;
//using System.Net;
//using System.Windows;
//using System.Windows.Controls;
//using System.Windows.Documents;
//using System.Windows.Ink;
//using System.Windows.Input;
//using System.Windows.Media;
//using System.Windows.Media.Animation;
//using System.Windows.Shapes;
//using System.Windows.Threading;
//using Microsoft.Xna.Framework.Audio;

//namespace Igra.Effects
//{
//    public class WrongAnswerEffect : EffectBase
//    {
//        private SolidColorBrush _originalBrush;
//        private Ellipse _ellipse = null;

//        override public string Name
//        {
//            get
//            {
//                return "WrongAnswer";
//            }
//        }

//        override public void Execute(System.Collections.Generic.List<object> controls)
//        {
//            base.Execute(controls);

//            _ellipse = (Ellipse)controls[0];
//            SolidColorBrush mySolidColorBrush = new SolidColorBrush();
//            mySolidColorBrush.Color = ColorProvider.CustomRed();
//            _originalBrush = (SolidColorBrush)_ellipse.Fill;
//            _ellipse.Fill = mySolidColorBrush;
//        }

//        private void ResetValues()
//        {
//            if (_originalBrush != null)
//            { 
//                _ellipse.Fill = _originalBrush;
//            }
//        }

//        override public void Stop()
//        {
//            ResetValues();
//            base.Stop();
//        }

//        override public int Duration
//        {
//            get
//            {
//                return 1;
//            }
//        }
//    }
//}
