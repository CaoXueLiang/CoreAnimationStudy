//
//  BufferAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/9/4.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "BufferAnimationController.h"

@interface BufferAnimationController ()
@property (nonatomic,strong) UIView *ballView;
@end

@implementation BufferAnimationController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义缓冲函数";
    [self.view addSubview:self.ballView];
    self.ballView.frame = CGRectMake(0, 0, 35, 35);
    self.ballView.center = CGPointMake(KScreenWidth/2, 80);
    [self boundsAnimation];
}

/*
 但如果我们把动画分割成更小的几部分，那么我们就可以用直线来拼接这些曲线（也就是线性缓冲）。
 为了实现自动化，我们需要知道如何做如下两件事情：
 1.自动把任意属性动画分割成多个关键帧
 2.用一个数学函数表示弹性动画，使得可以对帧做便宜
 */
- (void)boundsAnimation{
    CGPoint fromPoint = CGPointMake(KScreenWidth/2, 80);
    CGPoint toPoint = CGPointMake(KScreenWidth/2, 350);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    NSInteger numPoints = animation.duration *60;
    NSMutableArray *pointArray = [NSMutableArray array];
    for (int i = 0; i<numPoints; i++) {
        CGFloat currentTime = 1.0/numPoints*i;
        currentTime = BounceEaseOut(currentTime);
        NSValue *value = [self interpolateFromValue:[NSValue valueWithCGPoint:fromPoint] toValue:[NSValue valueWithCGPoint:toPoint] time:currentTime];
        [pointArray addObject:value];
    }
    animation.values = pointArray;
    [self.ballView.layer addAnimation:animation forKey:@"BoundsAnimation"];
}


- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        CGPoint from = [fromValue CGPointValue];
        CGPoint to = [toValue CGPointValue];
        CGPoint currentPoint = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
        return [NSValue valueWithCGPoint:currentPoint];
    }
    return nil;
}

float interpolate(float from, float to, float time){
    return (to - from) * time + from;
}

/*
 更多缓冲函数请移步这个连接
 http://www.robertpenner.com/easing
 */
float BounceEaseOut(CGFloat p){
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

#pragma mark - Setter && Getter
- (UIView *)ballView{
    if (!_ballView) {
        _ballView = [[UIView alloc]init];
        UIImage *image = [UIImage imageNamed:@"足球-2"];
        _ballView.layer.contents = (__bridge id)image.CGImage;
    }
    return _ballView;
}

@end

