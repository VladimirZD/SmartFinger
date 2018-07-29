//
//  SFGSwapEffect.m
//  SmartFinger
//
//  Created by Lion User on 18/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGSwapEffect.h"

@implementation SFGSwapEffect

UIButton *_lastButton;
NSString *title;

- (id) init
{
    self = [super init];
    self.Name=@"Swap effect";
    return self;
}

-(void) Execute
{
    [self Stop];
    SFGAppContext  *context = [SFGAppContext getInstance];
    NSMutableDictionary *buttons = [[NSMutableDictionary alloc] initWithDictionary:context.buttons]; 
    
    UIButton *firstButton=[SFGAppContext getRandomUIButton:buttons];
    UIButton *secondButton=[SFGAppContext getRandomUIButton:buttons];
    
    if (firstButton!=nil && secondButton!=nil)
    {
        NSString *title = firstButton.currentTitle;
        [firstButton setTitle:secondButton.currentTitle forState:UIControlStateNormal];
        [firstButton setTitle:secondButton.currentTitle forState:UIControlStateSelected];
        
        [secondButton setTitle:title forState:UIControlStateNormal];
        [secondButton setTitle:title forState:UIControlStateSelected];
    }
    
    [super Execute];
}

-(void) Stop
{
    [self Reset];
    [super Stop];
}

-(void) Reset
{
   //
}
@end
