//
//  BSAppDelegate.h
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSListViewController.h"

@interface BSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) BSListViewController *mainController;

@end
