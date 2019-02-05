//
//  AKListItemBox.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 04/02/2019.
//  Copyright © 2019 Anobisoft. All rights reserved.
//

#import <AnobiKit/AKListItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKListItemBox<__covariant ObjectType> : NSObject <AKListItem>

@property (nonatomic, readonly) ObjectType object;

+ (instancetype):(ObjectType)object;


@end

NS_ASSUME_NONNULL_END
