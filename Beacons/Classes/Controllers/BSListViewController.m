//
//  BSListViewController.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "BSListViewController.h"
#import "BSMapViewController.h"
#import "BSTableViewCell.h"
#import "Place.h"
#import "PlaceType.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "UIImage+Color.h"

@interface BSListViewController ()

@property (nonatomic) NSArray *placesArray;

@end

@implementation BSListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_manager startUpdatingLocation];
    _placesArray = [Place MR_findAll];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UINib *cellNib = [UINib nibWithNibName:@"BSTableViewCell" bundle:nil];
    [_tableView registerNib:cellNib forCellReuseIdentifier:@"Cell"];
    
    self.title = @"Beacons";
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHue:0.375 saturation:0.074 brightness:0.639 alpha:1]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Campton-Medium" size:24.0], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    _manager = [[CLLocationManager alloc] init];
    [_manager setDelegate:self];
    [_manager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _userLocation = [locations lastObject];
    
    if (_userLocation) {
        _placesArray = [Place MR_findAll];
        
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [_manager stopUpdatingLocation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _placesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BSTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Place *place = _placesArray[indexPath.row];
    
    cell.descriptionLabel.text = place.name;
    
    switch ([place.type.identifier integerValue]) {
        case 1:
            cell.colorView.backgroundColor = [UIColor colorWithHue:0.154 saturation:0.887 brightness:0.973 alpha:1];
            cell.distanceNumberLabel.textColor = [UIColor colorWithHue:0.154 saturation:0.887 brightness:0.6 alpha:1];
            break;
            
        case 2:
            cell.colorView.backgroundColor = [UIColor colorWithHue:0.246 saturation:0.844 brightness:0.827 alpha:1];
            cell.distanceNumberLabel.textColor = [UIColor colorWithHue:0.246 saturation:0.844 brightness:0.6 alpha:1];
            break;
            
        case 3:
            cell.colorView.backgroundColor = [UIColor colorWithHue:0.980 saturation:0.990 brightness:0.816 alpha:1];
            cell.distanceNumberLabel.textColor = [UIColor colorWithHue:0.980 saturation:0.990 brightness:0.6 alpha:1];
            break;
            
        case 4:
            cell.colorView.backgroundColor = [UIColor colorWithHue:0.577 saturation:0.887 brightness:0.973 alpha:1];
            cell.distanceNumberLabel.textColor = [UIColor colorWithHue:0.577 saturation:0.887 brightness:0.6 alpha:1];
            break;
            
        default:
            break;
    }
    
    CLLocation *placeLocation = [[CLLocation alloc] initWithLatitude:[place.latitude doubleValue] longitude:[place.longitude doubleValue]];
    
    CLLocationDistance meters = [_userLocation distanceFromLocation:placeLocation];
    
    cell.distanceNumberLabel.text = [NSString stringWithFormat:@"%.1f", meters/1000.0];
    
    if (meters > 999) {
        cell.measureLabel.text = @"km";
    } else {
        cell.measureLabel.text = @"m";
    }
    
    cell.categoryLabel.text = place.type.name;
    
    return cell;
}

#pragma mark UITableViewDelegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Place *place = _placesArray[indexPath.row];
    
    BSMapViewController *mapController = [[BSMapViewController alloc] initWithCoordinate:CLLocationCoordinate2DMake([place.latitude doubleValue], [place.longitude doubleValue])];
    [self.navigationController pushViewController:mapController animated:YES];
    
}

- (IBAction)beaconIconTapped:(id)sender {
    BSMapViewController *mapController = [[BSMapViewController alloc] init];
    [self.navigationController pushViewController:mapController animated:YES];
}

@end
