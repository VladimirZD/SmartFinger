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
        T value;
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
                    if (!IsolatedStorageSettings.ApplicationSettings.TryGetValue(this.name, out this.value))
                    {
                        this.value = this.defaultValue;
                        IsolatedStorageSettings.ApplicationSettings[this.name] = this.value;
                    }
                    this.hasValue = true;
                }
                return this.value;
            }
            set
            {
                IsolatedStorageSettings.ApplicationSettings[this.name] = value;
                this.value = value;
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