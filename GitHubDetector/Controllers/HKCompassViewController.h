//
//  HKCompassViewController.h
//  GitHubDetector
//
//  Created by Krzysztof Profic on 12-02-09.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HKCompassViewController : UIViewController<CLLocationManagerDelegate> 

@property (nonatomic, assign) double sonarRange;            /**< Compas range in meters */
- (void) setLocations: (NSMutableArray *) locations;        /**< Setter for locations, overrides  */

@end
