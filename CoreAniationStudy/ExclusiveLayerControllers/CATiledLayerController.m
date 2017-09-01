//
//  CATiledLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CATiledLayerController.h"

@interface CATiledLayerController ()
@property (nonatomic,strong) UIScrollView *scrollerView;
@property (nonatomic,strong) CATiledLayer *tiledLayer;
@end

@implementation CATiledLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)addSubviews{
    [self.view addSubview:self.scrollerView];
   
    //创建平铺layer
    _tiledLayer = [CATiledLayer layer];
    _tiledLayer.frame = CGRectMake(0, 0, 5120, 3200);
    _tiledLayer.tileSize = CGSizeMake(640, 640);
    [self.scrollerView.layer addSublayer:_tiledLayer];
    self.scrollerView.contentSize = _tiledLayer.frame.size;
    
    //绘制layer
    _tiledLayer.delegate = self;
    [_tiledLayer setNeedsDisplay];
}

- (void)dealloc{
    _tiledLayer.delegate = nil;
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    //确定tile坐标
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    int y = bounds.origin.x / layer.tileSize.width;
    int x = bounds.origin.y / layer.tileSize.height;
    //NSLog(@"%@--%d--%d",NSStringFromCGRect(bounds),x,y);
    
    //加载图片
    NSString *imageName = [NSString stringWithFormat:@"output_%d_%d.jpg",x,y];
    UIImage *image = [UIImage imageNamed:imageName];
    
    //绘制瓷砖
    UIGraphicsPushContext(ctx);
    [image drawInRect:bounds];
    UIGraphicsPopContext();
}

#pragma mark - Setter && Getter
- (UIScrollView *)scrollerView{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, KScreenWidth, KscreenHeight - 64)];
        _scrollerView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollerView;
}

@end

