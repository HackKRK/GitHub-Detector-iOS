//
//  HKLoginViewController.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKLoginViewController.h"
#import "HKDetectorClient.h"
#import <QuartzCore/QuartzCore.h>

@implementation HKLoginViewController

@synthesize loginField = _loginField;
@synthesize passwordField = _passwordField;
@synthesize activityIndicator = _activityIndicator;
@synthesize spiralBackground = _spiralBackground;

- (IBAction)login:(id)sender
{
    self.activityIndicator.hidden = NO;
    
    [[HKDetectorClient sharedInstance] authenticateWithLogin:self.loginField.text
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

#pragma mark -
#pragma mark <UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.loginField)
    {
        [self.passwordField becomeFirstResponder];
    }
    else if(textField == self.passwordField)
    {
        [textField resignFirstResponder];
        [self login:nil];
    }
    
    return YES;
}

- (void)viewDidUnload {
    [self setSpiralBackground:nil];
    [super viewDidUnload];
}

#pragma mark Background animation, yay

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setDuration:15.0f];
    [anim setAutoreverses:NO];
    [anim setRepeatCount:NSIntegerMax];
    [anim setFromValue:[NSNumber numberWithDouble:0.0f]];
    [anim setToValue:[NSNumber numberWithDouble:(M_PI * 2.0f)]];
    [[self.spiralBackground layer] addAnimation:anim forKey:@"my_rotation"];
    
//    [UIView animateWithDuration:3 delay:0 
//                        options:UIViewAnimationOptionRepeat 
//                     animations:^(void){
//                         self.spiralBackground.transform = CGAffineTransformMakeRotation(M_PI * 1.0f);
//                         [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//                         NSLog(@"should work");
//                     }
//                     completion:^(BOOL finished) {
//                         [UIView animateWithDuration:3 animations:^(void) {
//                            self.spiralBackground.transform = CGAffineTransformMakeRotation(M_PI * 1.0f);
//                            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//                         }];
//                     }];

}

@end
