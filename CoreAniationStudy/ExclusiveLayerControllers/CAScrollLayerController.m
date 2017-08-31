//
//  CAScrollLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CAScrollLayerController.h"
#import "ScrollingView.h"
#import <Masonry/Masonry.h>

@interface CAScrollLayerController ()
@property (nonatomic,strong) ScrollingView *scrollView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UISwitch *horizontalSwitch;
@property (nonatomic,strong) UISwitch *verticalSwitch;
@property (nonatomic,strong) UILabel *horizontalLabel;
@property (nonatomic,strong) UILabel *verticalLabel;
@property (nonatomic,assign) BOOL horIsSelect;
@property (nonatomic,assign) BOOL verIsSelect;
@end

@implementation CAScrollLayerController
#pragma mark - Life Cycle Menthod
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    _verIsSelect = YES;
    _horIsSelect = YES;
    self.horizontalSwitch.on = _horIsSelect;
    self.verticalSwitch.on = _verIsSelect;
}

- (void)addSubViews{
    [self.view addSubview:self.scrollView];
    self.scrollView.center = CGPointMake(KScreenWidth/2, 250);
    [self.scrollView addSubview:self.backImageView];
    self.backImageView.frame = self.scrollView.bounds;
    
    [self.view addSubview:self.horizontalLabel];
    [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView.mas_left).offset(10);
        make.top.equalTo(self.scrollView.mas_bottom).offset(10);
        make.height.mas_equalTo(25);
    }];
    
    [self.view addSubview:self.horizontalSwitch];
    [self.horizontalSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.horizontalLabel.mas_right).offset(5);
        make.centerY.equalTo(self.horizontalLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
    
    [self.view addSubview:self.verticalLabel];
    [self.verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.horizontalLabel.mas_left);
        make.top.equalTo(self.horizontalLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(25);
    }];
    
    [self.view addSubview:self.verticalSwitch];
    [self.verticalSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalLabel.mas_right).offset(5);
        make.centerY.equalTo(self.verticalLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 25));
    }];
}

#pragma mark - Event Response
- (void)horizontalSwitchMenthod{
    _horizontalSwitch.on = !_horizontalSwitch.isOn;
    _horIsSelect = _horizontalSwitch.isOn;
    [self setMode];
}

- (void)verticalSwitchMenthod{
    _verticalSwitch.on = !_verticalSwitch.isOn;
    _verIsSelect = _verticalSwitch.on;
    [self setMode];
}

- (void)setMode{
    CAScrollLayer *layer = (CAScrollLayer *)self.scrollView.layer;
    if (_horIsSelect && _verIsSelect) {
        layer.scrollMode = kCAScrollBoth;
    }else if (_horIsSelect && !_verIsSelect){
        layer.scrollMode = kCAScrollHorizontally;
    }else if (!_horIsSelect && _verIsSelect){
        layer.scrollMode = kCAScrollVertically;
    }else if (!_horIsSelect && !_verIsSelect){
        layer.scrollMode = kCAScrollNone;
    }
}

#pragma mark - Setter && Getter
- (ScrollingView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[ScrollingView alloc]initWithFrame:CGRectMake(20, 100, 250, 250)];
    }
    return _scrollView;
}

- (UIImageView *)backImageView{
    if (!_backImageView) {
        UIImage *image = [UIImage imageNamed:@"cresentEarthRisesAboveLunarHorizon"];
        _backImageView = [[UIImageView alloc]initWithImage:image];
        _backImageView.contentMode = UIViewContentModeCenter;
    }
    return _backImageView;
}

- (UISwitch *)horizontalSwitch{
    if (!_horizontalSwitch) {
        _horizontalSwitch = [[UISwitch alloc]init];
        [_horizontalSwitch addTarget:self action:@selector(horizontalSwitchMenthod) forControlEvents:UIControlEventValueChanged];
    }
    return _horizontalSwitch;
}

- (UISwitch *)verticalSwitch{
    if (!_verticalSwitch) {
        _verticalSwitch = [[UISwitch alloc]init];
        [_verticalSwitch addTarget:self action:@selector(verticalSwitchMenthod) forControlEvents:UIControlEventValueChanged];
    }
    return _verticalSwitch;
}

- (UILabel *)horizontalLabel{
    if (!_horizontalLabel) {
        _horizontalLabel = [UILabel new];
        _horizontalLabel.textColor = [UIColor grayColor];
        _horizontalLabel.font = [UIFont systemFontOfSize:14];
        _horizontalLabel.text = @"Horizontal scroll";
    }
    return _horizontalLabel;
}

- (UILabel *)verticalLabel{
    if (!_verticalLabel) {
        _verticalLabel = [UILabel new];
        _verticalLabel.textColor = [UIColor grayColor];
        _verticalLabel.font = [UIFont systemFontOfSize:14];
        _verticalLabel.text = @"vertical scroll";
    }
    return _verticalLabel;
}

@end

