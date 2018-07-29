//
//  SFGLevel.m
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGLevel.h"

@implementation SFGLevel

@synthesize MinValue;
@synthesize MaxValue;
@synthesize MaxElements;
@synthesize MinElements;
@synthesize PenaltyTime;
@synthesize BonusTime;
@synthesize Effects;

-(id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int) minelements AndMaxElements:(int)maxelements AndPenaltyTime:(int) penaltyTime AndBonusTime:(int) bonusTime AndEffects: (NSMutableDictionary*) effects
{
    if (self =[super init])
    {
        self.MinValue=minvalue;
        self.MaxValue=maxvalue;
        self.MinElements=minelements;
        self.MaxElements=maxelements;
        self.PenaltyTime=penaltyTime;
        self.BonusTime=bonusTime;
        self.Effects=effects;
    }
    return self;
}

- (id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int)minElements AndMaxElements:(int)maxelements AndPenaltyTime:(int)penaltyTime AndBonusTime:(int) bonusTime
{
    return [self initLevelWithMinValue:minvalue AndMaxValue:maxvalue AndMinElements:minElements AndMaxElements:maxelements AndPenaltyTime:penaltyTime AndBonusTime:bonusTime AndEffects:nil];
}

- (id) initLevelWithMinValue:(int)minvalue AndMaxValue:(int)maxvalue AndMinElements:(int)minElements AndMaxElements:(int)maxelements 
{
    return [self initLevelWithMinValue:minvalue AndMaxValue:maxvalue AndMinElements:minElements AndMaxElements:maxelements AndPenaltyTime:0 AndBonusTime:0];
}

@end
