//
//  SFGLanguageSelection.h
//  SmartFinger
//
//  Created by Lion User on 24/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFGLanguageSelectionController : UITableViewController
{
    UITableViewCell *lastSelectedCell;
}
@property (strong, nonatomic) NSString *selectedLanguage;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@end
