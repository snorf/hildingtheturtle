//
//  MediaViewController.m
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MediaViewController.h"
@interface SlideShowView : UIView
{
	NSArray * mImages;
	
	UIImageView * mLeftImageView;
	UIImageView * mCurrentImageView;
	UIImageView * mRightImageView;
	
	NSUInteger mCurrentImage;
	
	BOOL mSwiping;
	CGFloat mSwipeStart;
}

- (id)initWithImages:(NSArray *)inImages;

@end // SlideShowView


#pragma mark -


@implementation SlideShowView

- (UIImageView *)createImageView:(NSUInteger)inImageIndex
{
	if (inImageIndex >= [mImages count])
	{
		return nil;
	}
	
	UIImageView * result = [[UIImageView alloc] initWithImage:[mImages objectAtIndex:inImageIndex]];
	result.opaque = YES;
	result.userInteractionEnabled = NO;
	result.backgroundColor = [UIColor blackColor];
	result.contentMode = UIViewContentModeScaleAspectFit;
	result.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	return result;
}

- (id)initWithImages:(NSArray *)inImages
{
	if (self = [super initWithFrame:CGRectZero])
	{
		mImages = [inImages retain];
		
		NSUInteger imageCount = [inImages count];
		if (imageCount > 0)
		{
			mCurrentImageView = [self createImageView:0];
			[self addSubview:mCurrentImageView];
			
			if (imageCount > 1)
			{
				mRightImageView = [self createImageView:1];
				[self addSubview:mRightImageView];
			}
			
		}
		
		self.opaque = YES;
		self.backgroundColor = [UIColor blackColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
	
	return self;
}

- (void)dealloc
{
	[mImages release];
	[super dealloc];
}



- (void)layoutSubviews
{
	if (mSwiping)
		return;
	
	CGSize contentSize = self.frame.size;
	mLeftImageView.frame = CGRectMake(-contentSize.width, 0.0f, contentSize.width, contentSize.height);
	mCurrentImageView.frame = CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height);
	mRightImageView.frame = CGRectMake(contentSize.width, 0.0f, contentSize.width, contentSize.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([touches count] != 1)
		return;
	
	mSwipeStart = [[touches anyObject] locationInView:self].x;
	mSwiping = YES;
	
	mLeftImageView.hidden = NO;
	mCurrentImageView.hidden = NO;
	mRightImageView.hidden = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (! mSwiping || [touches count] != 1)
		return;
	
	CGFloat swipeDistance = [[touches anyObject] locationInView:self].x - mSwipeStart;
	
	CGSize contentSize = self.frame.size;
	
	mLeftImageView.frame = CGRectMake(swipeDistance - contentSize.width, 0.0f, contentSize.width, contentSize.height);
	mCurrentImageView.frame = CGRectMake(swipeDistance, 0.0f, contentSize.width, contentSize.height);
	mRightImageView.frame = CGRectMake(swipeDistance + contentSize.width, 0.0f, contentSize.width, contentSize.height);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (! mSwiping)
		return;
	
	CGSize contentSize = self.frame.size;
	
	NSUInteger count = [mImages count];
	
	CGFloat swipeDistance = [[touches anyObject] locationInView:self].x - mSwipeStart;
	if (mCurrentImage > 0 && swipeDistance > 50.0f)
	{
		[mRightImageView removeFromSuperview];
		[mRightImageView release];
		
		mRightImageView = mCurrentImageView;
		mCurrentImageView = mLeftImageView;
		
		mCurrentImage--;
		if (mCurrentImage > 0)
		{
			mLeftImageView = [self createImageView:mCurrentImage - 1];
			mLeftImageView.hidden = YES;
			
			[self addSubview:mLeftImageView];
		}
		else
		{
			mLeftImageView = nil;
		}
	}
	else if (mCurrentImage < count - 1 && swipeDistance < -50.0f)
	{
		[mLeftImageView removeFromSuperview];
		[mLeftImageView release];
		
		mLeftImageView = mCurrentImageView;
		mCurrentImageView = mRightImageView;
		
		mCurrentImage++;
		if (mCurrentImage < count - 1)
		{
			mRightImageView = [self createImageView:mCurrentImage + 1];
			mRightImageView.hidden = YES;
			
			[self addSubview:mRightImageView];
		}
		else
		{
			mRightImageView = nil;
		}
	}
	
	[UIView beginAnimations:@"swipe" context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3f];
	
	mLeftImageView.frame = CGRectMake(-contentSize.width, 0.0f, contentSize.width, contentSize.height);
	mCurrentImageView.frame = CGRectMake(0.0f, 0.0f, contentSize.width, contentSize.height);
	mRightImageView.frame = CGRectMake(contentSize.width, 0.0f, contentSize.width, contentSize.height);
	
	[UIView commitAnimations];
	
	mSwiping = NO;
}


@end // SlideShowView


#pragma mark -

@implementation MediaViewController
@synthesize imageView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSArray * images = [NSArray arrayWithObjects:
						[UIImage imageNamed:@"IMG_4821.jpg"], 
						[UIImage imageNamed:@"IMG_4826.jpg"], 
						[UIImage imageNamed:@"IMG_4842.jpg"], 
						[UIImage imageNamed:@"IMG_4845.jpg"], 
						[UIImage imageNamed:@"back.jpg"], 
						[UIImage imageNamed:@"curtain.jpg"], 
						[UIImage imageNamed:@"eating.jpg"], 
						[UIImage imageNamed:@"hiding.jpg"], 
						[UIImage imageNamed:@"hilding_sko.jpg"], 
						[UIImage imageNamed:@"shotgun.jpg"], 
						[UIImage imageNamed:@"trasko.jpg"], 
						[UIImage imageNamed:@"waterbowl.jpg"], 
						nil];
	
	self.view = [[[SlideShowView alloc] initWithImages:images] autorelease];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
