//
//  CALayer+AKFlipAnimation.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 2017-01-13
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "CALayer+AKFlipAnimation.h"

#define ASAnimationDefaultDuration 0.6f

AK3DVector AK3DVectorMake(float x, float y, float z) {
    AK3DVector v;
    v.x = x;
    v.y = y;
    v.z = z;
    return v;
}

@implementation CALayer(AKFlipAnimation)

- (void)addFlipAnimation:(CAAnimation *)anim {
    self.zPosition = MAX(self.bounds.size.width, self.bounds.size.height) / 2 + 1;
    [self addAnimation:anim forKey:nil];
}

- (void)addFlipAnimation:(CAAnimation *)anim withDuration:(NSTimeInterval)duration {
    anim.duration = duration;
    [self addFlipAnimation:anim];
}

+ (CAKeyframeAnimation *)flipAnimationWithPiСoef:(float)piCoef rotationVector:(AK3DVector)vector {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (int i = 0; i <= 20; i++) {
        [mutableArray addObject:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI * piCoef * i / 20, vector.x, vector.y, vector.z)]];
    }
    animation.values = mutableArray.copy;
    animation.autoreverses = NO;
    animation.repeatCount = 1.0f;
    animation.duration = ASAnimationDefaultDuration;
    return animation;
}

@end
