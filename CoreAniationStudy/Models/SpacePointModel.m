//
//  SpacePointModel.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/9/1.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "SpacePointModel.h"

@implementation SpacePointModel
+ (instancetype)instantMenthod{
    SpacePointModel *model = [[SpacePointModel alloc]init];
    model.x = 0;
    model.y = 0;
    model.z = 0;
    return model;
}

@end
