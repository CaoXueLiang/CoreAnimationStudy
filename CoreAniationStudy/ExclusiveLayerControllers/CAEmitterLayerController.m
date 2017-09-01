//
//  CAEmitterLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CAEmitterLayerController.h"

@interface CAEmitterLayerController ()
@property (nonatomic,strong) UIView *containerView;
@end

@implementation CAEmitterLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    [self setUpEmitterLayer];
}

- (void)setUpEmitterLayer{
    //创建CAEmitterLayer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.masksToBounds = YES;
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    //设置emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake((KScreenWidth)/2.0, (KScreenWidth)/2.0);
    
    //创建例子模板
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"smallStar"].CGImage;
    cell.contentsRect = CGRectMake(0, 0, 1, 1);
    cell.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
    cell.redRange = 1.0;
    cell.greenRange = 1.0;
    cell.blueRange = 1.0;
    cell.alphaRange = 0.0;
    cell.redSpeed = 0.0;
    cell.greenSpeed = 0.0;
    cell.blueSpeed = 0.0;
    
    cell.alphaSpeed = -0.5;
    cell.scale = 1.0;
    cell.scaleRange = 0.0;
    cell.scaleSpeed = 0.1;
    
    cell.spin = 130*M_PI/180.0;
    cell.spinRange = 0;
    cell.emissionLatitude = 0;
    cell.emissionLongitude = 0;
    cell.emissionRange = M_PI*2;
    
    cell.lifetime = 1.0;
    cell.lifetimeRange = 0.0;
    cell.birthRate = 250.0;
    cell.velocity = 50.0;
    cell.velocityRange = 500.0;
    cell.xAcceleration = -750.0;
    cell.yAcceleration = 0.0;
    
    //将粒子模板添加到发射器
    emitter.emitterCells = @[cell];
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenWidth)];
        _containerView.backgroundColor = [UIColor blackColor];
    }
    return _containerView;
}

@end
