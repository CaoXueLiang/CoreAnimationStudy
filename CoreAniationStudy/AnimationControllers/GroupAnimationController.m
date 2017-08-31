//
//  GroupAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "GroupAnimationController.h"

@interface GroupAnimationController ()<CAAnimationDelegate>
@property (nonatomic,strong) CALayer *snowLayer;
@end

@implementation GroupAnimationController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"CoreAniamtion动画组";
    [self.view.layer addSublayer:self.snowLayer];
    [self addPath];
    [self groupAnimation];
}

#pragma mark - Animation Menthod
/*关键帧动画*/
- (CAKeyframeAnimation *)pathKeyFrameAniamtion{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 100);
    CGPathAddCurveToPoint(path, NULL, 250, 200, 20, 300, 250, 400);
    animation.path = path;
    CGPathRelease(path);
    return animation;
}

/*旋转动画*/
- (CABasicAnimation *)roationAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(M_PI*2);
    return animation;
}

/*创建动画组*/
- (void)groupAnimation{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[[self pathKeyFrameAniamtion],[self roationAnimation]];
    group.delegate=self;
    group.duration=7.0;//设置动画时间，如果动画组中动画已经设置过动画属性则不再生效
    group.beginTime=CACurrentMediaTime()+1;//延迟五秒执行
    [self.snowLayer addAnimation:group forKey:@"groupAnimation"];
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

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.snowLayer.position = CGPointMake(250, 400);
    [CATransaction commit];
    /*取消了隐式动画,还是会闪烁一下*/
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

