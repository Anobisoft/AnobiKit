//
//  NSMapTable+KeyedSubscript.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 18/03/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable<KeyType, ObjectType> (KeyedSubscript) <MutableKeyedSubscript>

- (ObjectType)objectForKeyedSubscript:(KeyType)key;
- (void)setObject:(ObjectType)obj forKeyedSubscript:(KeyType<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
