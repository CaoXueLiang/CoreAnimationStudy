//
//  MLImageNormalCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/29.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "MLImageNormalCell.h"
#import <Masonry/Masonry.h>
#import "MLImageNormalModel.h"

@interface MLImageNormalCell()
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *describeLabel;
@end

@implementation MLImageNormalCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.top.equalTo(self.leftImageView.mas_top);
        make.bottom.equalTo(self.leftImageView.mas_centerY);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    [self.contentView addSubview:self.describeLabel];
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView.mas_right).offset(10);
        make.top.equalTo(self.leftImageView.mas_centerY);
        make.bottom.equalTo(self.leftImageView.mas_bottom);
        make.right.equalTo(self.contentView).offset(-5);
    }];
}

#pragma mark - Public Menthod
+ (CGFloat)cellHeight{
    return 60;
}

- (void)setModel:(MLImageNormalModel *)model{
    _leftImageView.image = [UIImage imageNamed:model.imageName];
    _titleLabel.text = model.titleName;
    _describeLabel.text = model.titleDetail;
}

#pragma mark - Setter && Getter
- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
    }
    return _leftImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [UILabel new];
        _describeLabel.textColor = [UIColor grayColor];
        _describeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _describeLabel;
}

@end

