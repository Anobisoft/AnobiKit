//
//  NSMapTable+KeyedSubscript.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2019-03-18.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable<KeyType, ObjectType> (KeyedSubscript) <MutableKeyedSubscript>

- (nullable ObjectType)objectForKeyedSubscript:(KeyType)key;
- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
