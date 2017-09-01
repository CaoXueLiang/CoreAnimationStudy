//
//  CATransformLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CATransformLayerController.h"
#import <CoreText/CoreText.h>
#import "TrackBallModel.h"

static CGFloat sideLength = 160;
@interface CATransformLayerController ()
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) CATransformLayer *transFormLayer;
@property (nonatomic,strong) CATextLayer *swipeMeTextLayer;
@property (nonatomic,strong) TrackBallModel *model;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) CALayer *layer1;
@property (nonatomic,strong) CALayer *layer2;
@property (nonatomic,strong) CALayer *layer3;
@property (nonatomic,strong) CALayer *layer4;
@property (nonatomic,strong) CALayer *layer5;
@property (nonatomic,strong) CALayer *layer6;
@end

@implementation CATransformLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}

- (void)addSubViews{
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.tipLabel];
    
    //layer1
    _layer1 = [self sideLayerWithColor:[UIColor redColor] alpha:0.7];
    [_layer1 addSublayer:self.swipeMeTextLayer];
    [self.transFormLayer addSublayer:_layer1];
    
    //layer2
    _layer2 = [self sideLayerWithColor:[UIColor orangeColor] alpha:0.7];
    CATransform3D transform = CATransform3DMakeTranslation(sideLength/2.0, 0, sideLength / -2.0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    _layer2.transform = transform;
    [self.transFormLayer addSublayer:_layer2];
    
    //layer3
    _layer3 = [self sideLayerWithColor:[UIColor yellowColor] alpha:0.7];
    _layer3.transform = CATransform3DMakeTranslation(0, 0, -sideLength);
    [self.transFormLayer addSublayer:_layer3];
    
    //layer4
    _layer4 = [self sideLayerWithColor:[UIColor greenColor] alpha:0.7];
    CATransform3D transformOther = CATransform3DMakeTranslation(-sideLength/2.0, 0, -sideLength/2);
    transformOther = CATransform3DRotate(transformOther, -M_PI_2, 0, 1, 0);
    _layer4.transform = transformOther;
    [self.transFormLayer addSublayer:_layer4];
    
    //layer5
    _layer5 = [self sideLayerWithColor:[UIColor blueColor] alpha:0.7];
    CATransform3D blueTransform = CATransform3DMakeTranslation(0, sideLength/2.0, -sideLength/2.0);
    blueTransform = CATransform3DRotate(blueTransform, -M_PI_2, 1, 0, 0);
    _layer5.transform = blueTransform;
    [self.transFormLayer addSublayer:_layer5];
    
    //layer6
    _layer6 = [self sideLayerWithColor:[UIColor purpleColor] alpha:0.7];
    CATransform3D pureTransform = CATransform3DMakeTranslation(0, -sideLength/2, -sideLength/2);
    pureTransform = CATransform3DRotate(pureTransform, M_PI_2, 1, 0, 0);
    _layer6.transform = pureTransform;
    [self.transFormLayer addSublayer:_layer6];
    
    self.transFormLayer.anchorPointZ = -sideLength/2.0;
    [self.containerView.layer addSublayer:self.transFormLayer];
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.containerView];
    if (self.model) {
        [self.model setStartPointFromLocation:point];
    }else{
        self.model = [TrackBallModel initWithLocation:point bounds:self.containerView.bounds];
    }
    
    NSString *tipString;
    if ([_layer1 hitTest:point]) {
        tipString = @"点击了红色Layer";
    }
    if ([_layer2 hitTest:point]) {
        tipString = @"点击了橘红色Layer";
    }
    if ([_layer3 hitTest:point]) {
        tipString = @"点击了黄色Layer";
    }
    if ([_layer4 hitTest:point]) {
        tipString = @"点击了绿色Layer";
    }
    if ([_layer5 hitTest:point]) {
        tipString = @"点击了蓝色Layer";
    }
    if ([_layer6 hitTest:point]) {
        tipString = @"点击了棕色Layer";
    }
    self.tipLabel.text = tipString;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.containerView];
    CATransform3D transform = [self.model rotationTransformForLocation:point];
    self.containerView.layer.sublayerTransform = transform;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.containerView];
    [self.model finalizeTrackBallForLocation:point];
}


#pragma mark - Private Menthod
- (CALayer *)sideLayerWithColor:(UIColor*)color alpha:(CGFloat)alpha{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, sideLength, sideLength);
    layer.position = CGPointMake((KScreenWidth-40)/2, (KScreenWidth-40)/2);
    layer.backgroundColor = color.CGColor;
    layer.opacity = alpha;
    return layer;
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(20, 80, KScreenWidth-40, KScreenWidth-40)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, KscreenHeight-50, KScreenWidth-40, 30)];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textColor = [UIColor redColor];
    }
    return _tipLabel;
}

- (CATransformLayer *)transFormLayer{
    if (!_transFormLayer) {
        _transFormLayer = [CATransformLayer layer];
    }
    return _transFormLayer;
}

- (CATextLayer *)swipeMeTextLayer{
    if (!_swipeMeTextLayer) {
        _swipeMeTextLayer = [CATextLayer layer];
        _swipeMeTextLayer.frame = CGRectMake(0.0,sideLength/4.0,sideLength,sideLength / 2.0);
        NSString *str = @"Swipe Me";
        _swipeMeTextLayer.string = str;
        _swipeMeTextLayer.alignmentMode = kCAAlignmentCenter;
        _swipeMeTextLayer.foregroundColor = [UIColor whiteColor].CGColor;
        CFStringRef fontName = (__bridge CFStringRef)(@"Noteworthy-Light");
        CTFontRef fontRef = CTFontCreateWithName(fontName, 24.0, nil);
        _swipeMeTextLayer.font = fontRef;
        _swipeMeTextLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _swipeMeTextLayer;
}

@end

