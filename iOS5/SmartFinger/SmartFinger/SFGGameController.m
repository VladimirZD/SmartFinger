//
//  SFGGameController.m
//  SmartFinger
//
//  Created by Lion User on 28/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "SFGGameController.h"
#import "SFGHiScore.h"
#import "SFGColorProvider.h"
#import "SFGAppContext.h"
#import "SFGLevel.h"
#import "SFGEffectBase.h"
#import "SFGLevelManager.h"
#include <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SFGGameController ()

@end

@implementation SFGGameController

NSString *const ACTIVE_STAR = @"ZvijezdaCrnaBijeliRub.png";
NSString *const SOLVED_STAR = @"ZvijezdaZelena.png";
NSString *const INACTIVE_STAR = @"ZvijezdaCrnaJaceSiviRub.png";
NSString *const NOTSELECTED_IMAGE=@"KrugPlavi.png";
NSString *const SELECTED_IMAGE=@"KrugZeleni.png";
NSString *const SOUND_CORRECT = @"correct.m4a";
NSString *const SOUND_LEVELCOMPLETED =@"Level.m4a";
NSInteger const ALERT_TIMEUP =1;
NSInteger const ALERT_PLAYER_NAME =2;
NSInteger const ALERT_NEWGAME_QUESTION =3;


@synthesize levelLabel;
@synthesize sumLabel;
@synthesize resumeGame;
@synthesize progresTime;
@synthesize btnTargetSum;
@synthesize currentSumLabel;
@synthesize btnDown;
@synthesize btnUp;
@synthesize btnLeft;
@synthesize btnRight;


NSInteger _colorChangeValue = 0;
NSInteger _currentLevelIndex =1;
NSInteger _currentStar =1;
NSInteger _targetResult =1;
NSInteger _currentSum =0;
NSArray *_timeColors;
NSMutableDictionary *_validNumbers=nil;  
NSTimer *pollingTimer;
SFGLevel *_currentLevel;
NSDate *_taskStartTime;
AVAudioPlayer *audioPlayer;
SFGEffectBase *_lastEffect=nil;
SFGHiScore *_score;
GADBannerView *bannerView_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                                            self.view.frame.size.height -
                                            GAD_SIZE_320x50.height,
                                            GAD_SIZE_320x50.width,
                                            GAD_SIZE_320x50.height)];
    
    /*bannerView_=[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];*/
    bannerView_.adUnitID=@"a150ff076744c8a";
    bannerView_.rootViewController=self;
    [self.view addSubview:bannerView_];
    [self RequestAdd];
}
- (void)viewDidUnload
{
    [self setLevelLabel:nil];
    [self setSumLabel:nil];
    [self setBtnDown:nil];
    [self setBtnUp:nil];
    [self setBtnLeft:nil];
    [self setBtnRight:nil];
    [self setProgresTime:nil];
    [self setProgresTime:nil];
    [self setBtnTargetSum:nil];
    [self setCurrentSumLabel:nil];
 
    audioPlayer=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) viewWillAppear:(BOOL)animated       
{
    [super viewWillAppear:animated];
    [self Initialize];
    [self SetLevelLabelText];
    //[sumLabel setText:NSLocalizedString(@"SUM_TEXT",nil)];
    [sumLabel setText:[SFGAppContext getStringForKey:@"SUM_TEXT"]];
}

-(void) SetLevelLabelText
{
    NSString *text =[SFGAppContext getStringForKey:@"LEVEL_TEXT"];
    text = [text stringByAppendingString:[NSString stringWithFormat:@" %d", _currentLevelIndex]];
    [levelLabel setText:text];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self StopTimer];
    [super viewWillDisappear:animated];
    SFGAppContext *context=[SFGAppContext getInstance];
    context.currentStar=_currentStar;
    context.currentLevel=_currentLevelIndex;
    context.currentLevelTime=progresTime.progress*LEVELTIME;
}

