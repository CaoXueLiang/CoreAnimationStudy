//
//  TrackBallModel.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/31.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "TrackBallModel.h"
#import "SpacePointModel.h"

static CGFloat tolerance = 0.001;
@interface TrackBallModel()
@property (nonatomic,assign) CATransform3D baseTransform;
@property (nonatomic,assign) CGFloat trackBallRadius;
@property (nonatomic,assign) CGPoint trackBallCenter;
@property (nonatomic,strong) SpacePointModel *spaceStart;
@end

@implementation TrackBallModel
#pragma mark - Init Menthod
+ (instancetype)initWithLocation:(CGPoint)point bounds:(CGRect)bounds{
    TrackBallModel *model = [[TrackBallModel alloc]init];
    CGFloat minRadius = MIN(bounds.size.width, bounds.size.height);
    model.trackBallRadius = minRadius *0.5;
    model.baseTransform = CATransform3DIdentity;
    model.trackBallCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    model.spaceStart = [SpacePointModel instantMenthod];
    return model;
}

#pragma mark - Public Menthod
- (void)setStartPointFromLocation:(CGPoint)location{
    self.spaceStart.x = location.x - self.trackBallCenter.x;
    self.spaceStart.y = location.y - self.trackBallCenter.y;
    CGFloat distance = pow(self.spaceStart.x, 2) + pow(self.spaceStart.y, 2);
    self.spaceStart.z = distance > pow(self.trackBallRadius, 2) ? 0 : sqrt(pow(self.trackBallRadius, 2) - distance);
}

- (void)finalizeTrackBallForLocation:(CGPoint)location{
    self.baseTransform = [self rotationTransformForLocation:location];
}

- (CATransform3D)rotationTransformForLocation:(CGPoint)location{
    SpacePointModel *currentPoint = [[SpacePointModel alloc]init];
    currentPoint.x = location.x - self.trackBallCenter.x;
    currentPoint.y = location.y - self.trackBallCenter.y;
    currentPoint.z = 0;
    BOOL isTure = fabs(currentPoint.x - self.spaceStart.x) < tolerance && fabs(currentPoint.y - self.spaceStart.y) < tolerance;
    if (isTure) {
        return CATransform3DIdentity;
    }
    
    CGFloat distance = pow(currentPoint.x, 2) + pow(currentPoint.y, 2);
    if (distance > pow(self.trackBallRadius, 2)) {
        currentPoint.z = 0;
    }else{
        currentPoint.z = sqrt(pow(self.trackBallRadius, 2) - distance);
    }
    
    SpacePointModel *startPoint = self.spaceStart;
    SpacePointModel *nowPoint = currentPoint;
    
    CGFloat x = startPoint.y *nowPoint.z - startPoint.z *nowPoint.y;
    CGFloat y = -startPoint.x *nowPoint.z + startPoint.z *nowPoint.x;
    CGFloat z = startPoint.x *nowPoint.y - startPoint.y *nowPoint.x;
    
    SpacePointModel *lastPoint = [[SpacePointModel alloc]init];
    lastPoint.x = x;
    lastPoint.y = y;
    lastPoint.z = z;
    
    CGFloat startLength = sqrt(pow(startPoint.x, 2) + pow(startPoint.y, 2) + pow(startPoint.z, 2));
    CGFloat currentLength = sqrt(pow(nowPoint.x, 2) + pow(nowPoint.y, 2) + pow(nowPoint.z, 2));
    CGFloat startDotCurrent = startPoint.x *nowPoint.x + startPoint.y *nowPoint.y + startPoint.z *nowPoint.z;
    CGFloat rotationLength = sqrt(pow(lastPoint.x, 2) + pow(lastPoint.y, 2) + pow(lastPoint.z, 2));
    CGFloat angle = atan2(rotationLength / (startLength * currentLength), startDotCurrent / (startLength * currentLength));
   
    lastPoint.x /= rotationLength;
    lastPoint.y /= rotationLength;
    lastPoint.z /= rotationLength;
    
    CATransform3D rotationTransform = CATransform3DMakeRotation(angle, lastPoint.x, lastPoint.y, lastPoint.z);
    return CATransform3DConcat(rotationTransform, _baseTransform);
}

@end
