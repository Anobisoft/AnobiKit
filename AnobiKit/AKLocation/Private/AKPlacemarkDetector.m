//
//  AKPlacemarkDetector.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.02.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import "AKPlacemarkDetector.h"

typedef void(^AKPlacemarkDetectorFetchBlock)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error);

@interface AKPlacemarkDetector() <CLLocationManagerDelegate>
@property (nonatomic) AKPlacemarkDetectorFetchBlock fetchBlock;
@end

@implementation AKPlacemarkDetector {
    CLLocationManager *locationManager;
}

+ (instancetype)detectorWithFetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    return [[self alloc] initWithFetchBlock:fetchBlock];
}

- (instancetype)initWithFetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock {
    if (fetchBlock && (self = [super init])) {
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
#if TARGET_OS_MAC
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        [locationManager startUpdatingLocation];
#else
        [locationManager requestWhenInUseAuthorization];
#endif
        self.fetchBlock = fetchBlock;
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
#if !TARGET_OS_MAC
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            manager.distanceFilter = kCLDistanceFilterNone;
            manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
            [manager startUpdatingLocation];
        } break;
        case kCLAuthorizationStatusNotDetermined: { //WTF?!
            [manager requestWhenInUseAuthorization];
        } break;
#endif
        case kCLAuthorizationStatusRestricted: {
            NSError *error = [NSError errorWithDomain:@"AKLocationManager" code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Core Location Authorization Restricted"}];
            if (self.fetchBlock) self.fetchBlock(self, nil, error);
            self.fetchBlock = nil; // release
        } break;
        case kCLAuthorizationStatusDenied:{
            NSError *error = [NSError errorWithDomain:@"AKLocationManager" code:-1
                                             userInfo:@{NSLocalizedDescriptionKey : @"Core Location Authorization Denied"}];
            if (self.fetchBlock) self.fetchBlock(self, nil, error);
            self.fetchBlock = nil; // release
        } break;
        default:
            break;
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
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        if (self.fetchBlock) self.fetchBlock(self, result, lastError);
        self.fetchBlock = nil; // release
    });
}

#if TARGET_OS_IOS

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
}

#endif

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
#ifdef DEBUG
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
#endif
//    if (self.fetchBlock) self.fetchBlock(self, nil, error);
//    self.fetchBlock = nil; // release
}

@end
