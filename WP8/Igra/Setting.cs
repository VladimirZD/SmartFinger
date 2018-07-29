using System.IO.IsolatedStorage;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.Text;


namespace Igra
{
    
    public class Setting<T>
    {
        string name;
        T settingValue;
        T defaultValue;
        bool hasValue;

        public Setting(string name, T defaultValue)
        {
            this.name = name;
            this.defaultValue = defaultValue;
        }

        public T Value
        {
            get
            {
                if (!this.hasValue)
                {
                    if (!IsolatedStorageSettings.ApplicationSettings.TryGetValue(this.name, out this.settingValue))
                    {
                        this.settingValue = this.defaultValue;
                        IsolatedStorageSettings.ApplicationSettings[this.name] = this.settingValue;
                    }
                    this.hasValue = true;
                }
                return this.settingValue;
            }
            set
            {
                IsolatedStorageSettings.ApplicationSettings[this.name] = value;
                this.settingValue = value;
                this.hasValue = true;
                IsolatedStorageSettings.ApplicationSettings.Save();
            }
        }
        public T DefaultValue
        {
            get { return this.defaultValue; }
        }

        public void ForceRefresh()
        {
            this.hasValue = false;
        }

    }
}