//
//  SFGHiScore.m
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGHiScore.h"

@implementation SFGHiScore

@synthesize Stars;
@synthesize Level;
@synthesize Name;
@synthesize LearningMode;
@synthesize ShowSum;


-(id) initWithLevel:(int)level AndStars:(int)stars 
{
    return [self initWithLevel:level AndStars:stars AndName:nil AndLearningMode:NO AndShowSum:NO];
}


-(id) initWithLevel:(int)level AndStars:(int)stars AndLearningMode:(BOOL)learningmode AndShowSum:(BOOL)showsum  
{
    return [self initWithLevel:level AndStars:stars AndName:nil AndLearningMode:learningmode AndShowSum:showsum];
}

-(id) initWithLevel:(int)level AndStars:(int)stars AndName:(NSString *)name AndLearningMode:(BOOL)learningmode AndShowSum:(BOOL)showsum     
{
    if (self =[super init])
    {
        self.Level=level;
        self.Stars=stars;
        self.Name=name;
        self.LearningMode=learningmode;
        self.ShowSum=showsum;
    }
    return self;
}

-(int) GetTotalScore
{
    int score = (Level - 1) *10 + Stars;
    if (score < 0) score = 0;
    return score;
}
/*
-(NSComparisonResult) compare:(SFGHiScore*)score1 With:(SFGHiScore*)score2 AndContext:(void*) context
{
    int v1 = [score1 GetTotalScore];
    int v2 = [score2 GetTotalScore];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
    
}
*/

-(NSComparisonResult) customCompare:(SFGHiScore*)score2
{
    int v1 = [self GetTotalScore];
    int v2 = [score2 GetTotalScore];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
    
}

@end
