//
//  CALayerController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/8/30.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "CALayerController.h"
#import "NormalCell.h"
#import "SwitchCell.h"
#import "OneSliderCell.h"

@interface CALayerController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) CALayer *centerView;
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,copy)   NSString *contentGravity;
@property (nonatomic,assign) CGFloat opacityValue,cornerRadius,borderWidth,shadowOpacity,shadowRadius;
@end

@implementation CALayerController
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubViews];
}

- (void)addSubViews{
    [self.view.layer addSublayer:self.centerView];
    self.centerView.bounds = CGRectMake(0, 0, 200, 200);
    self.centerView.position = CGPointMake(KScreenWidth/2, 200);
    
    [self.view addSubview:self.myTable];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalCell" forIndexPath:indexPath];
        [cell setTitle:@"contents Gravity" value:self.contentGravity];
        return cell;
    }else{
        OneSliderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OneSliderCell" forIndexPath:indexPath];
        __weak typeof(self)weakSelf = self;
        if (indexPath.row == 1) {
            [cell setTitle:@"Opacity" value:_opacityValue];
            cell.sliderChanged = ^(NSString *type, CGFloat value) {
              _opacityValue = value;
              weakSelf.centerView.opacity = value;
            };
        }else if (indexPath.row == 2){
            [cell setTitle:@"Corner radius" value:_cornerRadius];
            cell.sliderChanged = ^(NSString *type, CGFloat value) {
                _cornerRadius = value;
                weakSelf.centerView.cornerRadius = value;
            };
        }else if (indexPath.row == 3){
            [cell setTitle:@"Border Width" value:_borderWidth];
            cell.sliderChanged = ^(NSString *type, CGFloat value) {
                _borderWidth = value;
                weakSelf.centerView.borderWidth = value;
            };
        }else if (indexPath.row == 4){
            [cell setTitle:@"Shadow opacity" value:_shadowOpacity];
            cell.sliderChanged = ^(NSString *type, CGFloat value) {
                _shadowOpacity = value;
                weakSelf.centerView.shadowOpacity = value;
            };
        }else if (indexPath.row == 5){
            [cell setTitle:@"Shadow radius" value:_shadowRadius];
            cell.sliderChanged = ^(NSString *type, CGFloat value) {
                _shadowRadius = value;
                weakSelf.centerView.shadowRadius = value;
            };
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"contents Gravity" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        NSArray *array = @[kCAGravityCenter,kCAGravityTop,kCAGravityBottom,kCAGravityLeft,kCAGravityRight,kCAGravityTopLeft,kCAGravityTopRight,kCAGravityBottomLeft,kCAGravityBottomRight,kCAGravityResize,kCAGravityResizeAspect,kCAGravityResizeAspectFill,];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSString *str = obj;
         UIAlertAction *action = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             NSLog(@"%@",str);
               _contentGravity = str;
               [self.myTable reloadData];
               self.centerView.contentsGravity = _contentGravity;
           }];
            [controller addAction:action];
        }];
        [self presentViewController:controller animated:YES completion:NULL];
    }
}

#pragma mark - Setter && Getter
- (CALayer *)centerView{
    if (!_centerView) {
        _centerView = [[CALayer alloc]init];
        _centerView.backgroundColor = [UIColor colorWithRed:11/255.0 green:86/255.0 blue:14/255.0 alpha:1].CGColor;
        
        //设置边框
        _centerView.borderWidth = 12;
        _centerView.borderColor = [UIColor whiteColor].CGColor;
        _borderWidth = 12;
        
        //设置阴影
        _centerView.shadowOpacity = 0.7;
        _centerView.shadowRadius = 3.0;
        _centerView.shadowOffset = CGSizeMake(0, 3);
        _shadowOpacity = 0.7;
        _shadowRadius = 3.0;
        
        //设置寄宿图
        UIImage *image = [UIImage imageNamed:@"star"];
        _centerView.contents = (__bridge id)image.CGImage;
        _centerView.contentsGravity = kCAGravityCenter;
        _centerView.geometryFlipped = NO;
        //_centerView.contentsScale = [UIScreen mainScreen].scale;
        _contentGravity = kCAGravityCenter;
    }
    return _centerView;
}

- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 315, KScreenWidth,KscreenHeight-315)];
        _myTable.backgroundColor = [UIColor whiteColor];
        _myTable.delegate = self;
        _myTable.dataSource = self;
        _myTable.separatorColor = [UIColor colorWithRed:(220 / 255.0)green:(220 / 255.0) blue:(220 / 255.0) alpha:1];
        [_myTable registerClass:[NormalCell class] forCellReuseIdentifier:@"NormalCell"];
        [_myTable registerClass:[OneSliderCell class] forCellReuseIdentifier:@"OneSliderCell"];
        _myTable.tableFooterView = [UIView new];
    }
    return _myTable;
}

@end

