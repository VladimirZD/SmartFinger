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
            //Level 1: 1-3 elementa, brojevi u rasponu -9 do 9
            //Level 2: 1-4 elementa, brojevi u rasponu -9 do 9
            //Level 3: 1-3 elementa, brojevi u rasponu -99 do 99
            //Level 4: 1-4 elementa, brojevi u rasponu -99 do 99
            //Level 5: 1-3 elementa, brojevi u rasponu -999 do 999
            //Level 6: 1-4 elementa, brojevi u rasponu -999 do 999
            //Level 7: 1-4 elementa, brojevi u rasponu -999 do 999, kazna -5,krivi gumb bojamo u crveno, user ga mora selektirati da se vrati u normalu.
            //Level 8: 1-4 elementa, brojevi u rasponu -999 do 999, kazna -5,krivi gumb bojamo u crveno, user ga mora selektirati da se vrati u normalu,zamjena brojeva 
            //Level 9: 1-4 elementa, brojevi u rasponu -999 do 999, kazna -5,krivi gumb bojamo u crveno, user ga mora selektirati da se vrati u normalu, brojevi se "skrivaju", svakih 3 sec gumb izgubi broj na 3 sec.
            //Level 10: 1-4 elementa, brojevi u rasponu -999 do 999, kazna -5,krivi gumb bojamo u crveno, user ga mora selektirati da se vrati u normalu,svakih 3 sekundi jedan broj nestane i 2 se zamjene...

            _levels = new List<Level>();
            _levels.Add(new Level(1, 9, 1, 4, 5,5));
            _levels.Add(new Level(-9, 9, 2, 4, 5,5));
            _levels.Add(new Level(-9, 9, 2, 4, 5,6, new List<IEffect>() { new SwapEffect() }));
            _levels.Add(new Level(-9, 9, 2, 4, 5, 6,new List<IEffect>() { new HideEffect() }));
            _levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new SwapEffect() }));
            _levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new HideEffect() }));
            _levels.Add(new Level(-9, 9, 2, 4, 5,10, new List<IEffect>() { new HideEffect(),new SwapEffect() }));     //TODO testirati level sa 2 efekta
            _levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new HideEffect(), new SwapEffect() }));  
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
