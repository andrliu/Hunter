//
//  Location.m
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "Location.h"

@implementation Location

+ (void)retrieveCurrentPlacemarkByLocation:(CLLocation *)location withCompletion:(locationBlock)complete
{
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error)
        {
            CLPlacemark *placemark = placemarks.firstObject;
            complete(placemark, nil);
        }
        else
        {
            complete(nil, error);
        }
    }];
}




@end
