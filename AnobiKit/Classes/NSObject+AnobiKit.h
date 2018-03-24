//
//  NSObject+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 06.03.2018.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AnobiKit)

+ (BOOL)inheritMethod:(SEL)selector from:(Class)parent;

@end
