//
//  SFGInstructionsController.m
//  SmartFinger
//
//  Created by Lion User on 28/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGInstructionsController.h"

@interface SFGInstructionsController ()

@end

@implementation SFGInstructionsController
@synthesize btnBack;
@synthesize titleLabel;
@synthesize instrTextBlue;
@synthesize instrTextGreen;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBtnBack:nil];
    [self setTitleLabel:nil];
    [self setInstrTextBlue:nil];
    [self setInstrTextGreen:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillAppear:(BOOL)animated
{
   /* [btnBack setTitle:NSLocalizedString(@"BACK_BTN",nil) forState:UIControlStateNormal];
    [titleLabel setText:NSLocalizedString(@"INSTRUCTIONS_TITLE",nil)];
    [instrTextBlue setText:NSLocalizedString(@"INSTRUCTIONS_BLUE_TEXT",nil)];
    [instrTextGreen setText:NSLocalizedString(@"INSTRUCTIONS_GREEN_TEXT",nil)];
    */
    
    [btnBack setTitle:[SFGAppContext getStringForKey:@"BACK_BTN"] forState:UIControlStateNormal];
    [titleLabel setText:[SFGAppContext getStringForKey:@"INSTRUCTIONS_TITLE"]];
    [instrTextBlue setText:[SFGAppContext getStringForKey:@"INSTRUCTIONS_BLUE_TEXT"]];
    [instrTextGreen setText:[SFGAppContext getStringForKey:@"INSTRUCTIONS_GREEN_TEXT"]];
    
    [super viewWillAppear:YES];
}

@end
