//
//  Location.h
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

typedef void(^locationBlock)(CLPlacemark *placemark, NSError *error);


@interface Location : NSObject

+ (void)retrieveCurrentPlacemarkByLocation:(CLLocation *)location withCompletion:(locationBlock)complete;




@end