-(void) Initialize
{
    SFGAppContext *context = [SFGAppContext getInstance];
    _colorChangeValue = floor( LEVELTIME / 3);
    _timeColors =[[NSArray alloc] initWithObjects:[SFGColorProvider CustomRed],[SFGColorProvider CustomYellow],[SFGColorProvider CustomGreen],nil];
    if (self.resumeGame)
    {
        _currentLevelIndex=context.currentLevel;
        _currentStar=context.currentStar;
        [self SetProgresBarValue:context.currentLevelTime];
    }
    else
    {
        _currentLevelIndex=context.startLevel;
        _currentStar=1;
        [self SetProgresBarValue:LEVELTIME];
    }
        
    
    _validNumbers= [NSMutableDictionary dictionary];
    [self SetButtonImages];
    [self SetupLevel];

    context.buttons = [[NSMutableDictionary alloc]init];
    [context.buttons setValue:self.btnUp forKey:btnUp.description];
    [context.buttons setValue:self.btnRight forKey:btnRight.description];
    [context.buttons setValue:self.btnDown forKey:btnDown.description];
    [context.buttons setValue:self.btnLeft forKey:btnLeft.description];
    currentSumLabel.hidden=!context.showSum;
    sumLabel.hidden=currentSumLabel.hidden;   
}

-(void) SetButtonImages
{
    UIImage *notSelectedImage = [UIImage imageNamed: NOTSELECTED_IMAGE];
    UIImage *selectedImage = [UIImage imageNamed: SELECTED_IMAGE];
    
    [self.btnUp setBackgroundImage:selectedImage  forState:UIControlStateSelected];
    [self.btnUp setBackgroundImage:notSelectedImage  forState:UIControlStateNormal];
    [self.btnRight setBackgroundImage:selectedImage  forState:UIControlStateSelected];
    [self.btnRight setBackgroundImage:notSelectedImage  forState:UIControlStateNormal];
    [self.btnDown setBackgroundImage:selectedImage  forState:UIControlStateSelected];
    [self.btnDown setBackgroundImage:notSelectedImage  forState:UIControlStateNormal];
    [self.btnLeft setBackgroundImage:selectedImage  forState:UIControlStateSelected];
    [self.btnLeft setBackgroundImage:notSelectedImage  forState:UIControlStateNormal];
}


-(void) SetupLevel
{
    [self UpdateStars];
    [self InitLevel];
}

-(void) UpdateStars
{
    UIView *view = [self view];
    UIImage *image = nil;
    for (UIImageView *img in [view subviews])
    {
        if (img.tag>0)
        {
            if (img.tag<_currentStar)
            {
                image = [UIImage imageNamed: SOLVED_STAR];
            }
            else if (img.tag==_currentStar)
            {
                image = [UIImage imageNamed: ACTIVE_STAR];
            }
            else 
            {
                image = [UIImage imageNamed: INACTIVE_STAR];
            }
            
            [img setImage:image];
        }
    }
    image = nil;
}



-(void)InitLevel
{
    //[self SetProgresBarValue:LEVELTIME];
    [self GenerateTask];
    [self StartTimer];
}

-(void) StopLevel
{
    [self StopTimer];
    [self ShowAlert: [SFGAppContext getStringForKey:@"TIMEUPMESSAGE"] WithTag:ALERT_TIMEUP CancelButtonTitle:@"OK" OtherButtonsTitle:nil];
    [self DeselectAll];
}


-(void) ShowAlert:(NSString*)message WithTag:(NSInteger)tag CancelButtonTitle:(NSString*)cancelTitle OtherButtonsTitle:(NSString*)otherTitles
{
    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitles,nil];
    mes.tag=tag;
    [mes setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1]];
    [mes show];

}

-(void) ShowDialog:(NSString*)message AndTitle:(NSString*)title WithTag:(NSInteger)tag WithDefaultTextValue:(NSString*)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].text=text;
    alertView.tag=tag;
    [alertView show];
}

