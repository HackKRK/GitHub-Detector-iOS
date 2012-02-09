//
//  HKAppDelegate.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKAppDelegate.h"
#import "HKLoginViewController.h"

@implementation HKAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HKLoginViewController *loginVC = [[HKLoginViewController alloc] initWithNibName:@"HKLoginView" bundle:nil];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
