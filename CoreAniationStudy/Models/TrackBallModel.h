//
//  TrackBallModel.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/31.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackBallModel : NSObject
+ (instancetype)initWithLocation:(CGPoint)point bounds:(CGRect)bounds;
- (void)setStartPointFromLocation:(CGPoint)location;
- (void)finalizeTrackBallForLocation:(CGPoint)location;
- (CATransform3D)rotationTransformForLocation:(CGPoint)location;
@end
