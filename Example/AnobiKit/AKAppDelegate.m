//
//  AKAppDelegate.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 08/02/2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKAppDelegate.h"
#import <AnobiKit/AnobiKit.h>

@interface AKAppDelegate ()

@property AKLocationManager *locationManager;

@end

@implementation AKAppDelegate

- (void)configManagerExample {
    NSLog(@"MainConfig\n%@", [AKConfigManager manager][@"AKExampleConfig"]);
}

- (void)bundleExample {
    NSLog(@"%@", [NSBundle UIKitBundle]);
    NSLog(@"%@", [[NSBundle UIKitBundle].localizationTable.allKeys subarrayWithRange:NSMakeRange(0, 5)]);
    NSLog(@"%@", [[NSBundle UIKitBundle] localizedStringForKey:@"Redo"]);
}

- (void)locationManagerExample {
    self.locationManager = [AKLocationManager new];
    [self.locationManager placemarkFetch:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            NSLog(@"[ERROR] %@", error);
        } else {
            NSLog(@"Your locality: %@", placemarks.firstObject.locality);
        }
    }];
}

- (void)dataValidationExample {
    NSString *email4test = @"dldklsfjghdfjklsgh_@atakdjvbl-asdfk.aldfgkadfgjk.lag";
    NSString *validationResult = email4test.isValidEmail ? @"isValidEmail" : @"isInvalidEmail";
    NSLog(@"'%@' %@", email4test, validationResult);
}

- (void)versionExample {
    AKVersion *version = [AKVersion appVersion];
    NSLog(@"Application version: %@", version);
    version = [AKVersion appVersion];
    NSLog(@"Application version: %@", version.debugDescription);
}

- (void)listExample {
    AKList *list = [AKList listWithItemClass:NSClassFromString(@"AKListItemCustomBox")];
    NSString *x = [NSString stringWithFormat:@"r%@", @(random())];
    NSString *y = [NSString stringWithFormat:@"r%@", @(random())];
    NSString *z = [NSString stringWithFormat:@"r%@", @(random())];

    [list addObject:x];
    [list addObject:y];
    [list addObject:z];
    [list enumerateWithBlock:^(id  _Nonnull object) {
        NSLog(@"%@", object);
    }];
    NSLog(@"--");
    dispatch_asyncmain(^{
        [list enumerateWithBlock:^(id  _Nonnull object) {
            NSLog(@"%@", object);
        }];
        NSLog(@"--");
    });
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self listExample];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
