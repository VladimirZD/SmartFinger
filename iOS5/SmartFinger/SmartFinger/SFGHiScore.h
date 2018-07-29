//
//  SFGHiScore.h
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFGHiScore : NSObject

@property (assign,nonatomic) NSInteger Stars;
@property (assign,nonatomic) NSInteger Level;
@property (strong,nonatomic) NSString *Name;
@property (assign,nonatomic) BOOL LearningMode;
@property (assign,nonatomic) BOOL ShowSum;

-(id) initWithLevel:(int) level AndStars:(int) stars;
-(id) initWithLevel:(int) level AndStars:(int) stars AndLearningMode:(BOOL)learningmode AndShowSum:(BOOL)showsum;

-(id) initWithLevel:(int) level AndStars:(int) stars AndName:(NSString*) name AndLearningMode:(BOOL) learningmode AndShowSum:(BOOL) showsum;

-(int) GetTotalScore;
//-(NSComparisonResult) compare:(SFGHiScore*)score1 With:(SFGHiScore*)score2 AndContext:(void*) context;
-(NSComparisonResult) customCompare:(SFGHiScore*)score2;


@end
