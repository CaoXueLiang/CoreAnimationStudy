//
//  MLImageNormalModel.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/29.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "MLImageNormalModel.h"

@implementation MLImageNormalModel
+ (instancetype)initWithDictionary:(NSDictionary*)dict{
    MLImageNormalModel *model = [[MLImageNormalModel alloc]init];
    model.imageName = dict[@"imageName"];
    model.titleName = dict[@"titleName"];
    model.titleDetail = dict[@"titleDetail"];
    return model;
}
@end
