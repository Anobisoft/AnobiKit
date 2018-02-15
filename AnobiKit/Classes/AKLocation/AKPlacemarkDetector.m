//
//  AKPlacemarkDetector.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.02.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKPlacemarkDetector.h"
#import <CoreLocation/CoreLocation.h>

@interface AKPlacemarkDetector() <CLLocationManagerDelegate>

@end

@implementation AKPlacemarkDetector {
    void (^_fetchBlock)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error);
    CLLocationManager *locationManager;
    dispatch_queue_t _queue;
}

+ (instancetype)detectorWithQueue:(dispatch_queue_t)queue fetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    return [[self alloc] initWithQueue:queue fetchBlock:fetchBlock];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue fetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    if (fetchBlock && (self = [super init])) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        [locationManager requestWhenInUseAuthorization];
        _fetchBlock = fetchBlock;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            manager.distanceFilter = kCLDistanceFilterNone;
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            [manager startUpdatingLocation];
        } break;
        case kCLAuthorizationStatusNotDetermined: { //WTF?!
            [manager requestWhenInUseAuthorization];
        } break;
        case kCLAuthorizationStatusRestricted: {
            NSError *error = [NSError errorWithDomain:@"AKLocationManager" code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Core Location Authorization Restricted"}];
            _fetchBlock(self, nil, error);
            _fetchBlock = nil;
        } break;
        case kCLAuthorizationStatusDenied:
        default: {
            NSError *error = [NSError errorWithDomain:@"AKLocationManager" code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Core Location Authorization Denied"}];
            _fetchBlock(self, nil, error);
            _fetchBlock = nil;
        } break;
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [manager stopUpdatingLocation];
    __block NSArray *result = nil;
    __block NSError *lastError = nil;
    dispatch_group_t group = dispatch_group_create();
    for (CLLocation *location in locations) {
        dispatch_group_enter(group);
#ifdef DEBUG
        NSLog(@"[DEBUG] Detected Location : %f, %f", location.coordinate.latitude, location.coordinate.longitude);
#endif
        CLGeocoder *geocoder = [CLGeocoder new] ;
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           if (error) {
                               lastError = error;
                               NSLog(@"[ERROR] Geocoder failed with error: %@", error);
                           }
                           if (result) {
                               result = [result arrayByAddingObjectsFromArray:placemarks];
                           } else {
                               result = placemarks;
                           }
                           dispatch_group_leave(group);
                       }];
    }
    dispatch_async(_queue, ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        self->_fetchBlock(self, result, lastError);
        self->_fetchBlock = nil;
    });
}

@end
