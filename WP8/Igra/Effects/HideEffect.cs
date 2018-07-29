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
    public class HideEffect : EffectBase
    {
        private TextBlock _textBlock = null;
        private Brush _oldBrush = null;
        
        override public string Name
        {
            get
            {
                return "Hide";
            }
        }

        public override void Execute()
        {
            List<TextBlock> items = new List<TextBlock>(AppContext.Instance.TextControls);
            if (_textBlock != null)
            { 
                items.Remove(_textBlock);
            }
            Stop();
            _textBlock = null;
            _textBlock = AppContext.Instance.GetRandomTextBlock(items, false);
            
            if (_textBlock != null)
            {
                Ellipse elippse = AppContext.Instance.EllipseControls[AppContext.Instance.TextControls.IndexOf(_textBlock)];
                _oldBrush = _textBlock.Foreground;
                _textBlock.Foreground = elippse.Fill;
            }
            base.Execute();
        }

        private void Reset()
        {
            if (_textBlock != null)
            {
                _textBlock.Foreground = _oldBrush;
                //_oldBrush = null;
            }
        }

        override public void Stop()
        {
            Reset();
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
