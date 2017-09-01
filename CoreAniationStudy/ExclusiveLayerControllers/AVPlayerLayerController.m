//
//  AVPlayerLayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "AVPlayerLayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>

@interface AVPlayerLayerController ()
@property (nonatomic,strong) AVPlayerLayer *playerLayer;
@property (nonatomic,strong) UIView *containerView;
@end

@implementation AVPlayerLayerController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
    [self playVideo];
}

- (void)addSubViews{
    [self.view addSubview:self.containerView];
    self.containerView.frame = CGRectMake(10, 100, KScreenWidth-20, (KScreenWidth-20)*3/4.0);
}

/*我们用代码创建了一个AVPlayerLayer，但是我们仍然把它添加到了一个容器视图中，而不是直接在controller中的主视图上添加。
 这样其实是为了可以使用自动布局限制使得图层在最中间；
 否则，一旦设备被旋转了我们就要手动重新放置位置，
 因为Core Animation并不支持自动大小和自动布局*/

- (void)playVideo{
    //获取视频路径
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"colorfulStreak" withExtension:@"m4v"];
    
    //创建playerLayer
    AVPlayer *play = [AVPlayer playerWithURL:url];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:play];
    _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    //设置frame并且添加到图层
    [self.containerView.layer addSublayer:_playerLayer];
    _playerLayer.frame = self.containerView.bounds;
    
    //transform
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/500.0;
    transform = CATransform3DRotate(transform, M_PI_4, 1, 1, 0);
    _playerLayer.transform = transform;
    
    //设置边框圆角
    _playerLayer.borderColor = [UIColor blueColor].CGColor;
    _playerLayer.borderWidth = 2;
    _playerLayer.cornerRadius = 5;
    _playerLayer.masksToBounds = YES;
    
    //播放视频
    [play play];
}

#pragma mark - Setter && Getter
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = [UIColor orangeColor];
    }
    return _containerView;
}

@end

