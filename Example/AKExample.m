//
//  AKExample.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-04-10.
//  Copyright © 2019 anobisoft. All rights reserved.
//

#import "AKExample.h"

#import <AnobiKit/AnobiKit.h>

@interface AKListItemCustomBox : AKListWeakItem
@property (nonatomic) id something;
@end
@implementation AKListItemCustomBox
@end

#if !TARGET_OS_TV
@interface AKExample ()

@property AKLocationManager *locationManager;

@end
#endif

@implementation AKExample

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)configManagerExample {
    NSLog(@"MainConfig\n%@", [AKConfigManager manager][@"AKExampleConfig"]);
}

- (void)bundleExample {
#if TARGET_OS_MAC
    NSLog(@"%@", [NSBundle mainBundle]);
    NSLog(@"%@", [[NSBundle mainBundle].localizationTable.allKeys subarrayWithRange:NSMakeRange(0, 5)]);
#else
    NSLog(@"%@", [NSBundle UIKitBundle]);
    NSLog(@"%@", [[NSBundle UIKitBundle].localizationTable.allKeys subarrayWithRange:NSMakeRange(0, 5)]);
    NSLog(@"%@", [[NSBundle UIKitBundle] localizedStringForKey:@"Redo"]);
#endif
}

#if !TARGET_OS_TV
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
#endif

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

@end
