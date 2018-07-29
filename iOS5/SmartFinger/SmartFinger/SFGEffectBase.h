//
//  SFGEffectBase.h
//  SmartFinger
//
//  Created by Lion User on 18/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFGEffectBase : NSObject

- (void) Execute;
- (void) Execute: (NSMutableDictionary*) controls;
- (void) Stop;
- (BOOL) IsActive;

@property (nonatomic, assign) NSInteger Duration;
@property (retain, nonatomic) NSString* Name;
@property (retain, nonatomic) NSDate* StartTime;


@end
