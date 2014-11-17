//
//  Place.h
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
@import MapKit;

typedef void(^placeBlock)(NSArray *arrayOfPlaces, NSError *error);
typedef void(^mapItemBlock)(NSArray *arrayOfMapItems, NSError *error);

@interface Place : NSObject

+ (void)findPlace:(NSString *)keyword nearLocation:(CLLocation *)location withRadius:(int)meters withCompletion:(placeBlock)complete;

+ (void)findMapItem:(NSString *)query nearLocation:(CLLocation *)location withRadius:(float)span withCompletion:(mapItemBlock)complete;

@end
