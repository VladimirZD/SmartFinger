//
//  GADAdSize.h
//  Google Ads iOS SDK
//
//  Copyright 2012 Google Inc. All rights reserved.
//
//  A valid GADAdSize is considered to be one of the predefined GADAdSize
//  constants or a GADAdSize constructed by GADAdSizeFromCGSize,
//  GADAdSizeFullWidthPortraitWithHeight, GADAdSizeFullWidthLandscapeWithHeight.
//

#import <UIKit/UIKit.h>

// Do not create a GADAdSize manually. Use one of the kGADAdSize constants.
// Treat GADAdSize as an opaque type. Do not access any fields directly. To
// obtain a concrete CGSize, use the function CGSizeFromGADAdSize().
typedef struct GADAdSize {
  CGSize size;
  NSUInteger flags;
} GADAdSize;

#pragma mark Standard Sizes

// iPhone and iPod Touch ad size. Typically 320x50.
extern GADAdSize const kGADAdSizeBanner;

// Medium Rectangle size for the iPad (especially in a UISplitView's left pane).
// Typically 300x250.
extern GADAdSize const kGADAdSizeMediumRectangle;

// Full Banner size for the iPad (especially in a UIPopoverController or in
// UIModalPresentationFormSheet). Typically 468x60.
extern GADAdSize const kGADAdSizeFullBanner;

// Leaderboard size for the iPad. Typically 728x90.
extern GADAdSize const kGADAdSizeLeaderboard;

// Skyscraper size for the iPad. Mediation only. AdMob/Google does not offer
// this size. Typically 120x600.
extern GADAdSize const kGADAdSizeSkyscraper;

// An ad size that spans the full width of the application in portrait
// orientation. The height is typically 50 pixels on an iPhone/iPod UI, and 90
// pixels tall on an iPad UI.
extern GADAdSize const kGADAdSizeSmartBannerPortrait;

// An ad size that spans the full width of the application in landscape
// orientation. The height is typically 32 pixels on an iPhone/iPod UI, and 90
// pixels tall on an iPad UI.
extern GADAdSize const kGADAdSizeSmartBannerLandscape;

// Invalid ad size marker.
extern GADAdSize const kGADAdSizeInvalid;

#pragma mark Custom Sizes

// Given a CGSize, return a custom GADAdSize. Use this only if you require a
// non-standard size, otherwise, use one of the standard size constants above.
GADAdSize GADAdSizeFromCGSize(CGSize size);

// Get a custom GADAdSize that spans the full width of the application in
// portrait orientation with the height provided.
GADAdSize GADAdSizeFullWidthPortraitWithHeight(CGFloat height);

// Get a custom GADAdSize that spans the full width of the application in
// landscape orientation with the height provided.
GADAdSize GADAdSizeFullWidthLandscapeWithHeight(CGFloat height);

#pragma mark Convenience Functions

// Checks whether the two GADAdSizes are equal.
BOOL GADAdSizeEqualToSize(GADAdSize size1, GADAdSize size2);

// Given a GADAdSize constant, returns a CGSize. If the GADAdSize is unknown,
// returns CGSizeZero.
CGSize CGSizeFromGADAdSize(GADAdSize size);

// Determines if |size| is one of the predefined constants, or a custom
// GADAdSize generated by FromCGSize.
BOOL IsGADAdSizeValid(GADAdSize size);

// Given a GADAdSize constant, returns a NSString describing the GADAdSize.
NSString *NSStringFromGADAdSize(GADAdSize size);


#pragma mark Deprecated Macros

#define GAD_SIZE_320x50     CGSizeFromGADAdSize(kGADAdSizeBanner)
#define GAD_SIZE_300x250    CGSizeFromGADAdSize(kGADAdSizeMediumRectangle)
#define GAD_SIZE_468x60     CGSizeFromGADAdSize(kGADAdSizeFullBanner)
#define GAD_SIZE_728x90     CGSizeFromGADAdSize(kGADAdSizeLeaderboard)
#define GAD_SIZE_120x600    CGSizeFromGADAdSize(kGADAdSizeSkyscraper)
