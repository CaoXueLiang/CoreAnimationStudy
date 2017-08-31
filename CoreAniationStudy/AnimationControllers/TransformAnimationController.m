//
//  TransformAnimationController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/25.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "TransformAnimationController.h"

#define  IMAGE_CCOUNT 5
@interface TransformAnimationController ()
@property (nonatomic,strong) UIImageView *tmpImageView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSArray *typeArray;
@property (nonatomic,strong) NSString *animationType;
@property (nonatomic,strong) UILabel *typeLabel;
@end

@implementation TransformAnimationController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tmpImageView.frame = CGRectMake(20, 100, KScreenWidth-40, KscreenHeight-200);
    [self.view addSubview:self.tmpImageView];
    [self.view addSubview:self.typeLabel];
    [self setNavigation];
    self.animationType = @"cube";
    self.typeLabel.text = self.animationType;
    
    //添加左滑和右滑手势
    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftGestureMenthod:)];
    leftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftGesture];
    
    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightGestureMenthod:)];
    rightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightGesture];
}

- (void)setNavigation{
   self.navigationItem.title = @"转场动画";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"动画类型" style:UIBarButtonItemStylePlain target:self action:@selector(switchType)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

#pragma mark - Event response
-(void)leftGestureMenthod:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

-(void)rightGestureMenthod:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

- (void)switchType{
    UIAlertController *controller =  [UIAlertController alertControllerWithTitle:@"动画类型选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self.typeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = obj;
        UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.animationType = str;
            self.typeLabel.text = str;
        }];
        [controller addAction:action];
    }];
    [self presentViewController:controller animated:YES completion:NULL];
}

#pragma mark - Animation
- (void)transitionAnimation:(BOOL)isNext{
   /*1.创建转场动画
     2.设置转场类型、子类型（可选）及其他属性
     3.设置转场后的新视图并添加动画到图层*/
    CATransition *transition = [[CATransition alloc]init];
    transition.type = self.animationType;
    if (isNext) {
        transition.subtype = kCATransitionFromRight;
    }else{
        transition.subtype = kCATransitionFromLeft;
    }
    transition.duration = 1.0f;
    self.tmpImageView.image = [self getImage:isNext];
    [self.tmpImageView.layer addAnimation:transition forKey:@"TransitionAnimation"];
}

- (UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        self.currentIndex = (self.currentIndex + 1)%IMAGE_CCOUNT;
    }else{
        self.currentIndex = (self.currentIndex - 1 + IMAGE_CCOUNT)%IMAGE_CCOUNT;
    }
    return [UIImage imageNamed:[NSString stringWithFormat:@"images%ld",self.currentIndex]];
}

#pragma mark - Setter && Getter
- (UIImageView *)tmpImageView{
    if (!_tmpImageView) {
        _tmpImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"images0"]];
        _tmpImageView.contentMode = UIViewContentModeScaleAspectFill;
        _tmpImageView.clipsToBounds = YES;
    }
    return _tmpImageView;
}

- (NSArray *)typeArray{
    if (!_typeArray) {
        _typeArray = @[@"fade",@"movein",@"push",@"reveal",@"cube",@"oglFlip",@"suckEffect",@"rippleEffect",@"pageCurl",@"pageUnCurl",@"cameralIrisHollowOpen",@"cameraIrisHollowClose"];
    }
    return _typeArray;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, KscreenHeight-60, KScreenWidth-40, 20)];
        _typeLabel.textColor = [UIColor blueColor];
        _typeLabel.font = [UIFont systemFontOfSize:22];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}

@end

