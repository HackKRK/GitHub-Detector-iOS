//
//  HKLoginViewController.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKLoginViewController : UIViewController

@property (nonatomic, readwrite, strong) IBOutlet UITextField *loginField;
@property (nonatomic, readwrite, strong) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
