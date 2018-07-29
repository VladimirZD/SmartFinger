//
//  SFGLevelManager.h
//  SmartFinger
//
//  Created by Lion User on 01/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFGLevel.h"
#import "SFGEffectBase.h"



@interface SFGLevelManager : NSObject

+ (SFGEffectBase*) getRandomEffect: (SFGLevel*) level;
+ (NSMutableDictionary*) getLevels;

 
@end
