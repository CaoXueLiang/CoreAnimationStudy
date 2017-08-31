//
//  MLImageNormalCell.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/29.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLImageNormalModel;
@interface MLImageNormalCell : UITableViewCell
@property (nonatomic,strong) MLImageNormalModel *model;
+ (CGFloat)cellHeight;
@end
