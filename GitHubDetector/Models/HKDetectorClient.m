//
//  HKDetectorClient.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKDetectorClient.h"

static NSString *HKDetectorClientAccessToken = @"HKDetectorClientAccessToken";

@interface HKDetectorClient () // Private
@property (nonatomic, readwrite, strong) NSString *serverUrl;
@end

@implementation HKDetectorClient

@synthesize serverUrl = _serverUrl;

+ (HKDetectorClient *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^ {
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    if (self = [super init])
    {
        self.serverUrl = @"https://?";
    }
    return self;
}

- (BOOL)isAutenticated
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:HKDetectorClientAccessToken];
    if ([token length] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)authenticateWithLogin:(NSString *)login
                     password:(NSString *)password
              successCallback:(void (^)(NSString *accessToken))successCallback
              failureCallback:(void (^)(NSError *error))failureCallback
{
//    [[NSUserDefaults standardUserDefaults] setObject:token
//                                              forKey:HKDetectorClientAccessToken];
}

@end
