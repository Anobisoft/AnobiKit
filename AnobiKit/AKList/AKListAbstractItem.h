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

+ (instancetype):(ObjectType)object;
- (instancetype)initWithObject:(ObjectType)object;

@end

NS_ASSUME_NONNULL_END
