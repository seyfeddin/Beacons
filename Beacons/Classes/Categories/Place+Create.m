//
//  Place+Create.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "Place+Create.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>

@implementation Place (Create)

+ (Place *)placeWithInfo:(NSDictionary *)info {
    Place *place = [[Place MR_findByAttribute:@"name" withValue:info[@"name"]] firstObject];
    
    if (place) {
        return place;
    }
    
    // Create new product with info
    place = [Place MR_createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    
    place.name = info[@"name"];
    place.latitude = info[@"latitude"];
    place.longitude = info[@"longitude"];
    
    place.type = info[@"type"];
    
    // Save changes
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
    
    return place;
}

@end
