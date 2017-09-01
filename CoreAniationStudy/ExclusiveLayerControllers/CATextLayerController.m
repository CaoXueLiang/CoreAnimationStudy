//
//  CATextLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CATextLayerController.h"
#import <CoreText/CoreText.h>

@interface CATextLayerController ()
@property (nonatomic,strong) UIView *labelView;
@property (nonatomic,strong) CATextLayer *textLayer;
@end

@implementation CATextLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    //[self PlainStringLabel];
    
    [self attributeStringLabel];
}

- (void)addSubViews{
    [self.view addSubview:self.labelView];
    self.labelView.frame = CGRectMake(15, 80, KScreenWidth-30, 350);
    self.textLayer.frame = self.labelView.bounds;
    [self.labelView.layer addSublayer:self.textLayer];
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
}

#pragma mark - Private Menthod
- (void)PlainStringLabel{
    //设置文本属性
    _textLayer.foregroundColor = [UIColor blueColor].CGColor;
    _textLayer.alignmentMode = kCAAlignmentNatural;
    _textLayer.wrapped = YES;
    
    //设置字体
    UIFont *font = [UIFont systemFontOfSize:24];
    CFStringRef fontString = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontString);
    _textLayer.font = fontRef;
    _textLayer.fontSize = font.pointSize;
    
    //显示文本
    NSString *plainString = @"Lorem ipsum dolor sit amet, consectetur adipiscing \n elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \n leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \n fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \n lobortis";
    _textLayer.string = plainString;
}

- (void)attributeStringLabel{
    //设置文本属性
    _textLayer.alignmentMode = kCAAlignmentNatural;
    _textLayer.wrapped = YES;
    
    //设置字体
    UIFont *font = [UIFont systemFontOfSize:15];
    NSString *plainString = @"Lorem ipsum dolor sit amet, consectetur adipiscing \n elit. Quisque massa arcu, eleifend velvarius in, facilisis pulvinar \n leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel \n fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \n lobortis";
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:plainString];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CTFontRef fontRed = CTFontCreateWithName(fontName, font.pointSize, &CGAffineTransformIdentity);
    
    //设置富文本属性
    NSDictionary *attribute = @{
                                (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blackColor].CGColor,
                                (__bridge id)kCTFontAttributeName : (__bridge id)fontRed,
                                
                                };
    [attributeString setAttributes:attribute range:NSMakeRange(0, attributeString.length)];
    
    NSDictionary *uniteAttrite = @{
                                   (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor redColor].CGColor,
                                   (__bridge id)kCTUnderlineStyleAttributeName : @(kCTUnderlineStyleDouble),
                                   (__bridge id)kCTFontAttributeName : (__bridge id)fontRed,
                                   };
    [attributeString setAttributes:uniteAttrite range:NSMakeRange(6, 5)];
    
    //显示文本
    _textLayer.string = attributeString;
}

#pragma mark - Setter && Getter
- (UIView *)labelView{
    if (!_labelView) {
        _labelView = [[UIView alloc]init];
    }
    return _labelView;
}

- (CATextLayer *)textLayer{
    if (!_textLayer) {
        _textLayer = [CATextLayer layer];
    }
    return _textLayer;
}

@end

