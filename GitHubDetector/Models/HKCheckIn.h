//
//  HKCheckIn.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface HKCheckIn : NSObject

@property (nonatomic, readwrite, strong) CLLocation *location;
@property (nonatomic, readwrite, strong) NSString *message;

- (NSComparisonResult)compareDate:(HKCheckIn *)aCheckIn;

@end
