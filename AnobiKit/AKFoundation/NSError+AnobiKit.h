//
//  NSError+AnobiKit.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 21/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (AnobiKit)

+ (instancetype)errorWithCode:(NSInteger)code description:(NSString *)description;
+ (instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description;

@end

@interface NSObject (NSError)

- (NSError *)errorWithCode:(NSInteger)code description:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
