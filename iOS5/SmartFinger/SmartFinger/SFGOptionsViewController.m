//
//  SFGOptionsViewController.m
//  SmartFinger
//
//  Created by Lion User on 04/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGOptionsViewController.h"
#import "SFGAppContext.h"

@interface SFGOptionsViewController ()
@end

@implementation SFGOptionsViewController

@synthesize learningMode;
@synthesize showSum;
@synthesize vibrate;
@synthesize sound;
@synthesize selectedLanguageLabel;
@synthesize learningModeLabel;
@synthesize showSumLabel;
@synthesize vibrateLabel;
@synthesize languageLabel;
@synthesize soundLabel;
@synthesize optionsTitleLabel;
@synthesize btnBack;
@synthesize startLevelLabel;
@synthesize startLevel;


UIButton *_doneButton;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;   
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
    arrayLanguages = [[NSMutableArray alloc] init];
    [arrayLanguages addObject:@"Croatian"];
    [arrayLanguages addObject:@"English"];*/
    //  [arrayLanguages addObject:@"System default"];
    
    //[languagePickerView selectRow:1 inComponent:0 animated:NO];
    // mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self saveSettings];
   [super viewWillDisappear:(YES)];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self loadSettings];
       //[optionsTitleLabel setText: NSLocalizedString(@"OPTIONS_TITLE", nil)];
    
/*    
    [optionsTitleLabel setText: [SFGAppContext getStringForKey:@"OPTIONS_TITLE"]];
    [learningModeLabel setText: NSLocalizedString(@"LEARNING_MODE_TEXT", nil)];
    [soundLabel setText: NSLocalizedString(@"SOUND_TEXT", nil)];
    [showSumLabel setText: NSLocalizedString(@"SHOW_SUM_TEXT", nil)];
    [startLevelLabel setText: NSLocalizedString(@"OPTIONSTARTLEVEL", nil)];
    [vibrateLabel setText: NSLocalizedString(@"VIBRATE_TEXT", nil)];
    [languageLabel setText: NSLocalizedString(@"LANGUAGE_TEXT", nil)];
    [btnBack setTitle:NSLocalizedString(@"BACK_BTN",nil) forState:UIControlStateNormal];
    */
    
    [optionsTitleLabel setText:[SFGAppContext getStringForKey:@"OPTIONS_TITLE"]];
    [learningModeLabel setText:[SFGAppContext getStringForKey:@"LEARNING_MODE_TEXT"]];
    [soundLabel setText:[SFGAppContext getStringForKey:@"SOUND_TEXT"]];
    [showSumLabel setText:[SFGAppContext getStringForKey:@"SHOW_SUM_TEXT"]];
    [startLevelLabel setText:[SFGAppContext getStringForKey:@"OPTIONSTARTLEVEL"]];
    [vibrateLabel setText:[SFGAppContext getStringForKey:@"VIBRATE_TEXT" ]];
    [languageLabel setText:[SFGAppContext getStringForKey:@"LANGUAGE_TEXT"]];
    [btnBack setTitle:[SFGAppContext getStringForKey:@"BACK_BTN"] forState:UIControlStateNormal];
    
    
    
    
    [super viewWillAppear:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) saveSettings
{
    SFGAppContext *appContext=[SFGAppContext getInstance];
    
    appContext.learningMode=self.learningMode.on;
    appContext.vibrate=self.vibrate.on;
    appContext.sound=self.sound.on;
    appContext.showSum=self.showSum.on;
    appContext.startLevel=[self.startLevel.text intValue];
    
}

- (void) loadSettings
{
    SFGAppContext *appContext=[SFGAppContext getInstance];
    
    self.learningMode.on= appContext.learningMode;
    self.vibrate.on=appContext.vibrate;
    self.showSum.on=appContext.showSum;
    self.sound.on=appContext.sound;
    self.selectedLanguageLabel.text=[NSString stringWithFormat:@"%@",appContext.language];
    self.startLevel.text=[NSString stringWithFormat:@"%d",appContext.startLevel];
}

- (void)viewDidUnload {
    [self setLearningMode:nil];
    [self setShowSum:nil];
    [self setSound:nil];
    [self setVibrate:nil];
 
    [self setSelectedLanguageLabel:nil];
    [self setLearningModeLabel:nil];
    [self setShowSumLabel:nil];
    [self setSoundLabel:nil];
    [self setVibrateLabel:nil];
    [self setLanguageLabel:nil];
    [self setOptionsTitleLabel:nil];
    [self setBtnBack:nil];
    [self setStartLevelLabel:nil];
    [self setStartLevel:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
    [textField resignFirstResponder];
    return NO;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL retValue=YES;
    /*
    if ([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
    }
     */
    
    if (![string isEqualToString:@""])
    {
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"12345678"];
        for (int i = 0; i < [string length]; i++) {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c]) {
                retValue = NO;
            }
        }
    }
    return retValue;
}

@end
