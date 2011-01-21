//
//  VideoView2.m
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoView2.h"


@implementation VideoView2
@synthesize webView, html;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	started = NO;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

-(void)didRotate:(NSNotification *)theNotification {
	UIInterfaceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
	[self loadResolution:interfaceOrientation];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	[self loadResolution:interfaceOrientation];
	return YES;
}

- (void) loadResolution:(UIInterfaceOrientation)interfaceOrientation {
	NSInteger scale = [[UIScreen mainScreen] scale] + 0.5f;
	NSString *path = nil;
	if (scale == 2) {
		path = [[NSBundle mainBundle] pathForResource:@"cam640_2" ofType:@"html"];
	} else {
		path = [[NSBundle mainBundle] pathForResource:@"cam480_2" ofType:@"html"];
	}
	self.html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	[self startLoading];
}

- (void)startLoading {
	if (!started) {
		[self.webView loadHTMLString:self.html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
		started = YES;
	}
}

- (void)stopLoading {
	if (started) {
		[webView stopLoading];
		started = NO;
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
