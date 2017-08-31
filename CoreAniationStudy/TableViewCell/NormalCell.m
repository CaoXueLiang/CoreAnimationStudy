//
//  NormalCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "NormalCell.h"
#import <Masonry/Masonry.h>

@interface NormalCell()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@end

@implementation NormalCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)addSubviews{
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    
    [self.contentView addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(20);
        make.left.equalTo(self.leftLabel.mas_right);
    }];
}

#pragma mark - Public Menthod
- (void)setTitle:(NSString *)title value:(NSString *)value{
    _leftLabel.text = title;
    _rightLabel.text = value;
}

#pragma mark - Setter && Getter
- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.textColor = [UIColor grayColor];
        _leftLabel.font = [UIFont systemFontOfSize:13];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [UILabel new];
        _rightLabel.textColor = [UIColor blueColor];
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

@end
