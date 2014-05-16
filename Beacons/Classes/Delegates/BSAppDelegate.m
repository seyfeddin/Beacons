//
//  BSAppDelegate.m
//  Beacons
//
//  Created by Seyfeddin Bassarac on 16/05/14.
//  Copyright (c) 2014 ThreadCo. All rights reserved.
//

#import "BSAppDelegate.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "PlaceType+Create.h"

@implementation BSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    NSArray *typesArray = [PlaceType MR_findAllSortedBy:@"identifier" ascending:YES];
    
    if (typesArray.count == 0) {
        
        typesArray = @[
                        @{
                           @"identifier": @1,
                           @"name" : @"Food",
                           },
                        @{
                            @"identifier" : @2,
                            @"name" : @"Home"
                            },
                        @{
                            @"identifier" : @3,
                            @"name" : @"Shopping"
                            },
                        @{
                            @"identifier" : @4,
                            @"name" : @"Necessary"
                            },
                        @{
                            @"identifier" : @5,
                            @"name" : @"Other"
                            }
                       ];
        
        for (NSDictionary *info in typesArray)
            [PlaceType placetypeWithInfo:info];
    }
    
    _mainController = [[BSListViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_mainController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}


@end
