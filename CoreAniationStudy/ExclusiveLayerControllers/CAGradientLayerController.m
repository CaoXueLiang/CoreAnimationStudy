//
//  CAGradientLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CAGradientLayerController.h"

@interface CAGradientLayerController ()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@end

@implementation CAGradientLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    //[self singleGradient];
    [self multipleGradient];
}

- (void)addSubViews{
    [self.view addSubview:self.containerView];
    self.containerView.frame = CGRectMake(20, 100, KScreenWidth-40, KScreenWidth-40);
    
    [self.containerView.layer addSublayer:self.gradientLayer];
    self.gradientLayer.frame = self.containerView.bounds;
}

//基础渐变
- (void)singleGradient{
    CGColorRef color1 = [UIColor redColor].CGColor;
    CGColorRef color2 = [UIColor blueColor].CGColor;
    _gradientLayer.colors = @[(__bridge id)color1,(__bridge id)color2];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1, 1);
}

//多重渐变
- (void)multipleGradient{
    CGColorRef color1 = [UIColor redColor].CGColor;
    CGColorRef color2 = [UIColor blueColor].CGColor;
    CGColorRef color3 = [UIColor yellowColor].CGColor;
    CGColorRef color4 = [UIColor greenColor].CGColor;
    _gradientLayer.colors = @[(__bridge id)color1,(__bridge id)color2,(__bridge id)color3,(__bridge id)color4];
    /*
     locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，
     否则你将会得到一个空白的渐变。
     */
    _gradientLayer.locations = @[@0,@0.2,@0.4,@1];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1, 1);
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
    }
    return _containerView;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
    }
    return _gradientLayer;
}

@end
