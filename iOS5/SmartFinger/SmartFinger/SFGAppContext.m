//
//  AppContext.m
//  DrillDownSave
//
//  Created by Lion User on 06/10/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGAppContext.h"

@implementation SFGAppContext

 
/*
FOUNDATION_EXPORT NSString *const LEARNINGMODE;
FOUNDATION_EXPORT NSString *const SHOWSUM;
FOUNDATION_EXPORT NSString *const VIBRATE;
FOUNDATION_EXPORT NSString *const SOUND;
FOUNDATION_EXPORT NSString *const LANGUAGE;
*/
NSString *const LEARNINGMODE = @"LearningMode";
NSString *const SHOWSUM = @"ShowSum";
NSString *const VIBRATE = @"Vibrate";
NSString *const SOUND = @"Sound";
NSString *const CURRENTSTAR = @"CurrentStar";
NSString *const CURRENTLEVEL = @"CurrentLevel";
NSString *const STARTLEVEL = @"StartLevel";
NSString *const HISCORES = @"HiScores";
NSString *const CURRENTLEVELTIME = @"CurrentLevelTime";
NSString *const LASTPLAYERNAME = @"LastPlayerName";
NSString *const LANGUAGE = @"Language";


NSInteger const LEVELTIME=30;

@synthesize learningMode;
@synthesize showSum;
@synthesize vibrate;
@synthesize sound;
@synthesize currentStar;
@synthesize currentLevel;
@synthesize startLevel;
@synthesize hiScores;
@synthesize currentLevelTime;
@synthesize lastPlayerName;
@synthesize language;
@synthesize buttons;

static SFGAppContext *appContextInstance = nil;


NSDictionary *appDefaults;

+ (SFGAppContext*) getInstance
{
    if (appContextInstance == nil) {
        appContextInstance = [[super alloc] init];
        [appContextInstance initUserSettings];
    }
    return appContextInstance;
}


+(int) getRandomNumberFrom:(int) minvalue  To:(int) maxvalue;
{
    int res=( (arc4random() % (maxvalue-minvalue+1)) + minvalue );
    return res;
}

- (void) saveSettings
{
 	[[NSUserDefaults standardUserDefaults] synchronize];
   
}

-(void) initUserSettings
{
    language = [[NSUserDefaults standardUserDefaults] stringForKey:@"Language"];

	if (language == nil)
	{
		self.learningMode=NO;
        self.showSum=NO;
        self.vibrate=NO;
        self.sound=YES;
        self.currentStar=1;
        self.startLevel=1;
        self.currentLevel=1;
      //  self.hiScores=@"";
        self.currentLevelTime=LEVELTIME;
        self.lastPlayerName=@"Vl@d";
        // Nema snimljenih postavki pa idemo napucati defaulte
        language=[[NSLocale currentLocale] displayNameForKey:NSLocaleIdentifier value:[[NSLocale preferredLanguages] objectAtIndex:0]];
      
        
    	NSDictionary *appSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:learningMode],LEARNINGMODE
                                     ,[NSNumber numberWithBool:showSum],SHOWSUM
                                     ,[NSNumber numberWithBool:vibrate],VIBRATE
                                     ,[NSNumber numberWithBool:sound],SOUND
                                     ,[NSNumber numberWithInt:currentStar],CURRENTSTAR
                                     ,[NSNumber numberWithInt:startLevel],STARTLEVEL
                                     ,[NSNumber numberWithInt:currentLevel],CURRENTLEVEL
                                     ,[NSNumber numberWithInt:currentLevelTime],CURRENTLEVELTIME
                                     ,lastPlayerName,LASTPLAYERNAME
                                     ,language,LANGUAGE
                                     ,nil];
                                    // ,startLevel,STARTLEVEL
                                   //  ,hiScores,HISCORES
                                    // ,currentLevelTime,CURRENTLEVELTIME
                                    // ,lastPlayerName,LASTPLAYERNAME
                                    //,language,LANGUAGE
                                    // ,nil];
		[[NSUserDefaults standardUserDefaults] registerDefaults:appSettings];
        [self saveSettings];
	}
    
  
    
	
	// Procitamo ili defaulte koje smo napunili ili ono sto je snimljeno...
    self.learningMode = [[NSUserDefaults standardUserDefaults] integerForKey:LEARNINGMODE];
    self.showSum = [[NSUserDefaults standardUserDefaults] integerForKey:SHOWSUM];
    self.vibrate = [[NSUserDefaults standardUserDefaults] integerForKey:VIBRATE];
    self.sound = [[NSUserDefaults standardUserDefaults] integerForKey:SOUND];
    self.currentStar=[[NSUserDefaults standardUserDefaults] integerForKey:CURRENTSTAR];
    self.startLevel=[[NSUserDefaults standardUserDefaults] integerForKey:STARTLEVEL];
    self.currentLevel=[[NSUserDefaults standardUserDefaults] integerForKey:CURRENTLEVEL];
   // self.hiScores=@"";
    self.currentLevelTime = [[NSUserDefaults standardUserDefaults] integerForKey:CURRENTLEVELTIME];
    self.lastPlayerName = [[NSUserDefaults standardUserDefaults] stringForKey:LASTPLAYERNAME];
    self.language = [[NSUserDefaults standardUserDefaults] stringForKey:LANGUAGE];
    [self FillHighScores];
    
}

