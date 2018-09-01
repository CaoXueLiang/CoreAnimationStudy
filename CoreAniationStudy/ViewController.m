//
//  ViewController.m
//  CoreAniationStudy
//
//  Created by bjovov on 2017/7/14.
//  Copyright © 2017年 ovov.cn. All rights reserved.
//

#import "ViewController.h"
#import "MyNormalCell.h"
#import "MLImageNormalCell.h"
#import "ViewAnimationsController.h"
#import "KeyFrameAnimationController.h"
#import "GroupAnimationController.h"
#import "TransformAnimationController.h"
#import "MLImageNormalModel.h"
#import "CustomTransformController.h"
#import "BufferAnimationController.h"
#import "CADisplayLinkAnimationController.h"
#import "PhysicalModelAnimationController.h"
#import "DrawController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTable;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSMutableArray *exclusiveLayerArray;
@property (nonatomic,strong) NSArray *calyerClassArray;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTable];
    self.navigationItem.title = @"首页";
}

#pragma mark - UITableView M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.exclusiveLayerArray.count;
    }else if(section == 1){
        return self.dataArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MLImageNormalModel *model = self.exclusiveLayerArray[indexPath.row];
        MLImageNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MLImageNormalCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
        
    }else if(indexPath.section == 1){
        NSString *currentString = self.dataArray[indexPath.row];
        MyNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNormalCell" forIndexPath:indexPath];
        [cell setTitle:currentString];
        return cell;
    }else{
        MyNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNormalCell" forIndexPath:indexPath];
        [cell setTitle:@"绘制"];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFLOAT_MIN)];
    footView.backgroundColor = [UIColor clearColor];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
      return [MLImageNormalCell cellHeight];
    }else{
      return [MyNormalCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        NSString *className = self.calyerClassArray[indexPath.row];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *controller = class.new;
            controller.navigationItem.title = className;
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0){
            ViewAnimationsController *controller = [[ViewAnimationsController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 1){
            KeyFrameAnimationController *controller = [[KeyFrameAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 2){
            GroupAnimationController *controller = [[GroupAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 3){
            TransformAnimationController *controller = [[TransformAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 4){
            CustomTransformController *controller = [[CustomTransformController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 5){
            BufferAnimationController *controller = [[BufferAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 6){
            CADisplayLinkAnimationController *controller = [[CADisplayLinkAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }else if (indexPath.row == 7){
            PhysicalModelAnimationController *controller = [[PhysicalModelAnimationController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            DrawController *controller = [[DrawController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}

#pragma mark - Setter && Getter
- (UITableView *)myTable{
    if (!_myTable) {
        _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        _myTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myTable.tableFooterView = [UIView new];
        _myTable.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, CGFLOAT_MIN)];
        [_myTable registerClass:[MyNormalCell class] forCellReuseIdentifier:@"MyNormalCell"];
        [_myTable registerClass:[MLImageNormalCell class] forCellReuseIdentifier:@"MLImageNormalCell"];
        _myTable.delegate = self;
        _myTable.dataSource = self;
    }
    return _myTable;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"CoreAniamtion基础动画",@"CoreAniamtion关键帧动画",@"CoreAniamtion动画组",@"转场动画",@"自定义转场动画",@"自定义缓冲函数动画",@"基于定时器的动画",@"物理模拟动画"];
    }
    return _dataArray;
}

- (NSMutableArray *)exclusiveLayerArray{
    if (!_exclusiveLayerArray) {
        _exclusiveLayerArray = [[NSMutableArray alloc]init];
        NSArray *tmpArray = @[
                                 @{@"imageName":@"CALayer",
                                   @"titleName":@"CALayer",
                                   @"titleDetail":@"Manage and animate visual content",
                                   },
                                 @{@"imageName":@"CAScrollLayer",
                                   @"titleName":@"CAScrollLayer",
                                   @"titleDetail":@"Display portion of a scrollable layer",
                                   },
                                 @{@"imageName":@"CATextLayer",
                                   @"titleName":@"CATextLayer",
                                   @"titleDetail":@"Render plain text or attributed strings",
                                   },
                                 @{@"imageName":@"AVPlayerLayer",
                                   @"titleName":@"AVPlayerLayer",
                                   @"titleDetail":@"Display an AV player",
                                   },
                                 @{@"imageName":@"CAGradientLayer",
                                   @"titleName":@"CAGradientLayer",
                                   @"titleDetail":@"Apply a color gradient over the background",
                                   },
                                 @{@"imageName":@"CAReplicatorLayer",
                                   @"titleName":@"CAReplicatorLayer",
                                   @"titleDetail":@"Duplicate a source layer",
                                   },
                                 @{@"imageName":@"CATiledLayer",
                                   @"titleName":@"CATiledLayer",
                                   @"titleDetail":@"Asynchronously draw layer content in tiles",
                                   },
                                 @{@"imageName":@"CAShapeLayer",
                                   @"titleName":@"CAShapeLayer",
                                   @"titleDetail":@"Draw using scalable vector paths",
                                   },
                                 @{@"imageName":@"CAEAGLLayer",
                                   @"titleName":@"CAEAGLLayer",
                                   @"titleDetail":@"Draw OpenGL content",
                                   },
                                 @{@"imageName":@"CATransformLayer",
                                   @"titleName":@"CATransformLayer",
                                   @"titleDetail":@"Draw 3D structures",
                                   },
                                 @{@"imageName":@"CAEmitterLayer",
                                   @"titleName":@"CAEmitterLayer",
                                   @"titleDetail":@"Render animated particles",
                                   },
                                 
                                 ];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            MLImageNormalModel *model = [MLImageNormalModel initWithDictionary:dict];
            [_exclusiveLayerArray addObject:model];
        }];
    }
    return _exclusiveLayerArray;
}

- (NSArray *)calyerClassArray{
    if (!_calyerClassArray) {
        _calyerClassArray = @[@"CALayerController",@"CAScrollLayerController",@"CATextLayerController",@"AVPlayerLayerController",@"CAGradientLayerController",@"CAReplicatorLayerController",@"CATiledLayerController",@"CAShapeLayerController",@"CAEAGLLayerController",@"CATransformLayerController",@"CAEmitterLayerController",];
    }
    return _calyerClassArray;
}

@end

