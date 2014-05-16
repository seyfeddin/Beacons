//
//  BSTableViewCell.h
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *measureLabel;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
