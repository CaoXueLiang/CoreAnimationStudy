//
//  ReplicatorParameterCell.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/31.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplicatorParameterCell : UITableViewCell
@property (nonatomic,copy) void(^sliderChangedBlock)(NSString *title,CGFloat value);
- (void)setTitle:(NSString *)title value:(CGFloat)value;
@end
