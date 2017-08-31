//
//  CustomLayer.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CustomLayer.h"
#import <UIKit/UIKit.h>

@implementation CustomLayer
- (void)drawInContext:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    UIImage *image = [UIImage imageNamed:@"tmpAvatar"];
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -80);
    
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, 80, 80), image.CGImage);
    CGContextRestoreGState(ctx);
}

@end
