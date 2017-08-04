//
//  CALayer+AKFlipAnimation.h
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-01-13
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    float x;
    float y;
    float z;
} AK3DVector;

AK3DVector AK3DVectorMake(float x, float y, float z);

@interface CALayer (AKFlipAnimation)

- (void)addFlipAnimation:(CAAnimation *)animation;
- (void)addFlipAnimation:(CAAnimation *)animation withDuration:(NSTimeInterval)duration;
+ (CAKeyframeAnimation *)flipAnimationWithPiСoef:(float)piCoef rotationVector:(AK3DVector)vector;

@end