-(void) SaveHighScore:(NSString*)playerName;
{
    _score.Name=playerName;
    SFGAppContext *context = [SFGAppContext getInstance];
    context.LastPlayerName=playerName;
    [SFGAppContext AddHighScore:_score];
}   

-(void) CheckHighScore
{
    SFGAppContext *context = [SFGAppContext getInstance];
    _score= [[SFGHiScore alloc] initWithLevel:(int) _currentLevelIndex AndStars:(int) _currentStar-1];
    _score.learningMode=context.learningMode;
    _score.showSum=context.showSum;
    _currentStar=1;
    _currentLevelIndex=1;
    if ([self IsNewHighScore:_score] && (context.startLevel==1))
    {

        [self ShowDialog:[SFGAppContext getStringForKey:@"PLAYERNAMETITLE"] AndTitle:[SFGAppContext getStringForKey:@"GRATSMSG"] WithTag:ALERT_PLAYER_NAME WithDefaultTextValue:context.lastPlayerName];
    }
    else
    {
        [self SetProgresBarValue:LEVELTIME];
        [self SetupLevel];
        
    }
        
}


-(BOOL) IsNewHighScore:(SFGHiScore*)score
{
    BOOL retValue=[SFGAppContext IsNewHighScore:score];
    return retValue;
}



-(void) StopTimer
{
    [pollingTimer invalidate];
    pollingTimer = nil;
}

-(void) StartTimer
{
    //Ako bude problema mogu staviti da se ne ponavlja nego nakon svakog ticket ponovo ga startati... a sa NSDATE pratiti je li proslo 30 sec...
    [self  StopTimer];
    pollingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerTick) userInfo:nil repeats:YES];
}

- (void) TimerTick
{
    NSInteger time = 0;
    SFGAppContext *context = [SFGAppContext getInstance];
    [context.buttons setValue:self.btnUp forKey:btnUp.description];
    
    if (!context.learningMode)
    {
        time = self.progresTime.progress*LEVELTIME-1;
    
        if (time>=0)
        {
            [self SetProgresBarValue:time];
        }
        else 
        {
            [self StopLevel];
        }
    }
    
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:_taskStartTime];
   
    BOOL active=_lastEffect.IsActive;
    if (elapsedTime>5 && (_lastEffect == nil || !active))
    {
        SFGEffectBase *effect = [SFGLevelManager getRandomEffect:_currentLevel];
        if (effect!=nil)
        {
            [effect Execute];
            _lastEffect=effect;
        }
    }

   
    /*svakih 10 sekundi novi add*/
    if ((((int)elapsedTime) % 10)==0)
    {
        [self RequestAdd];
    }
}
     
-(void) SetProgresBarValue:(float) value
{
    float progress = value/LEVELTIME;   
    [self.progresTime setProgress: progress];
    [self SetProgressBarColor];
}

-(void) SetProgressBarColor
{
    float prog=self.progresTime.progress;
    prog=prog*LEVELTIME;
    NSInteger colorIndex = prog / _colorChangeValue;
    if (colorIndex > 2) colorIndex = 2;
    UIColor *color = [_timeColors objectAtIndex:colorIndex];
    [self.progresTime setProgressTintColor:color]; 
}

