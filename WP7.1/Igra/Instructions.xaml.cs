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
    public partial class Instructions : PhoneApplicationPage
    {
        public Instructions()
        {
            InitializeComponent();
            textVersion.Text=AppResources.VersionText+" "+GetVersion();
                
        }

        private string GetVersion()
        {
            //var version = System.Reflection.Assembly.GetExecutingAssembly().FullName.Split('=')[1].Split(',')[0].ToString();
            String appVersion = System.Reflection.Assembly.GetExecutingAssembly().FullName.Split('=')[1].Split(',')[0].ToString();
            return appVersion;
        }
    }
}