- (void)setLearningMode:(BOOL)value
{
    learningMode=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:value] forKey:LEARNINGMODE];
}

- (void)setShowSum:(BOOL)value
{
    showSum=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:value] forKey:SHOWSUM];
}

- (void)setVibrate:(BOOL)value
{
    vibrate=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:value] forKey:VIBRATE];
}

- (void)setSound:(BOOL)value
{
    sound=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:value] forKey:SOUND];    
}

-(void) setCurrentStar:(NSInteger) value
{
    currentStar=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:currentStar] forKey:CURRENTSTAR];   
    
}

-(void) setCurrentLevel:(NSInteger) value
{
    currentLevel=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:currentLevel] forKey:CURRENTLEVEL];   
    
}

-(void) setStartLevel:(NSInteger) value
{
    startLevel=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:startLevel] forKey:STARTLEVEL];   
    
}

-(void) setCurrentLevelTime:(NSInteger) value
{
    currentLevelTime=value;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:currentLevelTime] forKey:CURRENTLEVELTIME];   
    
}

-(void) setLastPlayerName:(NSString*) value
{
    lastPlayerName=value;
    [[NSUserDefaults standardUserDefaults] setValue:lastPlayerName forKey:LASTPLAYERNAME];   
}



- (void)setLanguage:(NSString *)value
{
    language=value;
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:LANGUAGE];  
 /*   
    NSString *lngCode=@"en";
    
   if ([value isEqualToString:@"Hrvatski"])
   {
       lngCode=@"hr";
   }
   else if ([value isEqualToString:@"English"])
   {
       lngCode=@"en";
   }
   else if ([value isEqualToString:@"French"])
   {
       lngCode=@"fr";
   }
   else if ([value isEqualToString:@"German"])
   {
       lngCode=@"de";
   }
   else 
   {
       lngCode=@"en";
   }
   [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:lngCode, nil] forKey:@"AppleLanguages"];
   [[NSUserDefaults standardUserDefaults] synchronize];    */
    
/*
 
 AppleLanguages
 
 
 [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"de", nil] 
 forKey:@"AppleLanguages"];
    NSString *lngCode;
    
    if ([[language lowercaseString] isEqualToString:[@"Hrvatski" lowercaseString]]) 
    {
        lngCode=@"hr";
    }
    if ([[language lowercaseString] isEqualToString:[@"English" lowercaseString]]) 
    {
        lngCode=@"en";
    }
    
    NSArray *preferedLanguages =  [NSLocale preferredLanguages]; 
    NSString *currentLanguage = [preferedLanguages objectAtIndex:0];
*/ 
}


+ (NSObject *) getRandomElementFromDictionary:(NSMutableDictionary *)dictionary
{
    NSObject *item = nil;
    if ([dictionary count]!=0)
    {
        NSInteger number = [SFGAppContext getRandomNumberFrom:0 To:[dictionary count]-1];
        NSArray *keys = [dictionary allKeys];
        id key = [keys objectAtIndex:number];
        item = [dictionary objectForKey:key];
    }
    return item;
}

