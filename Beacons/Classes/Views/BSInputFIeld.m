//
//  BSInputFIeld.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "BSInputFIeld.h"

@implementation BSInputFIeld

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 CALayer *lineLayer = [[CALayer alloc] init];
 
 lineLayer.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
 
 [lineLayer setBackgroundColor:[[UIColor colorWithWhite:0.337 alpha:1.000] CGColor]];
 
 [self.layer insertSublayer:lineLayer atIndex:0];
 
 self.backgroundColor = [UIColor clearColor];
}


@end
