//
//  AKPlacemarkDetector.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 14.02.2018.
//

#import <Foundation/Foundation.h>
@class CLPlacemark;

@interface AKPlacemarkDetector : NSObject
+ (instancetype)detectorWithQueue:(dispatch_queue_t)queue fetchBlock:(void (^)(AKPlacemarkDetector *detector, NSArray<CLPlacemark *> *placemarks, NSError *error))fetchBlock;
@end