+ (UIButton*) getRandomUIButton:(NSMutableDictionary*) buttons
{
    UIButton *retValue =nil;
    while (retValue==nil && [buttons count]>0)
    {
        retValue = (UIButton*)[SFGAppContext getRandomElementFromDictionary:buttons];
        [buttons removeObjectForKey:retValue.description];
        if (retValue.selected)
        {
            retValue=nil;
        }
    }
    return retValue;
}

+(BOOL) IsNewHighScore:(SFGHiScore*) hiScore
{
//TODO kada bude sortirano onda je najnizi zadnji..

    BOOL retValue=NO;
    if ([self getInstance].hiScores.count<10)
    {
        retValue=YES;   
    }
    else
    {
        SFGHiScore *score =[[self getInstance].hiScores objectForKey:@"9"];
        retValue = score==nil ? YES:[score GetTotalScore]<[hiScore GetTotalScore];
    /*for (SFGHiScore *score in [self getInstance].hiScores)
    {
        if ([score GetTotalScore]<[score GetTotalScore])
        {
            retValue=YES;
            break;
        }
    }*/
    }
    return retValue;
    //NSMutableDictionary *scores=[NSMutableDictionary init
}

/*
 public bool IsNewHighScore(HighScore score)
 {
 bool retValue = false;
 List<HighScore> items = this.HiScore.Value;
 if (items.Count < 10)
 {
 retValue = true;
 }
 else
 {
 items = items.OrderByDescending(x => x.TotalScore).Where(x => x.TotalScore < score.TotalScore).ToList();
 if (items.Count != 0)
 { 
 retValue = true;
 }
 }
 return retValue;
 }*/


+(void) AddHighScore:(SFGHiScore*) hiScore
{
    SFGAppContext *context = [SFGAppContext getInstance];
    NSMutableDictionary *scores = context.hiScores;
    if( scores==nil)
    {
        scores = [[NSMutableDictionary alloc]init];
    }
    
    [scores setObject:hiScore forKey:hiScore.description];
    
    /*
    for(SFGHiScore *scr in [scores allValues])
    {
       if ( ![scr respondsToSelector:@selector(Name:)] ) 
        {
            NSLog(@"ingredientLine is not an SFGHiScore! It is a: %@", scr);
        } 
        NSLog([ NSString stringWithFormat:@"Player = %@, Totalscore = %d",scr.Name,[scr GetTotalScore]]);
    }
    NSLog([ NSString stringWithFormat:@"Scores 2 Ended-------Item count %d",[scores count]]);
     */
    
    //Sortiramo listu i prvih 10 su nasi ostalo brisemo
    NSMutableDictionary *newScores=[[NSMutableDictionary alloc]init];
    
    if (scores.count>0)
    {
        NSArray *values =[scores allValues];
        NSArray *sortedValues = [values sortedArrayUsingSelector:@selector(customCompare:)];
       /*
       
        for(SFGHiScore *item in sortedValues)
        {
            NSString *player =item.Name;
            NSLog([ NSString stringWithFormat:@"Player = %@, Totalscore = %d",item.Name,[item GetTotalScore]]);
        }
         NSLog([ NSString stringWithFormat:@"SortedValues Ended-------Item count %d",[sortedValues count]]);
        */
        NSInteger startIndex = [sortedValues count]-1;
        //NSInteger cnt = [sortedValues count]<=9 ? [sortedValues count]-1:9;
        NSInteger endIndex = [sortedValues count]<10 ? 0: [sortedValues count]-10;
        for (int i = startIndex; i >=endIndex; i--)
        {
            SFGHiScore *score = [sortedValues objectAtIndex:i];
         //   NSLog([ NSString stringWithFormat:@"Player = %@, Totalscore = %d",score.Name,[score GetTotalScore]]);
            [newScores setObject:score forKey:[NSString stringWithFormat:@"%d",startIndex-i]];
        }
    }
    context.hiScores=newScores;    
}

