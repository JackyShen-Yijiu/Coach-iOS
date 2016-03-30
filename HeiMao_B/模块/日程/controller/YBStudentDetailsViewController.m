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

@interface YBStudentDetailsViewController ()

@end

@implementation YBStudentDetailsViewController

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
    
    
}

- (void)loadData
{
    
    [NetWorkEntiry getStudentDetailswithuserid:@"564229d81eb4017436ade69e" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YBStudentDetailsRootClass *rootClass = [YBStudentDetailsRootClass yy_modelWithJSON:responseObject];
        
        NSLog(@"rootClass.data.studentinfo.name:%@",rootClass.data.studentinfo.name);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
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
