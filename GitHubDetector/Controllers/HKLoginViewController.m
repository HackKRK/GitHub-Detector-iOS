//
//  HKLoginViewController.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKLoginViewController.h"

@implementation HKLoginViewController

@synthesize loginField = _loginField;
@synthesize passwordField = _passwordField;
@synthesize activityIndicator = _activityIndicator;

- (IBAction)login:(id)sender
{
    self.activityIndicator.hidden = NO;
    // Pawel - how i can login? :p
}

@end
