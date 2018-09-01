//
//  DrawController.m
//  CoreAniationStudy
//
//  Created by 曹学亮 on 2018/8/2.
//  Copyright © 2018年 ovov.cn. All rights reserved.
//

#import "DrawController.h"
#import "DrawView.h"

@interface DrawController ()
@property (nonatomic,strong) DrawView *drawView;
@end

@implementation DrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DrawView *)drawView{
    if (!_drawView) {
        _drawView = [[DrawView alloc]initWithFrame:self.view.bounds];
    }
    return _drawView;
}

@end
