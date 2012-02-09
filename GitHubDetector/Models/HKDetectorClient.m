//
//  HKDetectorClient.m
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import "HKCheckIn.h"
#import "HKDetectorClient.h"
#import "JSONKit.h"

static NSString *HKDetectorClientAccessToken = @"HKDetectorClientAccessToken";
static NSDictionary *apiURLs;
static CGFloat defaultRadius = 10.0;

@implementation HKDetectorClient

+ (HKDetectorClient *) sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^ {
        _sharedObject = [[self alloc] initWithApi: PythonApi];
    });
    return _sharedObject;
}

+ (void) initialize {
  apiURLs = [NSDictionary dictionaryWithObjectsAndKeys:
             @"http://api.com", [NSNumber numberWithInt: RubyApi],
             @"http://10.0.1.61:8000", [NSNumber numberWithInt: PythonApi],
             nil];
}

- (void) loadToken {
  if (!userToken) {
    userToken = [[NSUserDefaults standardUserDefaults] objectForKey: HKDetectorClientAccessToken];
  }
}

- (void) setTokenHeader {
  [self setDefaultHeader: @"X-Token" value: userToken];
}

- (BOOL) isAuthenticated {
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
    if ([self isAuthenticated]) {
      [self setTokenHeader];
    }
  }
  return self;
}

- (void) authenticateWithLogin: (NSString *) login
                      password: (NSString *) password
               successCallback: (void (^)(NSString *accessToken)) successCallback
               failureCallback: (void (^)(NSError *error)) failureCallback {

  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: login, @"login", password, @"password", nil];
  NSMutableURLRequest *request = [self requestWithMethod: @"POST" path: @"/login" parameters: nil];
  [request setHTTPBody: [params JSONData]];

  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: request
    success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      userToken = [JSON objectForKey: @"token"];
      [self setTokenHeader];
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

  NSMutableURLRequest *request = [self requestWithMethod: @"POST" path: @"/checkin" parameters: nil];
  [request setHTTPBody: [params JSONData]];

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

- (void) findGeeksAtLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
             successCallback: (void (^)(NSArray *geeks)) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback {

  [self findGeeksAtLatitude: latitude
                  longitude: longitude
                   inRadius: defaultRadius
            successCallback: successCallback
            failureCallback: failureCallback];
}

- (void) findGeeksAtLatitude: (CGFloat) latitude
                   longitude: (CGFloat) longitude
                    inRadius: (CGFloat) radius
             successCallback: (void (^)(NSArray *geeks)) successCallback
             failureCallback: (void (^)(NSError *error)) failureCallback {

  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat: latitude], @"latitude",
                          [NSNumber numberWithFloat: longitude], @"longitude",
                          [NSNumber numberWithFloat: radius], @"radius",
                          nil];

  NSMutableURLRequest *request = [self requestWithMethod: @"GET" path: @"/geeks" parameters: params];

  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest: request
    success: ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      NSMutableArray *objects = [[NSMutableArray alloc] initWithCapacity: [JSON count]];
      for (NSDictionary *jsonRecord in JSON) {
        HKCheckIn *checkin = [HKCheckIn checkInFromJSON: jsonRecord];
        [objects addObject: checkin];
      }
      successCallback(objects);
    }
    failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      failureCallback(error);
    }
  ];
  [operation start];

}

@end
