//
//  HildingTheTurtleAppDelegate.h
//  HildingTheTurtle
//
//  Created by Johan Karlsteen on 2011-01-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HildingTheTurtleAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (void)stopLoading;
- (void)startLoading;

@end
