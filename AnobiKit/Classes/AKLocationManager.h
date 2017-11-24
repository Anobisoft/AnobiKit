//
//  AKLocationManager.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 24.11.2017.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AKLocationManager : NSObject

+ (void)placemarkFetch:(void (^)(NSArray<CLPlacemark *> *placemarks))fetchBlock;

@end
