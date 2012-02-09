//
//  HKDetectorClient.h
//  GitHubDetector
//
//  Created by Błażej Biesiada on 2/9/12.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKDetectorClient : NSObject

+ (HKDetectorClient *)sharedInstance;
- (void)authenticateWithLogin:(NSString *)login
                     password:(NSString *)password
              successCallback:(void (^)(NSString *accessToken))successCallback
              failureCallback:(void (^)(NSError *error))failureCallback;
- (BOOL)isAutenticated;

@end
