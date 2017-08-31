//
//  SwitchCell.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "SwitchCell.h"
#import <Masonry/Masonry.h>

@interface SwitchCell()
@property (nonatomic,strong) UISwitch *switchButton;
@property (nonatomic,strong) UILabel *tipLabel;
@end

@implementation SwitchCell
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
    
    [self.contentView addSubview:self.switchButton];
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(80);
    }];
}

#pragma mark - Public Menthod
- (void)setTitle:(NSString *)title isSelect:(BOOL)select{
    _tipLabel.text = title;
    _switchButton.on = select;
}

#pragma mark - Event Response
- (void)switchButtonClicked{
    _switchButton.on = !_switchButton.on;
    if (_didSelectSwitch) {
        _didSelectSwitch(_tipLabel.text,_switchButton.isOn);
    }
}

#pragma mark - Setter && Getter
- (UISwitch *)switchButton{
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc]init];
        [_switchButton addTarget:self action:@selector(switchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.font = [UIFont systemFontOfSize:13];
    }
    return _tipLabel;
}

@end

