//
//  AKObjectMapping.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.10.17.
//

#import <Foundation/Foundation.h>

#define AKObjectMap NSDictionary<NSString *, AKPropertyMap *>
#define AKMutableObjectMap NSMutableDictionary<NSString *, AKPropertyMap *>

@class AKPropertyMap;

@protocol AKObjectMapping <NSObject>
@required
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation objectMap:(AKObjectMap *)objectMap;
+ (AKObjectMap *)objectMap;
@optional
+ (instancetype)instatiateWithExternalRepresentation:(NSDictionary *)representation;
- (NSDictionary *)keyedRepresentation;

@end

#import <AnobiKit/AKPropertyMap.h>
