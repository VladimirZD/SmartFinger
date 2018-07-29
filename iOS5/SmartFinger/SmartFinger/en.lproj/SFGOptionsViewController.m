//
//  SFGOptionsViewController.m
//  SmartFinger
//
//  Created by Lion User on 04/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGOptionsViewController.h"
#import "AppContext.h"

@interface SFGOptionsViewController ()
@end

@implementation SFGOptionsViewController

@synthesize learningMode;
@synthesize showSum;
@synthesize vibrate;
@synthesize sound;
@synthesize languagePickerView;

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
    
    
    arrayLanguages = [[NSMutableArray alloc] init];
    [arrayLanguages addObject:@"Croatian"];
    [arrayLanguages addObject:@"English"];
    [arrayLanguages addObject:@"System default"];
    
    
    
//    mlabel.text= [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];    

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
    [super viewWillAppear:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) saveSettings
{
    AppContext *appContext=[AppContext getInstance];
    
    appContext.learningMode=self.learningMode.on;
    appContext.vibrate=self.vibrate.on;
    appContext.sound=self.sound.on;
    appContext.showSum=self.showSum.on;
    appContext.language = [arrayLanguages objectAtIndex:[languagePickerView selectedRowInComponent:0]];
      
}

- (void) loadSettings
{
    AppContext *appContext=[AppContext getInstance];

    self.learningMode.on= appContext.learningMode;
    self.vibrate.on=appContext.vibrate;
    self.showSum.on=appContext.showSum;
    self.sound.on=appContext.sound;
    NSInteger index = [arrayLanguages indexOfObject:appContext.language];
    [languagePickerView selectRow:index inComponent:0 animated:NO];
    //[languagePickerView selectRow:1 inComponent:0 animated:NO];
    
    
}

- (void)viewDidUnload {
    [self setLearningMode:nil];
    [self setShowSum:nil];
    [self setSound:nil];
    [self setVibrate:nil];
    [self setLanguagePickerView:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
/*
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //mlabel.text=    [arrayNo objectAtIndex:row];
    
}
*/
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayLanguages count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayLanguages objectAtIndex:row];
}


@end
