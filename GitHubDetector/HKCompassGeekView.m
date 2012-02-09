//
//  HKCompassGeekView.m
//  GitHubDetector
//
//  Created by Karol S. Mazur on 09-02-2012.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HKCompassGeekView.h"

#pragma mark Private interface

@interface HKCompassGeekView ()

@end

#pragma mark Implementation

@implementation HKCompassGeekView

@synthesize getMeMyDistance;

- (id)initWithGeek:(HKGeek *)leGeek {
    CGRect rect = CGRectMake(0, 0, 70, 15);
    
    if ((self = [super initWithFrame:rect])) {
        // this should cause drawRect to not clear us
        self.clearsContextBeforeDrawing = NO;
        
        // setup look of our view
        self.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
        self.opaque = NO;
        self.layer.cornerRadius = 5.0;
        
        // setup the two label subviews
        CGRect rectForMeters = CGRectMake(0, 0, 20, 15);
        CGRect rectForName = CGRectMake(0, 0, 50, 15);
        
        metersLabel = [[UILabel alloc] initWithFrame:rectForMeters];
        nameLabel = [[UILabel alloc] initWithFrame:rectForName];
        
        metersLabel.textColor = [UIColor whiteColor];
        nameLabel.textColor = [UIColor whiteColor];
        
        metersLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
        nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
        
        metersLabel.text = @"0 m";
        nameLabel.text = leGeek.login;
        
        [self addSubview:metersLabel];
        [self addSubview:nameLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // If the block exists then grab meters from it!
    if (getMeMyDistance) {
        int metersToGeek = getMeMyDistance();
        metersLabel.text = [NSString stringWithFormat:@"%d m", metersToGeek];
    }
    
    [super drawRect:rect];
}

@end
