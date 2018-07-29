//
//  AppContext.h
//  DrillDownSave
//
//  Created by Lion User on 06/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGHiScore.h"

@interface SFGAppContext : NSObject

extern NSString *const LEARNINGMODE;
extern NSString *const SHOWSUM;
extern NSString *const VIBRATE;
extern NSString *const SOUND;
extern NSString *const LANGUAGE;
extern int const LEVELTIME;


@property (assign, nonatomic) BOOL learningMode;
@property (assign, nonatomic) BOOL showSum;
@property (assign, nonatomic) BOOL vibrate;
@property (assign, nonatomic) BOOL sound;
@property (assign, nonatomic) NSInteger currentStar;
@property (assign, nonatomic) NSInteger currentLevel;
@property (assign, nonatomic) NSInteger startLevel;
@property (strong, nonatomic) NSMutableDictionary *hiScores;
@property (assign, nonatomic) NSInteger currentLevelTime;
@property (strong, nonatomic) NSString *lastPlayerName;
@property (strong, nonatomic) NSString *language;
@property (strong, nonatomic) NSMutableDictionary *buttons;

+(SFGAppContext*) getInstance;
+(int) getRandomNumberFrom:(int) minvalue  To:(int) maxvalue;
+(NSObject*) getRandomElementFromDictionary:(NSMutableDictionary*) dictionary;
+(UIButton*) getRandomUIButton:(NSMutableDictionary*) buttons;
+(void) AddHighScore:(SFGHiScore*) hiScore;
+(BOOL) IsNewHighScore:(SFGHiScore*) hiScore;
+(NSString*) getStringForKey:(NSString*) key;

- (void) saveSettings;
@end
