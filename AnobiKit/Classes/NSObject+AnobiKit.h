//
//  NSObject+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.03.2018.
//

#import <Foundation/Foundation.h>

@interface NSObject (AnobiKit)

+ (void)inheritMethod:(SEL)sel from:(Class)parent;

@end
