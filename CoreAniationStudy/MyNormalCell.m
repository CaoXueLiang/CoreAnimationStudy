//
//  MyNormalCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "MyNormalCell.h"

@interface MyNormalCell()
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation MyNormalCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.tipLabel];
    self.tipLabel.frame = CGRectMake(10, (55-30)/2.0, 200, 30);
}

#pragma mark - Public Menthod
- (void)setTitle:(NSString *)title{
    self.tipLabel.text = title ? : @"";
}

+ (CGFloat)cellHeight{
    return 55.0f;
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor blackColor];
        _tipLabel.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel;
}

@end

