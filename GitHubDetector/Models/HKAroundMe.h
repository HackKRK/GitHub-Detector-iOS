//
//  HKAroundMe.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/10/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKAroundMe : NSObject <CLLocationManagerDelegate>

@property (nonatomic, readonly, strong) CLLocation *myLocation;
@property (nonatomic, readwrite, strong) NSArray *checkIns;

@end
