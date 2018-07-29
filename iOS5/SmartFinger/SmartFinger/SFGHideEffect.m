//
//  SFGHiddeEffect.m
//  SmartFinger
//
//  Created by Lion User on 18/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGHideEffect.h"
#import "SFGAppContext.h"
#import <UIKit/UIKit.h>

@implementation SFGHideEffect

UIButton *_lastButton;
NSString *title;


- (id) init
{
    self = [super init];
    self.Name=@"Hide effect";
    return self;
}

-(BOOL) IsActive
{
    return [super IsActive];
}

-(void) Execute
{
    [self Stop];
    SFGAppContext  *context = [SFGAppContext getInstance];
    NSMutableDictionary *buttons = [[NSMutableDictionary alloc] initWithDictionary:context.buttons]; 
    if (_lastButton !=nil)
    {
        [buttons removeObjectForKey:_lastButton.description];
        _lastButton=nil;
    }
   /* 
    while (_lastButton==nil && [buttons count]>0)
    {
        _lastButton = (UIButton*)[SFGAppContext getRandomElementFromDictionary:buttons];
        if (_lastButton.selected)
        {
            [buttons removeObjectForKey:_lastButton.description];
            _lastButton=nil;
        }
    }*/
    _lastButton= [SFGAppContext getRandomUIButton:buttons];
    if (_lastButton!=nil)
    {
        _lastButton.titleLabel.hidden=YES;
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
   if(_lastButton!=nil)
   {
       _lastButton.titleLabel.hidden=NO;
   }
}
@end
