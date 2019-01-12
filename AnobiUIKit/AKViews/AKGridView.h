//
//  AKGridView.h
//  AnobiUIKit
//
//  Created by Stanislav Pletnev on 07.04.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#if TARGET_OS_IOS

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface AKGridView : UIView

@property (nonatomic) IBInspectable CGSize cellSize;
@property (nonatomic) IBInspectable CGFloat lineWidth;

@end

#endif
