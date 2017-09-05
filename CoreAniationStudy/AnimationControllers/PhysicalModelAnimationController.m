//
//  PhysicalModelAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/9/5.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "PhysicalModelAnimationController.h"
#import "ObjectiveChipmunk.h"
#import "FallingButton.h"
#import <CoreMotion/CoreMotion.h>

@interface PhysicalModelAnimationController ()<UIAccelerometerDelegate>
@property (nonatomic,strong) CADisplayLink *timer;
@property (nonatomic,strong) ChipmunkSpace *space;
@property (nonatomic,strong) FallingButton *button;
@property (nonatomic,assign) CFTimeInterval lastStep;
@end

static NSString *borderType = @"borderType";
@implementation PhysicalModelAnimationController
#pragma mark - Life Cycle
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物理模拟";
    [self setUp];
    [self setUpTimer];
}

- (void)setUpTimer{
    [_timer invalidate];
    self.lastStep = CACurrentMediaTime();
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(Update:)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [UIAccelerometer sharedAccelerometer].delegate = self;
    [UIAccelerometer sharedAccelerometer].updateInterval = 1/60.0;
}

- (void)setUp{
    /*创建空间*/
    _space = [[ChipmunkSpace alloc]init];
    
    //创建碰撞边界
    CGRect bounds = self.view.bounds;
    [_space addBounds:cpBBNew(bounds.origin.x, bounds.origin.y, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds)) thickness:10.0 elasticity:1.0 friction:1.0 filter:CP_SHAPE_FILTER_ALL collisionType:borderType];
    
    //创建碰撞回调
    [_space addCollisionHandler:self typeA:[FallingButton class] typeB:borderType begin:@selector(beginCollision:space:) preSolve:nil postSolve:@selector(postSolveCollision:space:) separate:@selector(separateCollision:space:)];
    
    //创建对象
    _button = [[FallingButton alloc]init];
    [self.view addSubview:_button.button];
    
    //将物理对象添加到空间
    // No matter how many physics objects (collision shapes, joints, etc) the fallingButton has, it can be added in a single line!
    [_space add:_button];
}

#pragma mark - Event Response
- (bool)beginCollision:(cpArbiter*)arbiter space:(ChipmunkSpace*)space{
    CHIPMUNK_ARBITER_GET_SHAPES(arbiter, buttonShape, border);
    
    NSLog(@"First object in the collision is --%@-- second object is ---%@---.", buttonShape.userData, border.userData);
    FallingButton *fb = buttonShape.userData;
    fb.touchedShapes++;
    self.view.backgroundColor = [UIColor grayColor];
    return YES;
}

- (void)postSolveCollision:(cpArbiter*)arbiter space:(ChipmunkSpace*)space{
    if(!cpArbiterIsFirstContact(arbiter)) return;
    cpFloat impulse = cpvlength(cpArbiterTotalImpulse(arbiter));
    
    float volume = MIN(impulse/500.0f, 1.0f);
    if(volume > 0.05f){
        //[SimpleSound playSoundWithVolume:volume];
    }
}

- (void)separateCollision:(cpArbiter*)arbiter space:(ChipmunkSpace*)space{
    CHIPMUNK_ARBITER_GET_SHAPES(arbiter, buttonShape, border);
    
    // Decrement the counter on the FallingButton.
    FallingButton *fb = buttonShape.userData;
    fb.touchedShapes--;
    
    // If touchedShapes is 0, then we know the falling button isn't touching anything anymore.
    if(fb.touchedShapes == 0){
        self.view.backgroundColor = [UIColor yellowColor];
    }
}

- (void)Update:(CADisplayLink *)link{
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval step = thisStep - _lastStep;
    _lastStep = thisStep;
    [self.space step:step];
    [self.button updatePosition];
}

#pragma mark - UIAccelerometerDelegate
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
   self.space.gravity = cpvmult(cpv(acceleration.x, -acceleration.y), 100.0f);
}

@end

