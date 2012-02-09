//
//  HKDetectorClient.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKDetectorClient.h"

static NSString *HKDetectorClientAccessToken = @"HKDetectorClientAccessToken";
static NSDictionary *apiURLs;

@implementation HKDetectorClient

+ (HKDetectorClient *) sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^ {
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (void) initialize {
  apiURLs = [NSDictionary dictionaryWithObjectsAndKeys:
             @"http://api.com", [NSNumber numberWithInt: RubyApi],
             @"http://api.com", [NSNumber numberWithInt: JavaApi],
             nil];
}

+ (HKDetectorClient *) sharedClient {
  static HKDetectorClient *client;
  if (!client) {
    client = [[HKDetectorClient alloc] initWithApi: RubyApi];
  }
  return client;
}

- (void) loadToken {
  if (!userToken) {
    userToken = [[NSUserDefaults standardUserDefaults] objectForKey: HKDetectorClientAccessToken];
  }
}

- (BOOL) isAutenticated {
  if ([userToken length] > 0) {
    return YES;
  } else {
    return NO;
  }
}

- (id) initWithApi: (ApiType) apiType {
  NSString *url = [apiURLs objectForKey: [NSNumber numberWithInt: apiType]];

  self = [super initWithBaseURL: [NSURL URLWithString: url]];
  if (self) {
    [self loadToken];
  }
  return self;
}

- (void) authenticateWithLogin: (NSString *) login
                      password: (NSString *) password
               successCallback: (void (^)(NSString *accessToken)) successCallback
               failureCallback: (void (^)(NSError *error)) failureCallback {

  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: login, @"login", password, @"password", nil];
  NSURLRequest *request = [self requestWithMethod: @"POST" path: @"/login" parameters: params];

  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: request
    success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      userToken = [JSON objectForKey: @"token"];
      successCallback(userToken);
    }
    failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      failureCallback(error);
    }
  ];
  [operation start];
}

- (void) postCheckinWithText: (NSString *) text
                  atLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
             successCallback: (void (^)()) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback {

  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat: latitude], @"latitude",
                          [NSNumber numberWithFloat: longitude], @"longitude",
                          text, @"text",
                          nil];

  NSMutableURLRequest *request = [self requestWithMethod: @"POST" path: @"/checkin" parameters: params];
  [request addValue: userToken forHTTPHeaderField: @"X-Token"];

  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: request
    success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      successCallback();
    }
    failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      failureCallback(error);
    }
  ];
  [operation start];
}

@end
