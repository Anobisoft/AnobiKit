//
//  AKGrainbomatedView.m
//  AnobiKit
//
//  Created by Stanislav Pletnev on 30.08.17.
//  Copyright © 2017 Anobisoft. All rights reserved.
//

#import "AKGrainbomatedView.h"

@interface AKGrainbomatedView ()
@property CAGradientLayer *gradientLayer;
@property CAShapeLayer *paraLayer;
@property CAShapeLayer *echoparaLayer;
@end

@implementation AKGrainbomatedView {
    CABasicAnimation *gradientAnimation;
    CABasicAnimation *paraLayerAnimation;
    CGFloat cathetus;
}

static CGFloat atanPI8;
+ (void)initialize {
    [super initialize];
    atanPI8 = atan(M_PI_4 * 0.7);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
    [self restartAnimation];    
}

- (void)prepareForInterfaceBuilder {
    [self commonInit];
}

- (void)commonInit {
    self.gradientLayer = [CAGradientLayer new];
    [self.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    self.gradientLayer.endPoint = CGPointMake(1.0, 0.01);
    self.gradientLayer.colors = @[
                                  (id)[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:1 green:1 blue:0 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:0.5 green:1 blue:0.5 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:0 green:1 blue:1 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:1 green:0 blue:1 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1].CGColor,
                                  (id)[UIColor colorWithRed:1 green:1 blue:0 alpha:1].CGColor,
                                  ];
    
    gradientAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    gradientAnimation.duration = 5.0;
    gradientAnimation.byValue  = @(-1 / [UIScreen mainScreen].scale);
    gradientAnimation.repeatCount = INFINITY;
    
    
    self.paraLayer = [CAShapeLayer new];
    [self.layer addSublayer:self.paraLayer];
    self.echoparaLayer = [CAShapeLayer new];
    [self.layer addSublayer:self.echoparaLayer];
    
    self.echoparaLayer.fillColor = self.paraLayer.fillColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor;
    paraLayerAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    
    paraLayerAnimation.duration = self.blickDuration ?: 1.2;
    paraLayerAnimation.repeatCount = 1;
    paraLayerAnimation.removedOnCompletion = YES;
}

- (void)layoutSubviews {
    self.gradientLayer.frame = CGRectMake(0, 0, 7 * self.bounds.size.width / 6, self.bounds.size.height);
    #if !TARGET_INTERFACE_BUILDER
    self.gradientLayer.frame = CGRectMake(0, 0, 7 * self.bounds.size.width, self.bounds.size.height);
    gradientAnimation.toValue = @(self.gradientLayer.position.x);
    gradientAnimation.fromValue   = @(self.gradientLayer.position.x - 6.0 * self.bounds.size.width);
    [self.gradientLayer removeAnimationForKey:@"gradientAnimation"];
    [self.gradientLayer addAnimation:gradientAnimation forKey:@"gradientAnimation"];
    #endif
    
    [self redrawParaLayers];
    [super layoutSubviews];
}

@synthesize blickDuration = _blickDuration;
- (void)setBlickDuration:(CGFloat)blickDuration {
    _blickDuration = blickDuration >= 0.3 ? blickDuration : 1.2;
    if (paraLayerAnimation) paraLayerAnimation.duration = _blickDuration;
}

@synthesize blickWidth = _blickWidth;
- (void)setBlickWidth:(CGFloat)blickWidth {
    _blickWidth = blickWidth;
    [self redrawParaLayers];
}

- (void)redrawParaLayers {    
    cathetus = self.bounds.size.height * atanPI8;
    if (self.blickWidth < 4) {
        self.blickWidth = self.bounds.size.width * 0.05;
    }
    
#if TARGET_INTERFACE_BUILDER
    CGFloat start =  10;
#else
    CGFloat start =  - cathetus - self.blickWidth;
#endif
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(start + cathetus, 0)];
    [path addLineToPoint:CGPointMake(start + cathetus + self.blickWidth * 0.5, 0)];
    [path addLineToPoint:CGPointMake(start + self.blickWidth * 0.5, self.frame.size.height)];
    [path closePath];
    self.paraLayer.path = path.CGPath;
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(start + self.blickWidth * 0.625, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(start + self.blickWidth * 0.625 + cathetus, 0)];
    [path addLineToPoint:CGPointMake(start + self.blickWidth * 0.625 + cathetus + self.blickWidth * 0.15, 0)];
    [path addLineToPoint:CGPointMake(start + self.blickWidth * 0.625 + self.blickWidth * 0.15, self.frame.size.height)];
    [path closePath];
    self.echoparaLayer.path = path.CGPath;
}

- (void)restartAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(((float)rand() / RAND_MAX + 0.5) * 3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat sh = cathetus + self.blickWidth;
        paraLayerAnimation.fromValue = @(self.paraLayer.position.x - sh);
        paraLayerAnimation.toValue   = @(self.paraLayer.position.x + self.bounds.size.width + sh);
        [self.paraLayer removeAnimationForKey:@"paraLayerAnimation"];
        [self.paraLayer addAnimation:paraLayerAnimation forKey:@"paraLayerAnimation"];
        
        paraLayerAnimation.fromValue = @(self.echoparaLayer.position.x - sh);
        paraLayerAnimation.toValue   = @(self.echoparaLayer.position.x + self.bounds.size.width + sh);
        [self.echoparaLayer removeAnimationForKey:@"paraLayerAnimation"];
        [self.echoparaLayer addAnimation:paraLayerAnimation forKey:@"paraLayerAnimation"];
        [self restartAnimation];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
