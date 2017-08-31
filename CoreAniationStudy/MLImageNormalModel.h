//
//  MLImageNormalModel.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/29.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLImageNormalModel : NSObject
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,copy) NSString *titleDetail;
+ (instancetype)initWithDictionary:(NSDictionary*)dict;
@end
