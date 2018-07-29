//
//  SFGMainMenuController.m
//  SmartFinger
//
//  Created by Lion User on 27/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.

//



#import "SFGMainMenuController.h"
#import "SFGGameController.h"
#import "SFGAppContext.h"


@interface SFGMainMenuController ()

@property (strong, nonatomic) IBOutlet UIButton *btnNewGame;
@property (strong, nonatomic) IBOutlet UIButton *btnResumeGame;
@property (strong, nonatomic) IBOutlet UIButton *btnInstructions;
@property (strong, nonatomic) IBOutlet UIButton *btnHighScire;
@property (strong, nonatomic) IBOutlet UIButton *btnOptions;

@end

@implementation SFGMainMenuController



@synthesize btnNewGame;
@synthesize btnResumeGame;
@synthesize btnInstructions;
@synthesize btnHighScire;
@synthesize btnOptions;



- (void)viewDidUnload {
    [self setBtnNewGame:nil];
    [self setBtnResumeGame:nil];
    [self setBtnInstructions:nil];
    [self setBtnHighScire:nil];
    [self setBtnOptions:nil];
    [super viewDidUnload];
}

-(void) viewWillAppear:(BOOL)animated   
{
/*
    [btnNewGame setTitle:NSLocalizedString(@"GAME_NEW_BTN", nil) forState:UIControlStateNormal];
    [btnResumeGame setTitle:NSLocalizedString(@"GAME_RESUME_BTN", nil) forState:UIControlStateNormal];
    [btnInstructions setTitle:NSLocalizedString(@"GAME_INSTRUCTIONS_BTN", nil) forState:UIControlStateNormal];
    [btnHighScire setTitle:NSLocalizedString(@"GAME_HISCORE_BTN", nil) forState:UIControlStateNormal];
    [btnOptions setTitle:NSLocalizedString(@"GAME_OPTIONS_BTN", nil) forState:UIControlStateNormal];
 */ 
    [btnNewGame setTitle:[SFGAppContext getStringForKey:@"GAME_NEW_BTN"] forState:UIControlStateNormal];
    [btnResumeGame setTitle:[SFGAppContext getStringForKey:@"GAME_RESUME_BTN"] forState:UIControlStateNormal];
    [btnInstructions setTitle:[SFGAppContext getStringForKey:@"GAME_INSTRUCTIONS_BTN"] forState:UIControlStateNormal];
    [btnHighScire setTitle:[SFGAppContext getStringForKey:@"GAME_HISCORE_BTN"] forState:UIControlStateNormal];
    [btnOptions setTitle:[SFGAppContext getStringForKey:@"GAME_OPTIONS_BTN"] forState:UIControlStateNormal];
    
    [super viewWillAppear:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ResumeGame"])
    {   
        SFGGameController *destControler=segue.destinationViewController;
        destControler.resumeGame=YES;
    }
    
}



@end
