//
//  PlaceType+Create.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "PlaceType+Create.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Place.h"


@implementation PlaceType (Create)

+ (PlaceType *)placetypeWithInfo:(NSDictionary *)info {
    PlaceType *placeType = [[PlaceType MR_findByAttribute:@"identifier" withValue:info[@"identifier"]] firstObject];
    
    if (placeType) {
        return placeType;
    }
    
    // Create new product with info
    placeType = [PlaceType MR_createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
    
    placeType.identifier = info[@"identifier"];
    placeType.name = info[@"name"];
    
    // Save changes
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
    
    return placeType;
}

@end
