//
//  CAReplicatorLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CAReplicatorLayerController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "ReflectionView.h"

@interface CAReplicatorLayerController ()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) ReflectionView *reflectView;
@end

@implementation CAReplicatorLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.reflectView];
    [self replicatorLayerMenthod];
    [self reflectMenthod];
}

/*
 变换是逐步增加的，每个实例都是相对于前一实例布局。
 这就是为什么这些复制体最终不会出现在同意位置上
 */
- (void)replicatorLayerMenthod{
    //1.创建CARepLicatorLayer
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //2.设置replicator属性
    replicator.instanceCount = 30;
    replicator.instanceDelay = 1/30.0;
    replicator.preservesDepth = NO;
    replicator.instanceColor = [UIColor whiteColor].CGColor;
    replicator.instanceRedOffset = 0.0;
    replicator.instanceGreenOffset = -0.5;
    replicator.instanceBlueOffset = -0.5;
    replicator.instanceAlphaOffset = 0.0;
    
    //3.设置transform
    CGFloat angle = (M_PI * 2.0) / 30;
    replicator.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0);
    
    //4.创建一个子视图,然后把它放到replicator中
    CALayer *subLayer = [CALayer layer];
    CGFloat width = 10;
    CGFloat midx = CGRectGetMidX(self.containerView.bounds) - width/2;
    subLayer.frame = CGRectMake(midx, 0, width, width*3);
    subLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:subLayer];
    
    //5.添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 1;
    animation.repeatCount = HUGE_VALF;
    
    subLayer.opacity = 0;
    [subLayer addAnimation:animation forKey:@"FadeAnimation"];
}

//反射,生成镜像图片
- (void)reflectMenthod{
    CALayer *tmpLayer = [CALayer layer];
    tmpLayer.frame = self.reflectView.bounds;
    UIImage *image = [UIImage imageNamed:@"images2"];
    tmpLayer.contents = (__bridge id)image.CGImage;
    tmpLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.reflectView.layer addSublayer:tmpLayer];
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, KScreenWidth-100, KScreenWidth-100)];
    }
    return _containerView;
}

- (ReflectionView *)reflectView{
    if (!_reflectView) {
        _reflectView = [[ReflectionView alloc]initWithFrame:CGRectMake(50, KScreenWidth + 10, KScreenWidth-100, (KScreenWidth-100)*3/4.0)];
    }
    return _reflectView;
}

@end

