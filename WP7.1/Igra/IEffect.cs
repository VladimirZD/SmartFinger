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


namespace Igra
{
    public interface IEffect
    {

        string Name
        {
            get;
        }

        int Duration//seconds
        {
            get;
        }

        bool Active
        {
            get;
        }

        DateTime StartTime
        {
            get;
            set;
        }

        void Execute(List<object> controls);
        void Execute();
        void Stop();

    }
}
