//
//  modifyjialinViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "modifyjialinViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "ToolHeader.h"

@interface modifyjialinViewController ()
@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;
@end

@implementation modifyjialinViewController


- (UITextField *)modifyNameTextField {
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _modifyNameTextField.backgroundColor = [UIColor whiteColor];
        _modifyNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        if ([UserInfoModel defaultUserInfo].name) {
            _modifyNameTextField.text = [NSString stringWithFormat:@"%lu",[UserInfoModel defaultUserInfo].Seniority];
        }
    }
    return _modifyNameTextField;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (UIButton *)naviBarLeftButton {
    if (_naviBarLeftButton == nil) {
        _naviBarLeftButton = [WMUITool initWithTitle:@"取消" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarLeftButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarLeftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarLeftButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"教龄";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.view addSubview:self.modifyNameTextField];
    
    [self.modifyNameTextField becomeFirstResponder];
}
- (void)clickLeft:(UIButton *)sender {
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRight:(UIButton *)sender {
    
    if ([self.modifyNameTextField.text integerValue]>30) {
        [self showTotasViewWithMes:@"教龄不能大于30"];
        return;
    }
    
    //
    DYNSLog(@"userid = %@",self.modifyNameTextField.text);
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"Seniority":self.modifyNameTextField.text,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        if (!data) {
            [self showTotasViewWithMes:@"网络连接错误，请稍后再试"];
            return ;
        }
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [UserInfoModel defaultUserInfo].Seniority = [self.modifyNameTextField.text integerValue];
            [[NSNotificationCenter defaultCenter] postNotificationName:modifyjialinKey object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            if(msg){
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
                [alerview show];
            }
        }
        
    }];
}

@end
