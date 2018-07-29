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

namespace Igra.Effects
{
    public class EffectBase: IEffect
    {

        private DispatcherTimer _timer = null;

        public DateTime StartTime { get; set; }
        
        private void InitTimer()
        {
            _timer = new DispatcherTimer();
            _timer.Interval = new TimeSpan(0, 0, this.Duration);
            _timer.Tick += new EventHandler(_timer_Tick);
        }

        void _timer_Tick(object sender, EventArgs e)
        {
            Stop();
        }

        virtual public string Name
        {
            get
            {
                return "EffectBase";
            }
        }

        virtual public void Execute(System.Collections.Generic.List<object> controls)
        {
            if (_timer == null)
            {
                InitTimer();
            }
            
            if (this.Duration != 0)
            {
                _timer.Start();
                this.StartTime = DateTime.Now;
            }
        }

        virtual public void Execute()
        {
            this.Execute(null);
        }

        virtual public void Stop()
        {
            if (_timer != null)
            {
                _timer.Stop();
            }
        }

        virtual public int Duration
        {
            get
            {
                return 5;
            }
        }

        virtual public bool Active
        {
            get
            {
                bool retValue = true;
                if ((StartTime == DateTime.MinValue) || StartTime.AddSeconds(Duration) <= DateTime.Now)
                {
                    retValue = false;
                }
                return retValue;
            }
        }
    }
}
