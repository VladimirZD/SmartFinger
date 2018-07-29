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
using Igra.Effects;
namespace Igra
{
    public class LevelManager
    {
        

        public static List<Level> GetLevels()
        {
            List<Level> _levels;
          

            _levels = new List<Level>();
            _levels.Add(new Level(minValue:  1,   maxValue: 9,   minElements: 1, maxElements: 4, penaltyTime: 5, bonusTime: 1));
            _levels.Add(new Level(minValue: -9,   maxValue: 9,   minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 2));
            _levels.Add(new Level(minValue: -15,  maxValue: 15,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 4, effects: new List<IEffect>() { new SwapEffect() }));
            _levels.Add(new Level(minValue: -20,  maxValue: 20,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 4, effects: new List<IEffect>() { new HideEffect() }));
            _levels.Add(new Level(minValue: -30,  maxValue: 30,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -40,  maxValue: 40,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -50,  maxValue: 50,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -60,  maxValue: 60,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -70,  maxValue: 70,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -80,  maxValue: 80,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -90,  maxValue: 90,  minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -100, maxValue: 100, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -120, maxValue: 120, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -130, maxValue: 130, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -140, maxValue: 140, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -150, maxValue: 150, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            _levels.Add(new Level(minValue: -160, maxValue: 160, minElements: 2, maxElements: 4, penaltyTime: 5, bonusTime: 6, effects: new List<IEffect>() { new HideEffect(), new SwapEffect() }));
            return _levels;
        }

        public static IEffect GetRandomEffect(Level  level)
        {
            IEffect retValue = null;
            AppContext appContext = AppContext.Instance;
            if (level.Effects != null)
            {
                int index = appContext.RandomGenerator.Next(0, level.Effects.Count);
                retValue = level.Effects[index];
            }
            return retValue;
        }
    }
}
