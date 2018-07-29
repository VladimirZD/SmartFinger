//
//  SFGColorProvider.m
//  SmartFinger
//
//  Created by Lion User on 11/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGColorProvider.h"

@implementation SFGColorProvider
 


+(UIColor *) StrokeActive
 {
     //Vrijednosti si od 0 do 1 pa dijelimo sa 255
     return [UIColor colorWithRed:255/255 green:253/255 blue:255/255 alpha:255/255];
     //return Color.FromArgb(255, 255, 253, 255);
 }
 
+(UIColor *)StrokeInactive
 {
     return [UIColor colorWithRed:80/255 green:80/255 blue:80/255 alpha:255/255];
     //return Color.FromArgb(255, 80, 80, 80);
 }
 
+(UIColor * )CustomBlack
 {
     return [UIColor colorWithRed:8/255 green:8/255 blue:8/255 alpha:255/255];
 //return Color.FromArgb(255, 8, 8, 8);
 }
 
+(UIColor * ) CustomRed
 {
     return [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
 //return (Color)Application.Current.Resources["Crvena"];
 }
 
 +(UIColor * ) CustomBlue
 {
     return [UIColor colorWithRed:18/255 green:31/255 blue:82/255 alpha:255/255];
 //return (Color)Application.Current.Resources["TamnoPlava"];
 }
 
 +(UIColor * ) CustomYellow
 {
     //return [UIColor colorWithRed:196/255 green:204/255 blue:57/255 alpha:255/255];
     return [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
 //return (Color)Application.Current.Resources["Zuta"];
 }
 
+(UIColor * )CustomGreen
 {
     return [UIColor colorWithRed:0 green:1 blue:0 alpha:1];
 //return (Color)Application.Current.Resources["Zelena"];
 }

             
/*   <local:LocalizedStrings xmlns:local="clr-namespace:Igra" x:Key="LocalizedStrings" />
 <Color x:Key="Zelena">#FF6FB05E</Color>111 176 94
 <Color x:Key="TamnoPlava">#FF121F52</Color> 18 31 82
 <Color x:Key="Crvena">#FF922A0C</Color> 146 42 12
 <Color x:Key="Zuta">#FFC4CC39</Color>196 204 57
 <Color x:Key="SvjetloPlava">#FF277FA5</Color>39 127 165
  */
@end
