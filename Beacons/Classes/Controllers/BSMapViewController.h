//
//  BSMapViewController.h
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapbox/Mapbox.h>

@interface BSMapViewController : UIViewController <RMMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet RMMapView *mapView;
@property (nonatomic) CLLocationManager *manager;
@property (readwrite) CLLocationCoordinate2D selectedCoordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
