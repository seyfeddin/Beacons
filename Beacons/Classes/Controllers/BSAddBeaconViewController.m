//
//  BSAddBeaconViewController.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "BSAddBeaconViewController.h"
#import "BSInputFIeld.h"
#import "Place+Create.h"
#import "PlaceType.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface BSAddBeaconViewController ()

@end

@implementation BSAddBeaconViewController {
    UIButton *_selectedButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithPoint:(CLLocationCoordinate2D)point
{
    self = [super init];
    if (self) {
        self.point = point;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addButtonTapped:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    self.navigationController.navigationBarHidden = NO;
    
}

-(void)dismissKeyboard:(id)sender {
    [_descriptionField resignFirstResponder];
}

- (void)addButtonTapped:(id)sender {
    if (!_selectedButton) {
        return;
    }
    
    PlaceType *selectedType = [[PlaceType MR_findByAttribute:@"identifier" withValue:[NSNumber numberWithInteger: _selectedButton.tag]] firstObject];
    
    if (selectedType) {
        Place *savedPlace = [Place placeWithInfo:@{
                              @"name": _descriptionField.text,
                              @"latitude" : [NSNumber numberWithDouble: _point.latitude],
                              @"longitude" : [NSNumber numberWithDouble: _point.longitude],
                              @"type": selectedType
                              }];
        
        UINavigationController *controller = self.presentingViewController.navigationController;
        
        [self dismissViewControllerAnimated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [controller popViewControllerAnimated:YES];
            });
        }];
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)categoryButtonTapped:(UIButton *)button {
    
    NSArray *viewsArray = self.view.subviews;
    
    for (UIView *view in viewsArray) {
        if (view.class == [UIButton class]) {
            [(UIButton *)view setSelected:NO];
            [view setAlpha:0.4];
        }
    }
    
    [button setSelected:YES];
    [button setAlpha:1.0];
    _selectedButton = button;
}
@end
