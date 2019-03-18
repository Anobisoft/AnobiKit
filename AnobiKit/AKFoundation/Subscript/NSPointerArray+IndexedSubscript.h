//
//  NSPointerArray+IndexedSubscript.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 18/03/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSPointerArray (IndexedSubscript) <MutableIndexedSubscript>

- (id)objectAtIndexedSubscript:(NSUInteger)idx;
- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
