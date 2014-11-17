//
//  Place.m
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "Place.h"

#define kGoogleAPI @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=%d&types=food&keyword=%@&key=AIzaSyBaKCZkW7oHGVFXjmjaHXvIyjWXTxMeqL8"

@interface Place ()

@property double latitude;
@property double longitude;
@property NSString *name;

@end

@implementation Place

+ (void)findPlace:(NSString *)keyword nearLocation:(CLLocation *)location withRadius:(int)meters withCompletion:(placeBlock)complete
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kGoogleAPI,location.coordinate.latitude,location.coordinate.longitude,meters,keyword]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        if (!connectionError)
        {
            NSError *JSONError;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:0
                                                                         error:&JSONError];
            if (!JSONError)
            {
                NSArray *array = dictionary[@"results"];
                complete(array, nil);
            }
            else
            {
                complete(nil,JSONError);
            }
        }
        else
        {
            complete(nil,connectionError);
        }

    }];
}

+ (void)findMapItem:(NSString *)query nearLocation:(CLLocation *)location withRadius:(float)span withCompletion:(mapItemBlock)complete
{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = query;
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(span, span));
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error)
        {
            NSArray *arrayOfMapItems = response.mapItems;
            complete(arrayOfMapItems, nil);
        }
        else
        {
            complete(nil, error);
        }
    }];
}
@end
