//
//  VideoView.h
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VideoView : UIViewController {
	IBOutlet UIWebView *webView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (void)startLoading;
- (void)stopLoading;
- (NSURLRequest*) getResolutionString:(UIInterfaceOrientation)interfaceOrientation;
@end
