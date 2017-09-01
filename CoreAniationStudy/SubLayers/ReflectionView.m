//
//  ReflectionView.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/31.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ReflectionView.h"

@implementation ReflectionView
+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    CAReplicatorLayer *layer = (CAReplicatorLayer*)self.layer;
    layer.instanceCount = 2;
    
    //设置tansform
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffSet = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffSet, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    layer.instanceAlphaOffset = -0.6;
}

@end
