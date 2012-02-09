//
//  HKCompassGeekView.h
//  GitHubDetector
//
//  Created by Karol S. Mazur on 09-02-2012.
//  Copyright (c) 2012 HackKrk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKGeek.h"

// How does this class work?
// You init it with the name of the geek. 
// Then you give it a block that returns the distance (integer). 
// When setNeedsDisplay calls redraw, we call our block for a new distance.

typedef int (^DistanceToGeek)(void);

@interface HKCompassGeekView : UIView {
    UILabel *metersLabel;
    UILabel *nameLabel;
    DistanceToGeek getMeMyDistance;
}

- (id)initWithGeek:(HKGeek *)leGeek;

@property (nonatomic, copy) DistanceToGeek getMeMyDistance;

@end
