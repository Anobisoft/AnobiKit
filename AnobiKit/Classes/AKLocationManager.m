//
//  AKLocationManager.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.11.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKLocationManager.h"

@class AKPlacemarkDetector;
typedef void (^PlacemarkFetchBlock)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error);

@interface AKPlacemarkDetector : NSObject <CLLocationManagerDelegate>
+ (instancetype)detectorWithFetchBlock:(PlacemarkFetchBlock)fetchBlock;
@end

@implementation AKPlacemarkDetector {
    PlacemarkFetchBlock _fetchBlock;
    CLLocationManager *locationManager;
}

+ (instancetype)detectorWithFetchBlock:(PlacemarkFetchBlock)fetchBlock {
    return [[self alloc] initWithFetchBlock:fetchBlock];
}

- (instancetype)initWithFetchBlock:(PlacemarkFetchBlock)fetchBlock {
    if (fetchBlock && (self = [super init])) {
        locationManager = [CLLocationManager new];
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        [locationManager startUpdatingLocation];
        _fetchBlock = fetchBlock;
    }
    return self;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            _fetchBlock(self, result, lastError);
        });
    });
}

@end

#pragma mark -

@implementation AKLocationManager

+ (void)placemarkFetch:(void (^)(NSArray<CLPlacemark *> *placemarks))fetchBlock {
    static NSMutableArray *detectors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        detectors = [NSMutableArray new];
    });
    if (fetchBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [detectors addObject:[AKPlacemarkDetector detectorWithFetchBlock:^(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error) {
                [detectors removeObject:detector];
                fetchBlock(placemarks);
            }]];
        });
    }
}

@end