-(void) GenerateTask
{
    NSMutableDictionary *originalValues = [NSMutableDictionary dictionary];
    
    _currentLevel = [[SFGLevelManager getLevels] objectForKey:[NSString stringWithFormat:@"%d",_currentLevelIndex]];
    
    int index = 0;
    int number;
    
    int maxValue = _currentLevel.MaxValue;
    int minValue = _currentLevel.MinValue;
    int minElements =_currentLevel.MinElements;
    int maxElements =_currentLevel.MaxElements;
    [self UpdateStars];
    
    
    _targetResult = 0;
    _currentSum = 0;
    [self.currentSumLabel setText:[NSString stringWithFormat:@"%d",_currentSum]];
    [_validNumbers removeAllObjects];
    
    while (index<4) 
    {
        number = [SFGAppContext getRandomNumberFrom:minValue To:maxValue];
        NSString *key=[NSString stringWithFormat:@"%d",number];
        if (number != 0 && [originalValues objectForKey:key]==nil)
        {
            NSNumber *num = [NSNumber numberWithInteger:number];
            [originalValues setObject:num forKey:key];
            index++;
        }
    }
    
    NSMutableDictionary *finalValues = [[NSMutableDictionary alloc] initWithDictionary:originalValues]; 
    
    NSInteger elementCount =[SFGAppContext getRandomNumberFrom:minElements To:maxElements];
    NSArray *keys =[originalValues allKeys];

    while (elementCount > 0)
    {
        index =[SFGAppContext getRandomNumberFrom:0 To:[keys count]-1];
        number = [[originalValues objectForKey:[keys objectAtIndex:index]] integerValue];
        _targetResult = _targetResult +number; 
        NSString *key =[NSString stringWithFormat:@"%d",number];
        [_validNumbers setObject:[NSNumber numberWithInteger:number] forKey:key];
        [originalValues removeObjectForKey:key];
        elementCount--;
    }
    
    keys =[finalValues allKeys];

    NSString *title = [NSString stringWithFormat:@"%d",[[finalValues objectForKey:[keys objectAtIndex:0]] integerValue]];
    [self.btnUp setTitle:title forState:UIControlStateNormal];
    [self.btnUp setTitle:title forState:UIControlStateSelected];

    title = [NSString stringWithFormat:@"%d",[[finalValues objectForKey:[keys objectAtIndex:1]] integerValue]];
    [self.btnRight setTitle:title forState:UIControlStateNormal];
    [self.btnRight setTitle:title forState:UIControlStateSelected];

    title = [NSString stringWithFormat:@"%d",[[finalValues objectForKey:[keys objectAtIndex:2]] integerValue]];
    [self.btnDown setTitle:title forState:UIControlStateNormal];
    [self.btnDown setTitle:title forState:UIControlStateSelected];
    
    title = [NSString stringWithFormat:@"%d",[[finalValues objectForKey:[keys objectAtIndex:3]] integerValue]];
    [self.btnLeft setTitle:title forState:UIControlStateNormal];
    [self.btnLeft setTitle:title forState:UIControlStateSelected];
    
    [self.btnTargetSum setTitle:[NSString stringWithFormat:@"%d",_targetResult] forState:UIControlStateNormal];    
    _taskStartTime=[NSDate date];
}

-(void) UpdateCurrentSum:(NSInteger) value
{
    _currentSum=_currentSum+value;
    [self.currentSumLabel setText:[NSString stringWithFormat:@"%d",_currentSum]];
    [self CheckResult];
}

-(void) CheckResult
{
    if(_currentSum==_targetResult)
    {
        NSInteger time = self.progresTime.progress*LEVELTIME+_currentLevel.BonusTime;
        if(time>LEVELTIME)
        {
            time=LEVELTIME;
        }
        [self SetProgresBarValue:time];
        [self DeselectAll];
        [self StopAllEffects];
        if (_currentStar==10)
        {
            [self PlaySound:SOUND_LEVELCOMPLETED];
            _currentLevelIndex++;
            [self SetLevelLabelText];
            _currentStar = 1;
            if(_currentLevelIndex<=[[SFGLevelManager getLevels] count]-1)
            {
                [self InitLevel];
            }
            else 
            {
              [self CheckHighScore];
              [self EndGame];
            }
        }
        else 
        {
            [self PlaySound:SOUND_CORRECT]; 
            _currentStar++;
            [self GenerateTask];
        }
        [self UpdateStars];
        
    }
}

