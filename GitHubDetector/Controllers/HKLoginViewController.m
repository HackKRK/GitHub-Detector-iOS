//
//  HKLoginViewController.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKLoginViewController.h"
#import "HKDetectorClient.h"

@implementation HKLoginViewController

@synthesize loginField = _loginField;
@synthesize passwordField = _passwordField;
@synthesize activityIndicator = _activityIndicator;

- (IBAction)login:(id)sender
{
    self.activityIndicator.hidden = NO;
    [HKDetectorClient authenticateWithLogin:self.loginField.text
                                   password:self.passwordField.text
                            successCallback: ^ (NSString *token) {
                                // ..
                            }
                            failureCallback: ^ (NSError *error) {
                                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Can't login"
                                                                             message:[error.userInfo objectForKey:NSLocalizedDescriptionKey]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"Dissmiss"
                                                                   otherButtonTitles:nil];
                                [av show];
                            }];
}

@end
