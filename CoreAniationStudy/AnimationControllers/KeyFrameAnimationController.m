//
//  KeyFrameAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "KeyFrameAnimationController.h"

@interface KeyFrameAnimationController ()
@property (nonatomic,strong) CALayer *snowLayer;
@end

@implementation KeyFrameAnimationController
/*关键帧动画开发分为两种形式：
 1.通过设置不同的属性值进行关键帧控制，
 2.通过绘制路径进行关键帧控制。
 后者优先级高于前者，如果设置了路径则属性值就不再起作用。*/
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"CoreAniamtion关键帧动画";
    [self.view.layer addSublayer:self.snowLayer];
    //[self attributeKeyFrameAnimation];
    [self pathKeyFrameAniamtion];
}

#pragma mark - Animation Menthod
/**
 1.通过设置不同的属性进行关键帧动画
 */
- (void)attributeKeyFrameAnimation{
     //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧和其他属性,对于关键帧动画初始值不能省略
    NSValue *key1 = [NSValue valueWithCGPoint:self.snowLayer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(20, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(250, 400)];
    animation.values = @[key1,key2,key3,key4];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.duration = 3;
    animation.autoreverses = YES;
    
    //3.添加动画到图层，添加动画后就会执行动画
    [self.snowLayer addAnimation:animation forKey:@"attributeKeyFrame"];
}

/**
 2.通过设置路径进行关键这动画
 */
- (void)pathKeyFrameAniamtion{
    [self addPath];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 100);
    CGPathAddCurveToPoint(path, NULL, 250, 200, 20, 300, 250, 400);
    animation.path = path;
    
    //各个关键帧的时间控制0-1之间，NSNumber类型
    //animation.keyTimes = @[@0,@0.5,@0.3,@0.2];
    
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.duration = 3;
    animation.autoreverses = YES;
    
    //3.添加动画到图层，添加动画后就会执行动画
    [self.snowLayer addAnimation:animation forKey:@"pathKeyFrame"];
    CGPathRelease(path);
}

- (void)addPath{
    /*绘制路径*/
    CAShapeLayer *layer = [CAShapeLayer layer];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 100);
    CGPathAddCurveToPoint(path, NULL, 250, 200, 20, 300, 250, 400);
    layer.path = path;
    [layer setStrokeColor:[UIColor blueColor].CGColor];
    [layer setFillColor:[UIColor clearColor].CGColor];
    [self.view.layer addSublayer:layer];
}

#pragma mark - Setter && Getter
- (CALayer *)snowLayer{
    if (!_snowLayer) {
        _snowLayer = [CALayer layer];
        _snowLayer.bounds = CGRectMake(0, 0, 30, 30);
        _snowLayer.position = CGPointMake(50, 100);
        UIImage *image = [UIImage imageNamed:@"雪花"];
        _snowLayer.contents = (__bridge id)image.CGImage;
    }
    return _snowLayer;
}

@end

