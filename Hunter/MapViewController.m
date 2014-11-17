//
//  MapViewController.m
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "MapViewController.h"
@import CoreLocation;
@import MapKit;

@interface MapViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


@end
