//
//  YBStudentDetailsViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentDetailsViewController.h"
#import "YBStudentDetailsRootClass.h"
#import "YYModel.h"
#import "YBStudentDetailsData.h"
#import "YBStudentDetailsCoachcommentinfo.h"
#import "YBStudentDetailsStudentinfo.h"
#import "YBStudentDetailHeadView.h"

@interface YBStudentDetailsViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YBStudentDetailHeadView *headerView;

@end

@implementation YBStudentDetailsViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.frame = CGRectMake(0, self.view.width - 64, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (YBStudentDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [YBStudentDetailHeadView new];
        _headerView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [YBStudentDetailHeadView defaultHeight]);
        _headerView.studentID = _studentID;
        _headerView.alpha = 0;
    }
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self naviTransparent];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 
    [self naviCancelTransparent];

}

#pragma mark 使导航栏透明
- (void)naviTransparent {
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:[UIColor clearColor]];
    // 背景图片
    [bar setBackgroundImage:[UIImage imageNamed:@"YBStudentDetailstudent_shadow"] forBarMetrics:UIBarMetricsDefault];
    // 打开透明效果
//    [bar setTranslucent:YES];
}

#pragma mark 取消导航栏透明
- (void)naviCancelTransparent {
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    // 背景色
    [bar setBackgroundColor:JZ_BlueColor];
    // 背景图片
    [bar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    // 去掉透明效果
//    [bar setTranslucent:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"杨建刚";

    [self loadData];
    
    [self setUpUI];
    
}

- (void)setUpUI
{
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];

}

- (void)loadData
{
    
    [NetWorkEntiry getStudentDetailswithuserid:@"564229d81eb4017436ade69e" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YBStudentDetailsRootClass *rootClass = [YBStudentDetailsRootClass yy_modelWithJSON:responseObject];
        
        NSLog(@"rootClass.data.studentinfo.name:%@",rootClass.data.studentinfo.name);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat centerY = [UIScreen mainScreen].bounds.size.width*0.4;
    CGFloat centerX = [UIScreen mainScreen].bounds.size.width - 16 - 63/2.f;
    CGFloat height = centerY;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"_tableView.frame.origin.y: %f",  _tableView.frame.origin.y);
    if (offsetY > 0) {
        NSLog(@"offsetY大于0");
        
        if (_tableView.frame.origin.y > 0) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY < 0) {
                _headerView.frame = CGRectMake(0, - height, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _headerView.frame = CGRectMake(0, _headerView.frame.origin.y - offsetY, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    if (offsetY < 0 ) {
        NSLog(@"offsetY小于0");
        if (_tableView.frame.origin.y < height - 64) {
            
            CGFloat originY = _tableView.frame.origin.y - offsetY;
            if (originY > height - 64) {
                _headerView.frame = CGRectMake(0, -64, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, height - 64, _tableView.frame.size.width, _tableView.frame.size.height);
            }else {
                _headerView.frame = CGRectMake(0, _headerView.frame.origin.y - offsetY, _headerView.frame.size.width, _headerView.frame.size.height);
                _tableView.frame = CGRectMake(0, _tableView.frame.origin.y - offsetY, _tableView.frame.size.width, _tableView.frame.size.height);
                _tableView.contentOffset = CGPointMake(0, 0);
            }
        }
    }
    
    if (_tableView.frame.origin.y < 64) {
        
        [UIView animateWithDuration:0.3 animations:^{
//            _headerView.collectionImageView.size = CGSizeMake(0, 0);
//            _headerView.collectionImageView.center = CGPointMake(centerX, centerY);
//            _headerView.collectionImageView.alpha = 0;
            
//            _headerView.alphaView.backgroundColor = YBNavigationBarBgColor;
        }];
    }else {
        
        [UIView animateWithDuration:0.3 animations:^{
//            _headerView.collectionImageView.size = CGSizeMake(63, 63);
//            _headerView.collectionImageView.center = CGPointMake(centerX, centerY);
//            _headerView.collectionImageView.alpha = 1;
            
            _headerView.alphaView.backgroundColor = [UIColor clearColor];
        }];
    }
    
    // 取消tableView底部的弹簧效果的方法
    CGFloat maxOffsetY = _tableView.contentSize.height - _tableView.bounds.size.height;
    if (offsetY > maxOffsetY) {
        _tableView.contentOffset = CGPointMake(0, maxOffsetY);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