-(void) FillHighScores
{
    //SFGAppContext *context = [SFGAppContext getInstance];
 /*   NSMutableDictionary *scores = context.hiScores;
    if( scores==nil)
    {
        scores = [[NSMutableDictionary alloc]init];
    }*/
    
    SFGHiScore *score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=1;
    score.LearningMode=YES;
    score.Name=@"Vladimir 1";
    [SFGAppContext AddHighScore:score];

    score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=2;
    score.Name=@"Vladimir 2";
    [SFGAppContext AddHighScore:score];

    score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=2;
    score.Name=@"Sinek 3";
    [SFGAppContext AddHighScore:score];
    
    score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=4;
    score.LearningMode=YES;
    score.Name=@"Sinek 4";
    [SFGAppContext AddHighScore:score];
    
    score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=2;
    score.Name=@"Sandra 5";
    [SFGAppContext AddHighScore:score];
    
    score=[[SFGHiScore alloc]init];
    score.Stars=3;
    score.Level=1;
    score.Name=@"Sandra 6";
    [SFGAppContext AddHighScore:score];
 
    score=[[SFGHiScore alloc]init];
    score.Stars=2;
    score.Level=4;
    score.Name=@"Sandra 7";
    score.ShowSum=YES;
    [SFGAppContext AddHighScore:score];    
   
    score=[[SFGHiScore alloc]init];
    score.Stars=3;
    score.Level=1;
    score.Name=@"Sandra 8";
    [SFGAppContext AddHighScore:score];
    
    score=[[SFGHiScore alloc]init];
    score.Stars=6;
    score.Level=1;
    score.LearningMode=YES;
    score.Name=@"Sandra 9";
    [SFGAppContext AddHighScore:score];

    score=[[SFGHiScore alloc]init];
    score.Stars=8;
    score.Level=1;
    score.Name=@"Sandra 10";
    
    [SFGAppContext AddHighScore:score];
    
    score=[[SFGHiScore alloc]init];
    score.Stars=8;
    score.Level=6;
    score.Name=@"Sandra 11";
    [SFGAppContext AddHighScore:score];
    
    
    score=[[SFGHiScore alloc]init];
    score.Stars=8;
    score.Level=6;
    score.Name=@"Sandra 12";
    score.ShowSum=YES;
    [SFGAppContext AddHighScore:score];
    
    //context.hiScores=scores;  
    
 /*   
    score=[[SFGHiScore alloc]init];
    score.Stars=1;
    score.Level=5;
    score.Name=@"aaaaSandra";
    
    
   */ 
}


+(NSString*) getStringForKey:(NSString*) key
{
    NSString *language = [SFGAppContext getInstance].language;
    
	NSString *path;
	if([language isEqualToString:@"English"])
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	else if([language isEqualToString:@"German"])
		path = [[NSBundle mainBundle] pathForResource:@"de" ofType:@"lproj"];
	else if([language isEqualToString:@"French"])
		path = [[NSBundle mainBundle] pathForResource:@"fr" ofType:@"lproj"];
    else if([language isEqualToString:@"Hrvatski"])
		path = [[NSBundle mainBundle] pathForResource:@"hr" ofType:@"lproj"];
    else
    {
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }
	
	NSBundle* languageBundle = [NSBundle bundleWithPath:path];
	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
	return str;
}


/*
public void AddHighScore(HighScore score)
{
    bool add = false;
    List<HighScore> items = this.HiScore.Value;
    if (items.Count < 10)
    {
        add = true;               
    }
    else
    {
        items = items.OrderByDescending(x => x.TotalScore).Where(x => x.TotalScore < score.TotalScore).ToList();
        if (items.Count != 0)
        {
            items.RemoveAt(items.Count - 1);
            add = true;
        }
    }
    
    if (add)
    {
        items.Add(score);
    }
    
}*/
/*
 AppContext.Instance.AddHighScore(new HighScore(_currentLevelIndex, _currentStar-1));
 _currentStar = 1;
 _currentLevelIndex = 1;
 AppContext.Instance.CurrentProgress.Value = AppContext.LEVELTIME;
 */



@end
 
