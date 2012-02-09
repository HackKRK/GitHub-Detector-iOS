//
//  HKGeek.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HKCheckIn;

@interface HKGeek : NSObject

@property (nonatomic, readwrite, strong) NSString *login;
@property (nonatomic, readwrite, strong) NSString *gravatarURL;
@property (nonatomic, readonly, strong) NSMutableArray *checkIns;

- (HKCheckIn *)lastCheckIn;

@end
