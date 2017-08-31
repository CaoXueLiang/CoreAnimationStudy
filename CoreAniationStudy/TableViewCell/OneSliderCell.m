//
//  OneSliderCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "OneSliderCell.h"
#import <Masonry/Masonry.h>

@interface OneSliderCell()
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UILabel *tipLabel;
@property (nonatomic,strong) UILabel *valueLabel;
@end

@implementation OneSliderCell
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
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(120);
    }];
    
    [self.contentView addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider.mas_left);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - Public Menthod
- (void)setTitle:(NSString *)string value:(CGFloat)value{
    if ([string isEqualToString:@"Opacity"] || [string isEqualToString:@"Shadow opacity"]) {
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
    }else if ([string isEqualToString:@"Corner radius"]){
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
    }else if ([string isEqualToString:@"Border Width"] || [string isEqualToString:@"Shadow radius"]){
        _slider.minimumValue = 0;
        _slider.maximumValue = 20;
    }
    
    _tipLabel.text = string;
    _slider.value = value;
    _valueLabel.text = [NSString stringWithFormat:@"%.1f",value];
}

#pragma mark - Event Response
- (void)valueChanged{
    _valueLabel.text = [NSString stringWithFormat:@"%.1f",_slider.value];
    if (_sliderChanged) {
        _sliderChanged(_tipLabel.text,_slider.value);
    }
}

#pragma mark - Setter && Getter
- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        _slider.minimumValue = 0;
        _slider.maximumValue = 1;
        [_slider addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.font = [UIFont systemFontOfSize:13];
    }
    return _tipLabel;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.textColor = [UIColor blueColor];
        _valueLabel.font = [UIFont systemFontOfSize:11];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

@end
