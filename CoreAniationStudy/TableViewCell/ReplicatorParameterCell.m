//
//  ReplicatorParameterCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/31.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ReplicatorParameterCell.h"
#import <Masonry/Masonry.h>

@interface ReplicatorParameterCell()
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UISlider *slider;
@end

@implementation ReplicatorParameterCell
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
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
}

- (void)setTitle:(NSString *)title value:(CGFloat)value{
    _tipLabel.text = title;
    _slider.value = value;
}

#pragma mark - Event Response
- (void)sliderValueChanged{
    if (_sliderChangedBlock) {
        _sliderChangedBlock(_tipLabel.text,_slider.value);
    }
}

#pragma mark - Setter && Getter
- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.font = [UIFont systemFontOfSize:13];
        _tipLabel.textColor = [UIColor grayColor];
    }
    return _tipLabel;
}

- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        [_slider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventEditingChanged];
    }
    return _slider;
}

@end
