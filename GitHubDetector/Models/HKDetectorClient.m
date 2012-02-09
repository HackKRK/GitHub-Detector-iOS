//
//  HKDetectorClient.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKDetectorClient.h"

static NSString *HKDetectorClientAccessToken = @"HKDetectorClientAccessToken";

@implementation HKDetectorClient

+ (BOOL)isAutenticated
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

+ (void)authenticateWithLogin:(NSString *)login
                     password:(NSString *)password
              successCallback:(void (^)(NSString *accessToken))successCallback
              failureCallback:(void (^)(NSError *error))failureCallback
{
//    [[NSUserDefaults standardUserDefaults] setObject:token
//                                              forKey:HKDetectorClientAccessToken];
}

@end
