//
//  HKAppDelegate.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKAppDelegate.h"
#import "HKLoginViewController.h"
#import "HKMapViewController.h"
#import "HKDetectorClient.h"

@implementation HKAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *nacVC = [[UINavigationController alloc] init];
    
    if ([[HKDetectorClient sharedInstance] isAuthenticated])
    {
        HKMapViewController *loginVC = [[HKMapViewController alloc] init];
        [nacVC pushViewController:loginVC animated:NO];
    }
    else
    {
        HKLoginViewController *loginVC = [[HKLoginViewController alloc] initWithNibName:@"HKLoginView" bundle:nil];
        [nacVC pushViewController:loginVC animated:NO];
    }
    
    self.window.rootViewController = nacVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
