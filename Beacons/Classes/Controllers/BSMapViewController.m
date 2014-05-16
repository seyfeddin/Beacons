//
//  BSMapViewController.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "BSMapViewController.h"
#import "BSAddBeaconViewController.h"
#import "Place.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface BSMapViewController ()

@end

@implementation BSMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super initWithNibName:@"BSMapViewController" bundle:nil];
    if (self) {
        // Custom initialization
        self.selectedCoordinate = coordinate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    RMMapboxSource *tileSource = [[RMMapboxSource alloc] initWithMapID:@"seyfeddin.i8jgc8f9"];
    
    _mapView.delegate = self;
    
    _mapView.tileSource = tileSource;
    
    _mapView.showsUserLocation = YES;
    
    _manager = [[CLLocationManager alloc] init];
    
    _manager.delegate = self;
    
    [_manager startUpdatingLocation];
    
    NSArray *placesArray = [Place MR_findAll];
    
    for (Place *place in placesArray) {
        
        
        RMAnnotation *annotation = [RMAnnotation annotationWithMapView:_mapView coordinate:CLLocationCoordinate2DMake([place.latitude longLongValue], [place.longitude longLongValue]) andTitle:place.name];
        
        [_mapView addAnnotation:annotation];
    }
        
    if (_selectedCoordinate.latitude) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_mapView setCenterCoordinate:_selectedCoordinate animated:YES];
        });
    }

    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    if (_selectedCoordinate.latitude) {
        [_manager stopUpdatingLocation];
        return;
    }
    
    _mapView.centerCoordinate = location.coordinate;
}

-(void)longPressOnMap:(RMMapView *)map at:(CGPoint)point {

    BSAddBeaconViewController *addController = [[BSAddBeaconViewController alloc] initWithPoint:[map pixelToCoordinate:point]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:addController];
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
