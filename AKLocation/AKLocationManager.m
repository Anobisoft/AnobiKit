//
//  AKLocationManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.11.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKLocationManager.h"
#import <AnobiKit/AKFoundation.h>
#import "AKPlacemarkDetector.h"

@interface AKLocationManager()
@property NSMutableArray *detectors;
@end

@implementation AKLocationManager

- (instancetype)init {
    if (self = [super init]) {
        self.detectors = [NSMutableArray new];
    }
    return self;
}

- (void)placemarkFetch:(void (^)(NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    if (!fetchBlock) return;
    dispatch_asyncmain(^{
        //hold detector, hold self (with detector fetchBlock)
        [self.detectors addObject:[AKPlacemarkDetector detectorWithFetchBlock:^(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error) {
            dispatch_asyncmain(^{
                [self.detectors removeObject:detector]; //free detector
                fetchBlock(placemarks, error);
            });
        }]];
    });
}

@end


