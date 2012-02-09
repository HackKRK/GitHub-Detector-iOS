//
//  HKGeek.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKGeek.h"

@interface HKGeek () // Private
+ (NSMutableSet *)_geeks;
- (id)_initFromJSON:(NSDictionary *)json;
@property (nonatomic, readwrite, strong) NSMutableArray *checkIns;
@end

@implementation HKGeek

@synthesize login = _login;
@synthesize gravatarURL = _gravatarURL;
@synthesize checkIns = _checkIns;

+ (NSMutableSet *)_geeks
{
    static NSMutableSet *geeks = nil;
    if (geeks == nil)
    {
        geeks = [[NSMutableSet alloc] initWithCapacity:16];
    }
    return geeks;
}

+ (HKGeek *)geekFromJSON:(NSDictionary *)json
{
    HKGeek *newGeek = [[HKGeek alloc] _initFromJSON:json];
    HKGeek *existingGeek = [[self _geeks] member:newGeek];
    
    if (existingGeek != nil)
    {
        return existingGeek;
    }
    else
    {
        [[self _geeks] addObject:newGeek];
        return newGeek;
    }
}

- (BOOL)isEqual:(HKGeek *)otherGeek
{
    if ([otherGeek isKindOfClass:[HKGeek class]] && [otherGeek.login caseInsensitiveCompare:self.login] == NSOrderedSame)
    {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash
{
    return [self.login length];
}

- (id)_initFromJSON:(NSDictionary *)json
{
    if (self = [super init])
    {
        self.login = [json objectForKey:@"login"];
        self.gravatarURL = [json objectForKey:@"avatar_url"];
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
