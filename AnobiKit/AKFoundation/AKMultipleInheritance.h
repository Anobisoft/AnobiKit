//
//  AKMultipleInheritance.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2018-03-06.
//  Copyright © 2018 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AKMultipleInheritance)

+ (BOOL)inheritMethod:(SEL)selector from:(Class)parent;

@end
