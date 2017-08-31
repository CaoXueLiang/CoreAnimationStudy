//
//  SwitchCell.h
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchCell : UITableViewCell
@property (nonatomic,copy) void(^didSelectSwitch)(NSString *type,BOOL selected);
- (void)setTitle:(NSString *)title isSelect:(BOOL)select;
@end