-(void) StopAllEffects
{

    
    if (_currentLevel!=nil && _currentLevel.Effects!=nil) 
    {
        for (int i = 0; i < [_currentLevel.Effects count]; i++)
        {
            SFGEffectBase *effect =[_currentLevel.Effects objectForKey:[NSString stringWithFormat:@"%d",i]];
            [effect Stop];
        }
    }
}

-(void) DeselectAll
{
    self.btnUp.selected=NO;
    self.btnRight.selected=NO;
    self.btnDown.selected=NO;
    self.btnLeft.selected=NO;
}
  

-(void) PlaySound:(NSString*) fileName 
{
   /*
    NSURL *chemin = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/MySound.wav", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    AVAudioPlayer* mySound = [[AVAudioPlayer alloc] initWithContentsOfURL:chemin error:&error];
    mySound.delegate = self;
    [chemin release];
    [mySound Play];
    */
    if([SFGAppContext getInstance].sound)
    {
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fileName]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops = 1;
        //audioPlayer.delegate = self;
        //audioPlayer.volume=1;
	
        if (audioPlayer == nil)
        {
            NSLog(@"%@",[error description]);	
        }
        else
        {
            [audioPlayer play];
        }
    }
    if ([SFGAppContext getInstance].vibrate)
    {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }
}

-(void) OnButtonToggled:(UIButton*) button
{
    NSInteger value= [button.currentTitle intValue];
    if(!button.selected)
    {
        value=value*-1;
    }
    
    
    [self UpdateCurrentSum:value];
}

- (IBAction)btnUpTouchUPInside:(id)sender 
{
    self.btnUp.selected=!self.btnUp.selected;
    [self OnButtonToggled:sender];
}

- (IBAction)btnRightTouchUPInside:(id)sender 
{
    self.btnRight.selected=!self.btnRight.selected;
    [self OnButtonToggled:sender];
}

- (IBAction)btnDownTouchUPInside:(id)sender 
{
    self.btnDown.selected=!self.btnDown.selected;
    [self OnButtonToggled:sender];
}

- (IBAction)btnLeftTouchUPInside:(id)sender 
{
    self.btnLeft.selected=!self.btnLeft.selected;
    [self OnButtonToggled:sender];
}


-(void) EndGame
{
   // [self StopLevel];
    [self performSegueWithIdentifier: @"Pause" sender: self];
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == ALERT_TIMEUP)
    {
        [self CheckHighScore];
    }
    if (alertView.tag == ALERT_PLAYER_NAME)
    {
        if(buttonIndex==1)
        {
            NSString* playerName=[[alertView textFieldAtIndex:0] text];
            [self SaveHighScore:playerName];
        }
            [self ShowNewGameQuestion];
        }
    if (alertView.tag ==ALERT_NEWGAME_QUESTION)
    {
        if(buttonIndex==1)
        {
            [self SetProgresBarValue:LEVELTIME];
            [self SetupLevel];
        }  
        else
        {
            [self EndGame];
        }
    }
}

-(void) ShowNewGameQuestion
{
    [self ShowAlert:[SFGAppContext getStringForKey:@"NEWGAMEQUESTION"] WithTag:ALERT_NEWGAME_QUESTION CancelButtonTitle:@"No" OtherButtonsTitle:@"Yes"];
}

-(void) RequestAdd
{
    GADRequest *request = [GADRequest request];
    
    // Make the request for a test ad. Put in an identifier for
    // the simulator as well as any devices you want to receive test ads.
    /*request.testDevices = [NSArray arrayWithObjects:
     @"YOUR_SIMULATOR_IDENTIFIER",
     @"YOUR_DEVICE_IDENTIFIER",
     nil];*/
//    NSString *location =[NSLocale currentLocale];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCodes = [locale objectForKey:NSLocaleCountryCode];
    NSString *countryName = [locale displayNameForKey:NSLocaleCountryCode value:countryCodes];
    
    //NSLog(@"%@",countryName);
    [request setLocationWithDescription:countryName];
    request.testing=YES;
    [bannerView_ loadRequest:request];
}

@end
