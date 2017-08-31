//
//  ScrollingView.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ScrollingView.h"

@implementation ScrollingView
+ (Class)layerClass{
    //设置寄主图层为 CAScrollLayer 类型
    return [CAScrollLayer class];
}

#pragma mark - Init Menthod
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    self.layer.masksToBounds = YES;
    ((CAScrollLayer *)self.layer).scrollMode = kCAScrollBoth;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];
}

#pragma mark - Event Response
- (void)panGesture:(UIPanGestureRecognizer *)pan{
    CGPoint offset = self.bounds.origin;
    CGPoint currentPoint = [pan translationInView:self];
    offset.x -= currentPoint.x;
    offset.y -= currentPoint.y;
    if (pan.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            [(CAScrollLayer *)self.layer scrollPoint:offset];
        } completion:^(BOOL finished) {
            [(CAScrollLayer *)self.layer scrollPoint:CGPointZero];
        }];
    }
}

@end

