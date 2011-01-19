//
//  VideoView.m
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VideoView.h"


@implementation VideoView
@synthesize webView;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	webView.scalesPageToFit = YES;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIDeviceOrientationDidChangeNotification
											   object:nil];
}

-(void)didRotate:(NSNotification *)theNotification {
	UIInterfaceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
	NSURLRequest* urlRequest = [self getResolutionString:interfaceOrientation];
	[webView loadRequest:urlRequest];	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
	//NSURLRequest* urlRequest = [self getResolutionString:interfaceOrientation];
	NSString *path1 = [[NSBundle mainBundle] pathForResource:@"640" ofType:@"html"];
	NSString *html = [NSString stringWithContentsOfFile:path1 encoding:NSUTF8StringEncoding error:nil];
	[self.webView loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]]];
	//[webView loadRequest:urlRequest];	
	return YES;
}

- (NSURLRequest*) getResolutionString:(UIInterfaceOrientation)interfaceOrientation {
	NSInteger scale = [[UIScreen mainScreen] scale] + 0.5f;
	if(interfaceOrientation == UIInterfaceOrientationPortrait) {
		NSString *urlString = [NSString stringWithFormat:
							  @"http://cam.hildingtheturtle.com/axis-cgi/mjpg/video.cgi?resolution=%ix%i&clock=0&date=0&text=%@", 
							   320*scale, 240*scale, @"&textstring=Please%20rotate%20to%20landscape%20for%20full%20screen"];
		return[NSURLRequest requestWithURL:
									[NSURL URLWithString: urlString]];
	} else {
		NSString *urlString;
		if (scale == 2) {
			urlString = [NSString stringWithFormat:
						  @"http://cam.hildingtheturtle.com/axis-cgi/mjpg/video.cgi?resolution=%ix%i&clock=0&date=0&text=0", 
						  640, 480];
		} else {
			urlString = [NSString stringWithFormat:
						  @"http://cam.hildingtheturtle.com/axis-cgi/mjpg/video.cgi?resolution=%ix%i&clock=0&date=0&text=0", 
						  480, 360];
		}
		return[NSURLRequest requestWithURL:
			   [NSURL URLWithString:urlString]];
	}		
}

- (void)startLoading {
	[webView reload];
}

- (void)stopLoading {
	[webView stopLoading];
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
