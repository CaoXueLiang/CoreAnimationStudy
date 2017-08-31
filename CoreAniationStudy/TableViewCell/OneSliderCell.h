//
//  OneSliderCell.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneSliderCell : UITableViewCell
@property (nonatomic,copy) void(^sliderChanged)(NSString *type,CGFloat value);
- (void)setTitle:(NSString *)string value:(CGFloat)value;
@end
