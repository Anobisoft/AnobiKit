//
//  AKListAbstractItem.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKList.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKListAbstractItem<__covariant ObjectType> : NSObject <AKListItem>

@property (nonatomic, readonly) ObjectType object; // override!

/** Instantiation method
 @throws InstantiationException, AbstractMethodException
 */
+ (instancetype):(ObjectType)object;

/** @throws AbstractMethodException */
- (instancetype)initWithObject:(ObjectType)object;

@end

NS_ASSUME_NONNULL_END
