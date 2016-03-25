//
//  YBStudentHomeController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentHomeController.h"

@interface YBStudentHomeController ()

@end

@implementation YBStudentHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self resetNavBar];
    self.myNavigationItem.title = @"学员";

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
