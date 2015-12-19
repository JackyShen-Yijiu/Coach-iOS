//
//  SignatureViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/6.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "SignatureViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "ToolHeader.h"
//static NSString *const kupdateUserInfo = @"userinfo/updatecoachinfo";
@interface SignatureViewController ()
@property (strong, nonatomic) UITextField *signatureTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@end

@implementation SignatureViewController
- (UITextField *)signatureTextField {
    if (_signatureTextField == nil) {
        _signatureTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _signatureTextField.backgroundColor = [UIColor whiteColor];
        if ([UserInfoModel defaultUserInfo].introduction) {
            _signatureTextField.text = [UserInfoModel defaultUserInfo].introduction;
        }
    }
    return _signatureTextField;
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
    self.title = @"自我介绍";
    self.view.backgroundColor = RGBColor(245, 247, 250);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;

    
    [self.view addSubview:self.signatureTextField];
    
    [self.signatureTextField becomeFirstResponder];
}

- (void)clickLeft:(UIButton *)sender {
    if (self.signatureTextField.text == nil || self.signatureTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickRight:(UIButton *)sender {
    DYNSLog(@"上传");
    //
    DYNSLog(@"userid = %@",self.signatureTextField.text)
    ;
    NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"introduction":self.signatureTextField.text,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
       
        
        if (!data) {
            [self showTotasViewWithMes:@"网络连接错误，请稍后重测"];
            return ;
        }

        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [UserInfoModel defaultUserInfo].introduction = self.signatureTextField.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kSignatureChange object:nil];
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
