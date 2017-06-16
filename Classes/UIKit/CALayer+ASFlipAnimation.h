//
//  CALayer+ASFlipAnimation.h
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
} AS3DVector;

AS3DVector AS3DVectorMake(float x, float y, float z);

@interface CALayer (ASFlipAnimation)

- (void)addFlipAnimation:(CAAnimation *)animation;
- (void)addFlipAnimation:(CAAnimation *)animation withDuration:(NSTimeInterval)duration;
+ (CAKeyframeAnimation *)flipAnimationWithPiСoef:(float)piCoef rotationVector:(AS3DVector)vector;

@end
