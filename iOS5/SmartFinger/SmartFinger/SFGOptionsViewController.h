//
//  SFGOptionsViewController.h
//  SmartFinger
//
//  Created by Lion User on 04/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFGOptionsViewController : UITableViewController <UITextFieldDelegate> //<UIPickerViewDelegate, UIPickerViewDataSource>

{
    NSMutableArray *arrayLanguages;
}

@property (strong, nonatomic) IBOutlet UISwitch *learningMode;
@property (strong, nonatomic) IBOutlet UISwitch *showSum;
@property (strong, nonatomic) IBOutlet UISwitch *vibrate;
@property (strong, nonatomic) IBOutlet UISwitch *sound;
@property (strong, nonatomic) IBOutlet UILabel *selectedLanguageLabel;
@property (strong, nonatomic) IBOutlet UILabel *learningModeLabel;
@property (strong, nonatomic) IBOutlet UILabel *showSumLabel;
@property (strong, nonatomic) IBOutlet UILabel *vibrateLabel;
@property (strong, nonatomic) IBOutlet UILabel *languageLabel;
@property (strong, nonatomic) IBOutlet UILabel *soundLabel;
@property (strong, nonatomic) IBOutlet UILabel *optionsTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *startLevelLabel;
@property (strong, nonatomic) IBOutlet UITextField *startLevel;




@end
