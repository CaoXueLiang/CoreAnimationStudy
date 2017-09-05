//
//  CustomTransformController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/9/2.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CustomTransformController.h"

@interface CustomTransformController ()
@property (nonatomic,strong) UIButton *performButton;
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) CALayer *imagLayer;
@end

@implementation CustomTransformController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"自定义动画";
    /*[self.view addSubview:self.performButton];
    self.performButton.frame = CGRectMake(0, 0, 100, 40);
    self.performButton.center = self.view.center;*/
    [self addContainerView];
    [self addAnimation];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGesture];
}

- (void)addContainerView{
    [self.view addSubview:self.containerView];
    [self.containerView.layer addSublayer:self.imagLayer];
    self.imagLayer.frame = self.containerView.bounds;
}

/**
 手动动画
 */
- (void)addAnimation{
    //添加透视变换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    self.containerView.layer.sublayerTransform = transform;
    
    //将动画的speed设置为0
    self.imagLayer.speed = 0;
    
    //添加开门效果动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.duration = 2;
    animation.toValue = @(-M_PI_2);
    [self.imagLayer addAnimation:animation forKey:@"RotationAnimation"];
}

#pragma mark - Event Response
- (void)pan:(UIPanGestureRecognizer *)sender{
    CGPoint point = [sender translationInView:sender.view];
    CGFloat currentX = point.x;
    //将当前点转化为动画时间
    currentX /= 200.0f;
    
    //更新timeOffset
    CFTimeInterval timeOffSet = self.imagLayer.timeOffset;
    timeOffSet = MIN(0.999, MAX(0.0, timeOffSet - currentX));
    self.imagLayer.timeOffset = timeOffSet;
}

/*
 过渡动画做基础的原则就是对原始的图层外观截图，然后添加一段动画，平滑过渡到图层改变之后那个截图的效果。
 如果我们知道如何对图层截图，我们就可以使用属性动画来代替CATransition或者是UIKit的过渡方法来实现动画。
 */
- (void)performAnimation{
  
    //保存当前view的截图
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //将当前截图添加到最前方
    UIView *coverView = [[UIImageView alloc]initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    //更新view的属性
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    //添加动画
    [UIView animateWithDuration:1.0 animations:^{
        
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
}

#pragma mark - Setter && Getter
- (UIButton *)performButton{
    if (!_performButton) {
        _performButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_performButton setTitle:@"点击切换" forState:UIControlStateNormal];
        [_performButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _performButton.backgroundColor = [UIColor blueColor];
        [_performButton addTarget:self action:@selector(performAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _performButton;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(60, 150, 200, 160)];
    }
    return _containerView;
}

- (CALayer *)imagLayer{
    if (!_imagLayer) {
        _imagLayer = [CALayer layer];
        UIImage *image = [UIImage imageNamed:@"images4"];
        _imagLayer.contents = (__bridge id)image.CGImage;
        _imagLayer.contentsGravity = kCAGravityResizeAspectFill;
        _imagLayer.contentsScale = [UIScreen mainScreen].scale;
        _imagLayer.anchorPoint = CGPointMake(0, 0.5);
    }
    return _imagLayer;
}

@end


