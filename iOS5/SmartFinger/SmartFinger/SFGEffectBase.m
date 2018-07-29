//
//  SFGEffectBase.m
//  SmartFinger
//
//  Created by Lion User on 18/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGEffectBase.h"


@implementation SFGEffectBase


@synthesize Name;
@synthesize Duration;
@synthesize StartTime;

NSTimer *_timer;
- (id) init
{
    self.Duration=5;
    self.Name=@"EffectBase";
    return self;
}

-(BOOL) IsActive
{
    BOOL retValue = YES;
    NSTimeInterval interval = self.Duration;
    NSDate *endTime = [self.StartTime dateByAddingTimeInterval:interval];
    NSDate *currentTime = [NSDate date];
    NSDate *latterDat = [endTime laterDate:currentTime];

    if ((self.StartTime == nil) || [currentTime isEqual:latterDat])
    {
        retValue = NO;
    }
    return retValue;
    
}

-(void) StopTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(void) StartTimer
{
    [self  StopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.Duration target:self selector:@selector(TimerTick) userInfo:nil repeats:YES];
    self.StartTime=[NSDate date];
}

- (void) TimerTick
{
    [self StopTimer];
}

-(void) Execute
{
    [self Execute:nil];
}

-(void) Execute:(NSMutableDictionary*) controls;
{
    if (self.Duration != 0)
    {
        
        [self StartTimer];
    }
 }

-(void) Stop
{
    [self StopTimer];
}

@end