/*
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
  
   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    */
    /*
    if (![currentLanguage isEqualToString:lngCode])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:lngCode, nil] forKey:@"AppleLanguages"];
    }
     
     
         namespace Igra
     {
     
     public sealed class AppContext
     {
     private static AppContext instance = null;
     private static readonly object syncRoot = new object();
     public const int LEVELTIME = 30;
     
     public Random RandomGenerator { get; set; }
     public List<TextBlock> TextControls { get; set; }
     public List<Ellipse> EllipseControls { get; set; }
     public List<TextBlock> SelectedItems { get; set; }
     
     public Setting<bool> Sound = new Setting<bool>("Sound", true);
     public Setting<bool> Vibrate = new Setting<bool>("Vibrate", false);
     public Setting<bool> LearningMode = new Setting<bool>("LearningMode", false);
     public Setting<bool> ShowSum = new Setting<bool>("ShowSum", false);
     public Setting<int> CurrentLevelIndex = new Setting<int>("CurrentLevel", 1);
     public Setting<int> CurrentStar = new Setting<int>("CurrentStar", 1);
     //public Setting<HighScore> HiScore = new Setting<HighScore>("HighScore", new HighScore(0, 0));
     public Setting<List<HighScore>> HiScore = new Setting<List<HighScore>>("HighScore",new List<HighScore>{new HighScore(0,0)});
     public Setting<double> CurrentProgress = new Setting<double>("CurrentProgress", LEVELTIME);
     public Setting<string> LastPlayerName = new Setting<string>("LastPlayerName","Nepoznati junak");
     public Setting<string> Language = new Setting<string>("Language", "System default");
     
     public string SystemLanguage { get; set; }
     
     public bool IsNewHighScore(HighScore score)
     {
     bool retValue = false;
     List<HighScore> items = this.HiScore.Value;
     if (items.Count < 10)
     {
     retValue = true;
     }
     else
     {
     items = items.OrderByDescending(x => x.TotalScore).Where(x => x.TotalScore < score.TotalScore).ToList();
     if (items.Count != 0)
     { 
     retValue = true;
     }
     }
     return retValue;
     }
     

     
     public HighScore GetLastHighScore()
     {
     HighScore retValue = null;
     if (this.HiScore.Value != null)
     { 
     retValue = this.HiScore.Value.OrderByDescending(x => x.TotalScore).Last();
     }
     return retValue;
     
     }
     
     private AppContext()
     {
     this.RandomGenerator = new Random();
     this.TextControls = new List<TextBlock>();
     this.EllipseControls = new List<Ellipse>();
     this.SelectedItems = new List<TextBlock>();
     }
     
     public TextBlock GetRandomTextBlock(List<TextBlock> controls,bool allowSelected)
     {
     TextBlock retValue = null;
     int index;
     while ((retValue == null) && controls.Count != 0)
     {
     index = AppContext.Instance.RandomGenerator.Next(0, controls.Count);
     retValue = controls[index];
     controls.RemoveAt(index);
     if (!allowSelected && this.SelectedItems.IndexOf(retValue) != -1)
     {
     retValue = null;
     }
     
     }
     return retValue;
     }
     
     public void SetLanguage(string Language)
     {
     CultureInfo ci = null;
     switch (Language)
     {
     case "System default":
     ci = new System.Globalization.CultureInfo(this.SystemLanguage);
     break;
     case "Croatian":
     ci = new System.Globalization.CultureInfo("hr-HR");
     break;
     case "English":
     ci = new System.Globalization.CultureInfo("en-US");
     break;
     }
     
     System.Threading.Thread.CurrentThread.CurrentCulture = ci;
     System.Threading.Thread.CurrentThread.CurrentUICulture = ci;
     ResetResources();
     }
     
     private void ResetResources()
     {
     ((LocalizedStrings)App.Current.Resources["LocalizedStrings"]).ResetResources();
     }
     
     public static AppContext Instance
     {
     get
     {
     lock (syncRoot)
     {
     if (instance == null)
     {
     instance = new AppContext();
     }
     return instance;
     }
     }
     }
     }
     
     }  
     
    */
