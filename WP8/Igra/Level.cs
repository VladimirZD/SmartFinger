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
   


    public class Level
    {
        public int MinValue{ get; set; }
        public int MaxValue { get; set; }
        public int MaxElements{ get; set; }
        public int MinElements{ get; set; }
        public int PenaltyTime{ get; set; } //sekunde
        public int BonusTime { get; set; } //sekunde
        public List<IEffect> Effects { get; set; }


        public Level(int minValue, int maxValue, int minElements, int maxElements,int bonusTime)
        {
            this.MinValue = minValue;
            this.MaxValue = maxValue;
            this.MinElements = minElements;
            this.MaxElements = maxElements;
            this.PenaltyTime = 0;
            this.BonusTime = bonusTime;
        }

        public Level(int minValue, int maxValue, int minElements, int maxElements, int penaltyTime,int bonusTime)
        {
            this.MinValue = minValue;
            this.MaxValue = maxValue;
            this.MinElements = minElements;
            this.MaxElements = maxElements;
            this.PenaltyTime = penaltyTime;
            this.BonusTime = bonusTime;
        }


        public Level(int minValue, int maxValue, int minElements, int maxElements, int penaltyTime, int bonusTime,List<IEffect> effects)
        {
            this.MinValue = minValue;
            this.MaxValue = maxValue;
            this.MinElements = minElements;
            this.MaxElements = maxElements;
            this.PenaltyTime = penaltyTime;
            this.Effects = effects;
            this.BonusTime = bonusTime;
        }

    }
}
