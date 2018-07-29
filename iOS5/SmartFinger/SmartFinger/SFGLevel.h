//
//  SFGLevel.h
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFGLevel : NSObject

@property (assign) NSInteger MinValue;
@property (assign) NSInteger MaxValue;
@property (assign) NSInteger MaxElements;
@property (assign) NSInteger MinElements;
@property (assign) NSInteger PenaltyTime;
@property (assign) NSInteger BonusTime;
@property (strong, nonatomic) NSMutableDictionary *Effects;

-(id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int) minElements AndMaxElements:(int)maxelements AndPenaltyTime: (int) penaltyTime AndBonusTime:(int) bonusTime AndEffects: (NSMutableDictionary*) effects; 

-(id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int) minElements AndMaxElements:(int)maxelements AndPenaltyTime: (int) penaltyTime AndBonusTime:(int) bonusTime;

-(id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int) minElements AndMaxElements:(int)maxelements;
@end
