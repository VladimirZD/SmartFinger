//
//  SFGHiScoreController.m
//  SmartFinger
//
//  Created by Lion User on 28/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGHiScoreController.h"

@interface SFGHiScoreController ()

@end

@implementation SFGHiScoreController
@synthesize titleLabel;
@synthesize btnBack;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setBtnBack:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) viewWillAppear:(BOOL)animated
{
    /*[btnBack setTitle:NSLocalizedString(@"BACK_BTN",nil) forState:UIControlStateNormal];
    [titleLabel setText:NSLocalizedString(@"HIGH_SCORE_TITLE",nil)];
    */
    [btnBack setTitle:[SFGAppContext getStringForKey:@"BACK_BTN"] forState:UIControlStateNormal];
    [titleLabel setText:[SFGAppContext getStringForKey:@"HIGH_SCORE_TITLE"]];
    
    [super viewWillAppear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger retValue = [[SFGAppContext getInstance].hiScores count]; 
    return retValue;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"HiScore";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	/*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
	}
    
    */
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MyIdentifier];
    
    NSMutableDictionary *scores =[SFGAppContext getInstance].hiScores;
    //NSArray *keys =[scores allKeys];
    SFGHiScore *score = [scores objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    NSString *star =(score.LearningMode || score.ShowSum) ? @"*":@"";
   
    NSString *totalScore =[NSString stringWithFormat:@"%d%@",[score GetTotalScore],star];
    
    //NSInteger index = indexPath.row+1;
    //NSString *player = score.Name;
    
    NSString *playerName  =[NSString stringWithFormat:@"%d. %@", indexPath.row+1, score.Name];  
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16]; 
    
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16]; 
    [cell.detailTextLabel setTextAlignment:UITextAlignmentRight];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",totalScore];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",playerName]; 
    return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

@end
