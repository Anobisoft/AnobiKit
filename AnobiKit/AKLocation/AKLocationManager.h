//
//  AKLocationManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-11-24.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AKLocationManager : NSObject

- (void)placemarkFetch:(void (^)(NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock;

@end
