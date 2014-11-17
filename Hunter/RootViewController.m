//
//  ViewController.m
//  Hunter
//
//  Created by Andrew Liu on 11/16/14.
//  Copyright (c) 2014 Andrew Liu. All rights reserved.
//

#import "RootViewController.h"
#import "Location.h"
#import "Place.h"
@import MapKit;
@import CoreLocation;

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>

@property CLLocationManager *manager;
@property CLLocation *currentLocation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfLocations;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayOfLocations = [@[]mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.manager = [CLLocationManager new];
    [self.manager startUpdatingLocation];
    [self.manager requestWhenInUseAuthorization];
    self.manager.delegate = self;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self Error:error];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for (CLLocation *location in locations)
    {
        if (location.verticalAccuracy <= 100 && location.horizontalAccuracy <= 100)
        {
            [Location retrieveCurrentPlacemarkByLocation:location
                                          withCompletion:^(CLPlacemark *placemark, NSError *error) {
            if (!error)
            {
                self.currentLocation = placemark.location;
                [Place findPlace:@"Thai" nearLocation:location withRadius:5000 withCompletion:^(NSArray *arrayOfPlaces, NSError *error) {
                    self.arrayOfLocations = [arrayOfPlaces mutableCopy];
                    [self.tableView reloadData];
                }];
            }
            else
            {
                [self Error:error];
            }
        }];
        [self.manager stopUpdatingLocation];
        break;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOfLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dictionary = self.arrayOfLocations[indexPath.row];
    cell.textLabel.text = dictionary[@"name"];
    return cell;
}

- (void)Error:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
