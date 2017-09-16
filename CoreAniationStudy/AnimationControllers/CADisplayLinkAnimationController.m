//
//  CADisplayLinkAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/9/4.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CADisplayLinkAnimationController.h"

@interface CADisplayLinkAnimationController ()
@property (nonatomic,strong) UIView *ballView;
@property (nonatomic,strong) CADisplayLink *timer;
@property (nonatomic,assign) CFTimeInterval duration;
@property (nonatomic,assign) CFTimeInterval timeOffset;
@property (nonatomic,assign) CFTimeInterval lastStep;
@property (nonatomic,strong) id fromValue;
@property (nonatomic,strong) id toValue;
@end

@implementation CADisplayLinkAnimationController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ballView];
    self.ballView.frame = CGRectMake(KScreenWidth/2-35/2.0, 80-35/2.0, 35, 35);
    self.ballView.center = CGPointMake(KScreenWidth/2, 80);
    [self configMenthod];
}

- (void)configMenthod{
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(KScreenWidth/2, 80)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(KScreenWidth/2, 350)];
    
    //停止计时器
    [self.timer invalidate];
    
    /*我们可以在每帧开始刷新的时候用CACurrentMediaTime()记录当前时间，然后和上一帧记录的时间去比较。
    通过比较这些时间，我们就可以得到真实的每帧持续的时间，然后代替硬编码的六十分之一秒。*/
    self.lastStep = CACurrentMediaTime();
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(stepMenthod:)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark - Event Response
- (void)stepMenthod:(CADisplayLink *)timer{
    //计算时间间隔
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDurtion = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    //更新时间偏移量
    self.timeOffset = MIN(self.timeOffset + stepDurtion, self.duration);
    float time = self.timeOffset/self.duration;
    time = BounceEaseOutMenthod(time);
    
    //更新位置
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue
                                        time:time];
    self.ballView.center = [position CGPointValue];
    
    //时间结束的时候停止动画
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - Private Menthod
- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        CGPoint from = [fromValue CGPointValue];
        CGPoint to = [toValue CGPointValue];
        CGPoint currentPoint = CGPointMake(interpolateMenthod(from.x, to.x, time), interpolateMenthod(from.y, to.y, time));
        return [NSValue valueWithCGPoint:currentPoint];
    }
    return nil;
}

float interpolateMenthod(float from, float to, float time){
    return (to - from) * time + from;
}

/*
 更多缓冲函数请移步这个连接
 http://www.robertpenner.com/easing
 */
float BounceEaseOutMenthod(CGFloat p){
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

#pragma mark - Setter && Getter
- (UIView *)ballView{
    if (!_ballView) {
        _ballView = [[UIView alloc]init];
        UIImage *image = [UIImage imageNamed:@"足球-2"];
        _ballView.layer.contents = (__bridge id)image.CGImage;
    }
    return _ballView;
}

@end


