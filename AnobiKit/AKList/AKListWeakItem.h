//
//  AKListWeakItem.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import "AKListAbstractItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKListWeakItem : AKListAbstractItem <NSCopying, NSMutableCopying>

@end

@interface AKListMutableWeakItem<__covariant ObjectType> : AKListWeakItem

@property (nonatomic, readwrite) ObjectType object;

@end


NS_ASSUME_NONNULL_END
