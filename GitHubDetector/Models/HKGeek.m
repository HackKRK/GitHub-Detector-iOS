//
//  HKGeek.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKGeek.h"

@interface HKGeek () // Private
+ (NSMutableSet *)geeks;
@property (nonatomic, readwrite, strong) NSMutableArray *checkIns;
@end

@implementation HKGeek

@synthesize login = _login;
@synthesize gravatarURL = _gravatarURL;
@synthesize checkIns = _checkIns;

+ (NSMutableSet *)geeks
{
    static NSMutableSet *geeks = nil;
    if (geeks == nil)
    {
        geeks = [[NSMutableSet alloc] initWithCapacity:16];
    }
    return geeks;
}

+ (HKGeek *)geekForLogin:(NSString *)login
{
    NSSet *results = [[self geeks] objectsPassingTest:^ BOOL (HKGeek *geek, BOOL *stop)
                      {
                          if ([geek.login caseInsensitiveCompare:login] == NSOrderedSame)
                          {
                              *stop = YES;
                              return YES;
                          }
                          return NO;
                      }];
    
    if ([results count] > 0)
    {
        return [results anyObject];
    }
    else
    {
        HKGeek *newGeek = [[HKGeek alloc] init];
        newGeek.login = login;
        return newGeek;
    }
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
