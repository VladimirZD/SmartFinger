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
using Igra.Resources;
using System.Resources;
using System.ComponentModel;
using System.Linq.Expressions;

namespace Igra
{
    //public class LocalizedStrings
    //{
    //    public LocalizedStrings()
    //    {
    //    }

    //    private static AppResources localizedResources = new AppResources();

    //    public AppResources AppResources
    //    {
    //        get { return localizedResources; }
    //    }

    //    public static string GetResourceString(string stringKey)
    //    {
    //        ResourceManager rm = new ResourceManager("Resources.AppResources", System.Reflection.Assembly.GetExecutingAssembly());
    //        return rm.GetString(stringKey);

    //    }
    //}

    public class LocalizedStrings : INotifyPropertyChanged
    {
        private AppResources appresources;
        public LocalizedStrings()
        {
            appresources = new AppResources(); ;
        }

        //private static AppResources localizedResources = new AppResources();
        
        public AppResources AppResources
        {
         //   get { return localizedResources; }
            get { return appresources; }

        }

        public static string GetResourceString(string stringKey)
        {
            ResourceManager rm = new ResourceManager("Resources.AppResources", System.Reflection.Assembly.GetExecutingAssembly());
            return rm.GetString(stringKey);
        }

        public void ResetResources()
        {
           OnPropertyChanged(() => AppResources);
        }

        #region INotifyPropertyChanged Members

        public event PropertyChangedEventHandler PropertyChanged;

        public void OnPropertyChanged<T>(Expression<Func<T>> selector)
        {
            if (PropertyChanged != null)
            {
                PropertyChanged(this, new PropertyChangedEventArgs(GetPropertyNameFromExpression(selector)));
            }
        }

        public static string GetPropertyNameFromExpression<T>(Expression<Func<T>> property)
        {
            var lambda = (LambdaExpression)property;
            MemberExpression memberExpression;

            if (lambda.Body is UnaryExpression)
            {
                var unaryExpression = (UnaryExpression)lambda.Body;
                memberExpression = (MemberExpression)unaryExpression.Operand;
            }
            else
            {
                memberExpression = (MemberExpression)lambda.Body;
            }

            return memberExpression.Member.Name;
        }
        #endregion


    }
}
