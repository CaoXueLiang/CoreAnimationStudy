//
//  ViewAnimationsController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ViewAnimationsController.h"

@interface ViewAnimationsController ()<CAAnimationDelegate>
@property (nonatomic,strong) CALayer *snowLayer;
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ViewAnimationsController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"CoreAniamtion基础动画";
    [self.view.layer addSublayer:self.snowLayer];
    [self setNavigation];
}

- (void)setNavigation{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"动画属性" style:UIBarButtonItemStylePlain target:self action:@selector(switchType)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark - Event Response
- (void)switchType{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"动画属性" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = obj;
        UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.snowLayer removeAllAnimations];
            if ([str isEqualToString:@"opacity"]) {
                [self opacityAnimation];
            }else if ([str isEqualToString:@"rotation"]){
                [self rotationAnimation];
            }else if ([str isEqualToString:@"scale"]){
                [self scaleAnimation];
            }else if ([str isEqualToString:@"translation"]){
                [self transformAnimation];
            }
        }];
        [controller addAction:action];
    }];
    [self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark - Private Menthod
/*KeyPath支持的属性
 https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html#//apple_ref/doc/uid/TP40004514-CH12-SW8*/
/*
 基本动画的步骤
 1.初始化动画并设置动画属性
 2.设置动画属性初始值（可以省略）、结束值以及其他动画属性
 3.给图层添加动画
 */

/**
 透明度动画
 */
- (void)opacityAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.toValue = @0.5;
    animation.duration = 1.5;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    [self.snowLayer addAnimation:animation forKey:@"PositionAnimation"];
}

/**
 位置移动动画
 */
- (void)positionaimation{
    /*position | position.x | position.y*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:self.snowLayer.position];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(280, 100)];
    animation.duration = 1;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    [self.snowLayer addAnimation:animation forKey:@"PositionAnimation"];
}

/**
 旋转动画
 */
- (void)rotationAnimation{
    /*transform.rotation | transform.rotation.x | transform.rotation.y | transform.rotation.z*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = @(M_PI_2);
    animation.duration = 2;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.autoreverses = YES;
    [self.snowLayer addAnimation:animation forKey:@"transform"];
}

/**
 缩放动画
 */
- (void)scaleAnimation{
    /*transform.scale | transform.scale.x | transform.scale.y | transform.scale.z*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.toValue = @(2);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    [self.snowLayer addAnimation:animation forKey:@"scale"];
}

/*位置移动动画*/
- (void)transformAnimation{
    /*transform.translation | transform.translation.x | transform.translation.y transform.translation.z*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.toValue = @(200);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.snowLayer addAnimation:animation forKey:@"translation"];
}

/*frame动画*/
- (void)frameAnimation{
    /*bounds.origin |/Users/bjovov/Desktop/CoreAniationStudy/CoreAniationStudy bounds.origin.x | bounds.origin.y | bounds.size.width | bounds.size.height*/
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    animation.toValue = @(150);
    animation.autoreverses = YES;
    animation.duration = 1.5;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.snowLayer addAnimation:animation forKey:@"translationBounds"];
}

#pragma mark - Setter && Getetr
- (CALayer *)snowLayer{
    if (!_snowLayer) {
        _snowLayer = [CALayer layer];
        _snowLayer.bounds = CGRectMake(0, 0, 150, 150);
        _snowLayer.position = CGPointMake(KScreenWidth/2, KscreenHeight/2);
        _snowLayer.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:1.0 alpha:1.0].CGColor;
    }
    return _snowLayer;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"opacity",@"scale",@"translation",@"rotation"];
    }
    return _dataArray;
}

@end

