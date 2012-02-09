//
//  HKDetectorClient.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  RubyApi,
  JavaApi
} ApiType;

@interface HKDetectorClient : AFHTTPClient {
  NSString *userToken;
}

+ (HKDetectorClient *) sharedInstance;

- (id) initWithApi: (ApiType) apiType;
- (BOOL) isAutenticated;

- (void) authenticateWithLogin: (NSString *) login
                      password: (NSString *) password
               successCallback: (void (^)(NSString *accessToken)) successCallback
               failureCallback: (void (^)(NSError *error)) failureCallback;

- (void) postCheckinWithText: (NSString *) text
                  atLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
             successCallback: (void (^)()) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback;

- (void) findGeeksAtLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
             successCallback: (void (^)(NSArray *geeks)) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback;

- (void) findGeeksAtLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
                    inRadius: (CGFloat) radius
             successCallback: (void (^)(NSArray *geeks)) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback;

@end
