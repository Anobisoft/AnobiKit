//
//  AKAppDelegate.m
//  Example_macOS
//
//  Created by Stanislav Pletnev on 09/04/2019.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import "AKAppDelegate.h"
#import <AnobiKit/AnobiKit.h>

@interface AKAppDelegate ()

@property AKLocationManager *locationManager;

@end

@implementation AKAppDelegate

- (void)configManagerExample {
    @try {
        NSLog(@"MainConfig\n%@", [AKConfigManager manager][@"AKExampleConfig"]);
    } @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
}

- (void)bundleExample {
    NSLog(@"%@", [NSBundle mainBundle]);
    NSLog(@"%@", [[NSBundle mainBundle].localizationTable.allKeys subarrayWithRange:NSMakeRange(0, 5)]);
    NSLog(@"%@", [[NSBundle mainBundle] localizedStringForKey:@"Redo"]);
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
    AKVersion *version = [AKVersion applicationVersion];
    NSLog(@"Application version: %@", version);
    version = [AKVersion applicationVersion];
    NSLog(@"Application version: %@", version.debugDescription);
}

- (void)listExample {
    NSLog(@"AKList with custom box example");
    AKList *list = [AKList listWithItemClass:NSClassFromString(@"AKListItemCustomBox")];
    @autoreleasepool {
        id x = [NSUUID UUID];
        id y = [NSUUID UUID];
        id z = [NSUUID UUID];
        
        [list addObject:x];
        [list addObject:y];
        [list addObject:z];
        NSLog(@"-- enumerate");
        [list enumerateWithBlock:^(id  _Nonnull object) {
            NSLog(@"%@", object);
        }];
        NSLog(@"-- autorelease objects");
    }
    NSLog(@"-- enumerate");
    [list enumerateWithBlock:^(id  _Nonnull object) {
        NSLog(@"%@", object);
    }];
    NSLog(@"-- done");
}

- (void)subscriptExample {
    NSMapTable *table = [NSMapTable strongToWeakObjectsMapTable];
    table[@"ATATAT"] = @"OMG!";
    NSLog(@"%@", table[@"ATATAT"]);
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self listExample];
    [self subscriptExample];
    [self versionExample];
    [self dataValidationExample];
    [self configManagerExample];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
