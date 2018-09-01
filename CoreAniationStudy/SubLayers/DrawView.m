//
//  DrawView.m
//  CoreAniationStudy
//
//  Created by 曹学亮 on 2018/8/2.
//  Copyright © 2018年 ovov.cn. All rights reserved.
//

#import "DrawView.h"

@interface DrawView()
@property (nonatomic,strong) UIBezierPath *path;
@end

@implementation DrawView
+ (Class)layerClass{
    return [CAShapeLayer class];
}

#pragma mark - init menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.path = [[UIBezierPath alloc]init];
        CAShapeLayer *shaplayer = (CAShapeLayer *)self.layer;
        shaplayer.strokeColor = [UIColor blueColor].CGColor;
        shaplayer.fillColor = [UIColor clearColor].CGColor;
        shaplayer.lineCap = kCALineCapRound;
        shaplayer.lineJoin = kCALineJoinRound;
        shaplayer.lineWidth = 3;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.path addLineToPoint:point];
    CAShapeLayer *shaplayer = (CAShapeLayer *)self.layer;
    shaplayer.path = self.path.CGPath;
}

@end
