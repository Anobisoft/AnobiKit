//
//  AKListItem.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AKListItem <NSObject>

@property (readonly) id object;
@property (nonatomic, strong, nullable) id<AKListItem> next;
@property (nonatomic, strong, nullable) id<AKListItem> prev;

+ (instancetype):(id)object;

@end

NS_ASSUME_NONNULL_END
