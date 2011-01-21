//
//  FirstViewController.h
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface FirstViewController : UIViewController <UIWebViewDelegate, ADBannerViewDelegate> {
	IBOutlet UIWebView *webView;
	IBOutlet ADBannerView *adView;
	BOOL bannerIsVisible;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet ADBannerView *adView;
@property (nonatomic,assign) BOOL bannerIsVisible;

- (void) loadResolution:(UIInterfaceOrientation)interfaceOrientation;

@end
