//
//  IDCardNumViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "IDCardNumViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "ToolHeader.h"
//static NSString *const kupdateUserInfo = @"userinfo/updatecoachinfo";
@interface IDCardNumViewController ()
@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;
@end

@implementation IDCardNumViewController

- (UITextField *)modifyNameTextField {
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _modifyNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _modifyNameTextField.backgroundColor = [UIColor whiteColor];
        if ([UserInfoModel defaultUserInfo].name) {
            _modifyNameTextField.text = [UserInfoModel defaultUserInfo].idcardnumber;
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
    self.title = @"身份证";
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    self.view.backgroundColor = RGBColor(245, 247, 250);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
    
    [self.view addSubview:self.modifyNameTextField];
    
    [self.modifyNameTextField becomeFirstResponder];
}
- (void)clickLeft:(UIButton *)sender {
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRight:(UIButton *)sender {
    
    if (_modifyNameTextField.text.length>18) {
        [self showTotasViewWithMes:@"超出最大限制"];
        return;
    }
    //
    DYNSLog(@"userid = %@",self.modifyNameTextField.text);
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"idcardnumber":self.modifyNameTextField.text,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    
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
            [UserInfoModel defaultUserInfo].idcardnumber = self.modifyNameTextField.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kIDCardChange object:nil];
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
