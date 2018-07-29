//using System;
//using System.Net;
//using System.Windows;
//using System.Windows.Controls;
//using System.Windows.Documents;
//using System.Windows.Ink;
//using System.Windows.Input;
//using System.Windows.Media;
//using System.Windows.Media.Animation;
//using System.Windows.Shapes;
//using System.Collections.Generic;

//namespace Igra.Effects
//{
//    public class ActivEffects
//    {
//        public List<IEffect> Items{ get; set; }

//        public IEffect GetEffectByType(Type type)
//        {
//            IEffect retValue = null;

//            foreach (IEffect item in Items)
//            {
//                if (item.GetType() == type)
//                {
//                    retValue = item;
//                    break;
//                }
//            }
//            return retValue;
//        }

//        public ActiveAffects()
//        {
//            this.Items = new List<IEffect>();
//        }

//    }
//}
