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
using System.Windows.Threading;
using System.Collections.Generic;

namespace Igra.Effects
{
    public class SwapEffect:EffectBase
    {
        //private TextBlock _textBlock1 = null;
        //private TextBlock _textBlock2 = null;
        override public string Name
        {
            get
            {
                return "Swap";
            }
        }

        public override void Execute()
        {

            Stop();
            List<TextBlock> items = new List<TextBlock>(AppContext.Instance.TextControls);
            TextBlock _textBlock1 = null;
            TextBlock _textBlock2 = null;

            _textBlock1 = AppContext.Instance.GetRandomTextBlock(items,false);
            _textBlock2 = AppContext.Instance.GetRandomTextBlock(items,false);
            
            SwapTextBlock(_textBlock1, _textBlock2);
         
            base.Execute();
        }

        static private void SwapTextBlock(TextBlock textBlock1, TextBlock textBlock2)
        {
            TextBlock tempTextBlock = new TextBlock();
            Ellipse elippse1 =null;
            Ellipse elippse2 = null;
            Ellipse tempEllipse = new Ellipse();

            if (textBlock1 != null && textBlock2 != null)
            {
                tempTextBlock.Text = textBlock1.Text;
                textBlock1.Text = textBlock2.Text;
                textBlock2.Text = tempTextBlock.Text;

                elippse1 = AppContext.Instance.EllipseControls[AppContext.Instance.TextControls.IndexOf(textBlock1)];
                elippse2 = AppContext.Instance.EllipseControls[AppContext.Instance.TextControls.IndexOf(textBlock2)];
                tempEllipse = elippse1;
                //

                tempEllipse.Fill = elippse1.Fill;
                tempEllipse.StrokeThickness = elippse1.StrokeThickness;

                elippse1.Fill = elippse2.Fill;
                elippse1.StrokeThickness = elippse2.StrokeThickness;

                elippse2.Fill = tempEllipse.Fill;
                elippse2.StrokeThickness = tempEllipse.StrokeThickness;
            }

        }

        //private void ResetValues()
        //{  
        //    //if (_textBlock1 != null)
        //    //{
        //    //    SwapTextBlock(_textBlock2, _textBlock1);
        //    //}
          
        //}

        override public void Stop()
        {
            //ResetValues();
            base.Stop();
        }

        //override public int Duration
        //{
        //    get
        //    {
        //        return 4;
        //    }
        //}
    }
}
