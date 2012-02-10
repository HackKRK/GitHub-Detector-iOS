//
//  HKLoginViewController.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, readwrite, strong) IBOutlet UITextField *loginField;
@property (nonatomic, readwrite, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, readwrite, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, readwrite, strong) IBOutlet UISegmentedControl *backendTypeSegment;

@property (strong, nonatomic) IBOutlet UIImageView *spiralBackground;

- (IBAction)login:(id)sender;

@end
