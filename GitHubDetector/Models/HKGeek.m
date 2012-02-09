//
//  HKGeek.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKGeek.h"

@interface HKGeek () // Private
@property (nonatomic, readwrite, strong) NSMutableArray *checkIns;
@end

@implementation HKGeek

@synthesize login = _login;
@synthesize gravatarURL = _gravatarURL;
@synthesize checkIns = _checkIns;

+ (HKGeek *)geekForLogin:(NSString *)login
{
    // TODO: should look for geeks in an NSSet
    HKGeek *newGeek = [[HKGeek alloc] init];
    newGeek.login = login;
    return newGeek;
}

- (id)init
{
    if (self = [super init]) {
        self.checkIns = [NSMutableArray arrayWithCapacity:4];
    }
    return self;
}

- (HKCheckIn *)lastCheckIn
{
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray:self.checkIns];
    [sortedArray sortUsingSelector:@selector(compare:)];
    return [sortedArray lastObject]; // TODO: check dates here (sort)
}

@end
