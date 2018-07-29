//
//  SFGLanguageSelection.m
//  SmartFinger
//
//  Created by Lion User on 24/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGLanguageSelectionController.h"
#import "SFGAppContext.h"

@interface SFGLanguageSelectionController ()

@end

@implementation SFGLanguageSelectionController

@synthesize selectedLanguage;
@synthesize btnDone;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
  return self;
}

- (void)setSelectedLanguage:(NSString *)value
{
    selectedLanguage=value;
    SFGAppContext *appContext=[SFGAppContext getInstance];
    appContext.language=selectedLanguage;
}

- (void) viewWillAppear:(BOOL)animated  
{
   /*[btnDone setTitle:NSLocalizedString(@"DONE_BTN",nil) forState:UIControlStateNormal];*/
    [btnDone setTitle:[SFGAppContext getStringForKey:@"DONE_BTN"] forState:UIControlStateNormal];
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated 
{ 
    NSArray *cells = [self.tableView visibleCells];
    for (UITableViewCell *cell in cells)
    {
        NSString *labelText =cell.textLabel.text;
        if ([labelText isEqualToString:selectedLanguage])
        //if (labelText==selectedLanguage)
        {
            cell.selected=NO;
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            //lastSelectedCell=cell;
            NSIndexPath *indexPath =[self.tableView indexPathForCell:cell];
            [[self.tableView delegate] tableView:self.tableView didSelectRowAtIndexPath:indexPath];
          
       }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SFGAppContext *appContext=[SFGAppContext getInstance];
    self.selectedLanguage=appContext.language;
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setBtnDone:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    lastSelectedCell.accessoryType=UITableViewCellAccessoryNone;
    lastSelectedCell = [tableView cellForRowAtIndexPath:indexPath];
    lastSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedLanguage = lastSelectedCell.textLabel.text;
}

@end
