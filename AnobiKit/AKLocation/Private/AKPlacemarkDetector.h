//
//  AKPlacemarkDetector.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.02.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AKPlacemarkDetector : NSObject

+ (instancetype)detectorWithFetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock;

@end
