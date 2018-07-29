//
//  SFGGameController.h
//  SmartFinger
//
//  Created by Lion User on 28/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GADBannerView.h"


@interface SFGGameController : UIViewController <UIAlertViewDelegate>
//{
  //  GADBannerView *bannerView_;
//}

@property (strong, nonatomic) IBOutlet UILabel *levelLabel;
@property (strong, nonatomic) IBOutlet UILabel *sumLabel;
@property (strong, nonatomic) IBOutlet UIButton *btnDown;
@property (strong, nonatomic) IBOutlet UIButton *btnUp;
@property (strong, nonatomic) IBOutlet UIButton *btnLeft;
@property (strong, nonatomic) IBOutlet UIButton *btnRight;
@property (strong, nonatomic) IBOutlet UIProgressView *progresTime;
@property (strong, nonatomic) IBOutlet UIButton *btnTargetSum;
@property (strong, nonatomic) IBOutlet UILabel *currentSumLabel;

- (IBAction)btnUpTouchUPInside:(id)sender;
- (IBAction)btnRightTouchUPInside:(id)sender;
- (IBAction)btnDownTouchUPInside:(id)sender;
- (IBAction)btnLeftTouchUPInside:(id)sender;

@property (nonatomic, assign) BOOL resumeGame;




@end
