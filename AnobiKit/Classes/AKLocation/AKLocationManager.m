//
//  AKLocationManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.11.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKLocationManager.h"
#import "NSThread+AnobiKit.h"
#import "AKPlacemarkDetector.h"

@implementation AKLocationManager {
    dispatch_queue_t queue;
    NSMutableArray *detectors;
}

+ (instancetype)manager {
    return [self managerWithQOSClass:QOS_CLASS_DEFAULT];
}

+ (instancetype)managerWithQOSClass:(qos_class_t)qos {
    return [[self alloc] initWithQOSClass:qos];
}

- (instancetype)initWithQOSClass:(qos_class_t)qos {
    if (self = [super init]) {
        detectors = [NSMutableArray new];
        queue = dispatch_get_global_queue(qos, 0);
    }
    return self;
}

- (void)placemarkFetch:(void (^)(NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    if (!fetchBlock) return;
    dispatch_asyncmain(^{
        [self->detectors addObject:[AKPlacemarkDetector detectorWithQueue:self->queue fetchBlock:^(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error) {
            dispatch_asyncmain(^{
                [self->detectors removeObject:detector];
                fetchBlock(placemarks, error);
            });
        }]];
    });
}

@end


