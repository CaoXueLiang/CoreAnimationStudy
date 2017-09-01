//
//  CAShapeLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CAShapeLayerController.h"

@interface CAShapeLayerController ()
@property (nonatomic,strong) CAShapeLayer *shaperLayer;
@end

@implementation CAShapeLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    [self stokenEndAnimation];
}

- (void)addSubViews{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(20, 250)];
    [bezierPath addCurveToPoint:CGPointMake(KScreenWidth-40, 250) controlPoint1:CGPointMake(KScreenWidth/3, 100) controlPoint2:CGPointMake(KScreenWidth/3*2-40, 400)];
    self.shaperLayer.path = bezierPath.CGPath;
    self.shaperLayer.lineWidth = 5;
    self.shaperLayer.strokeColor = [UIColor blackColor].CGColor;
    self.shaperLayer.fillColor = [UIColor clearColor].CGColor;
    [self.view.layer addSublayer:self.shaperLayer];
}

- (void)stokenEndAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0.5;
    animation.toValue = @1;
    animation.duration = 1;
    [self.shaperLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue = @0.5;
    animation1.toValue = @0;
    animation1.duration = 1;
    [self.shaperLayer addAnimation:animation1 forKey:@"startAnimation"];
    
    CABasicAnimation *animationLine = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animationLine.fromValue = @1;
    animationLine.toValue = @5;
    animationLine.duration = 1;
    [self.shaperLayer addAnimation:animationLine forKey:@"animationLine"];
}

#pragma mark - Setter && Getter
- (CAShapeLayer *)shaperLayer{
    if (!_shaperLayer) {
        _shaperLayer = [CAShapeLayer layer];
    }
    return _shaperLayer;
}

@end

