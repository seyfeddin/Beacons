//
//  BSAddBeaconViewController.h
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class BSInputFIeld;


@interface BSAddBeaconViewController : UIViewController

@property (readwrite) CLLocationCoordinate2D point;

@property (weak, nonatomic) IBOutlet BSInputFIeld *descriptionField;
@property (weak, nonatomic) IBOutlet UIButton *foodButton;
@property (weak, nonatomic) IBOutlet UIButton *shopButton;
@property (weak, nonatomic) IBOutlet UIButton *necessaryButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

- (IBAction)categoryButtonTapped:(id)sender;
- (instancetype)initWithPoint:(CLLocationCoordinate2D)point;

@end
