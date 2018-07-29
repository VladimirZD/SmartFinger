//
//  SFGLevelManager.m
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGLevelManager.h"
#import "SFGLevel.h"
#import "SFGAppContext.h"
#import "SFGSwapEffect.h"
#import "SFGHideEffect.h"


@implementation SFGLevelManager

NSMutableDictionary *_levels = nil;


-(id) init
{
    if (self =[super init])
    {
       
    }
    return self;
}

+ (SFGEffectBase *) getRandomEffect:(SFGLevel *)level
{
    SFGEffectBase *effect = (SFGEffectBase*)[SFGAppContext getRandomElementFromDictionary:level.Effects];
    return effect;
}

+ (NSMutableDictionary *)getLevels
{
    _levels =[NSMutableDictionary dictionary];

    
    SFGLevel* level = [[SFGLevel alloc] initLevelWithMinValue:1 AndMaxValue:9 AndMinElements:1 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:5];
    [_levels setValue:level forKey:@"1"];
    
    level = [[SFGLevel alloc] initLevelWithMinValue:-9 AndMaxValue:9 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:5];
    [_levels setValue:level forKey:@"2"];
   
    NSMutableDictionary *effects = [[NSMutableDictionary alloc] init];
    [effects setObject:[[SFGSwapEffect alloc] init] forKey:@"1"];
    level = [[SFGLevel alloc] initLevelWithMinValue:-9 AndMaxValue:9 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:6  AndEffects:effects];
    [_levels setValue:level forKey:@"3"];
    
    effects = [[NSMutableDictionary alloc] init];
    [effects setObject:[[SFGHideEffect alloc] init] forKey:@"1"];
    level = [[SFGLevel alloc] initLevelWithMinValue:-9 AndMaxValue:9 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:6 AndEffects:effects];
    [_levels setValue:level forKey:@"4"];
    
    effects = [[NSMutableDictionary alloc] init];
    [effects setObject:[[SFGSwapEffect alloc] init] forKey:@"1"];
    level = [[SFGLevel alloc] initLevelWithMinValue:-99 AndMaxValue:99 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:10 AndEffects:effects];
    [_levels setValue:level forKey:@"5"];
    
    effects = [[NSMutableDictionary alloc] init];
    [effects setObject:[[SFGHideEffect alloc] init] forKey:@"1"];
    level = [[SFGLevel alloc] initLevelWithMinValue:-99 AndMaxValue:99 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:10 AndEffects:effects];
    [_levels setValue:level forKey:@"6"];
     
    effects = [[NSMutableDictionary alloc] init];
    [effects setObject:[[SFGHideEffect alloc] init] forKey:@"1"];
    [effects setObject:[[SFGSwapEffect alloc] init] forKey:@"2"];
    level = [[SFGLevel alloc] initLevelWithMinValue:-9 AndMaxValue:9 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:10 AndEffects:effects];
    [_levels setValue:level forKey:@"7"];
    
    level = [[SFGLevel alloc] initLevelWithMinValue:-99 AndMaxValue:99 AndMinElements:2 AndMaxElements:4 AndPenaltyTime:5 AndBonusTime:10 AndEffects:effects];
    [_levels setValue:level forKey:@"8"];
    return _levels;
}

/*
 
 
 public static List<Level> GetLevels()
 {
 List<Level> _levels;
 _levels = new List<Level>();
//  _levels.Add(new Level(1, 9, 1, 4, 5,5));
 //_levels.Add(new Level(-9, 9, 2, 4, 5,5));
// _levels.Add(new Level(-9, 9, 2, 4, 5,6, new List<IEffect>() { new SwapEffect() }));
// _levels.Add(new Level(-9, 9, 2, 4, 5, 6,new List<IEffect>() { new HideEffect() }));
// _levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new SwapEffect() }));
// _levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new HideEffect() }));
 //_levels.Add(new Level(-9, 9, 2, 4, 5,10, new List<IEffect>() { new HideEffect(),new SwapEffect() }));     //TODO testirati level sa 2 efekta
//_levels.Add(new Level(-99, 99, 2, 4, 5,10, new List<IEffect>() { new HideEffect(), new SwapEffect() }));  
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
*/
@end
