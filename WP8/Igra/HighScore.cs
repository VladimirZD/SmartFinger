using System;
using System.IO;
using System.Runtime.Serialization.Json;
using System.Runtime.Serialization;
using System.Text;

namespace Igra
{
    [DataContract]
    public class HighScore
    {
        [DataMember]
        public int Stars { get; set; }
        [DataMember]
        public int Level { get; set; }
        [DataMember]
        public string Ime { get; set; }
        [DataMember]
        public bool LearningMode { get; set; }
        [DataMember]
        public bool ShowSum { get; set; }

        public HighScore(int level, int stars)
        {
            this.Stars = stars;
            this.Level = level;
            this.Ime = "Nepoznati heroj!!";
        }

        public HighScore(int level, int stars, bool learningMode, bool showSum)
        {
            this.Stars = stars;
            this.Level = level;
            this.LearningMode = learningMode;
            this.ShowSum = showSum;
        }

        public HighScore(int level, int stars,string ime,bool learningMode, bool showSum)
        {
            this.Stars = stars;
            this.Level = level;
            this.Ime = ime;
            this.LearningMode = learningMode;
            this.ShowSum = showSum;
        }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2202:Do not dispose objects multiple times")]
        public static string Serialize(object objectToSerialize)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                DataContractJsonSerializer serializer = new DataContractJsonSerializer(objectToSerialize.GetType());
                serializer.WriteObject(ms, objectToSerialize);
                ms.Position = 0;

                using (StreamReader reader = new StreamReader(ms))
                {
                    return reader.ReadToEnd();
                }
            }
        }

        public int TotalScore
        {
            get
            {
                int score = (Level - 1) *10 + Stars;
                if (score < 0) score = 0;
                return score;
            }
        }

        public static T Deserialize<T>(string value)
        {
            using (MemoryStream ms = new MemoryStream(Encoding.Unicode.GetBytes(value)))
            {
                DataContractJsonSerializer serializer = new DataContractJsonSerializer(typeof(T));
                return (T)serializer.ReadObject(ms);
            }
        }
    }
}
