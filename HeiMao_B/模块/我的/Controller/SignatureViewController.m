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

#define knumberTitle  288;
@interface SignatureViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *signatureTextField;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation SignatureViewController

- (UITextView *)signatureTextField {
    if (_signatureTextField == nil) {
        _signatureTextField = [[UITextView alloc] initWithFrame:CGRectMake(0, 10, kSystemWide, 100)];
        _signatureTextField.delegate = self;
        _signatureTextField.backgroundColor = [UIColor whiteColor];
        if ([UserInfoModel defaultUserInfo].introduction) {
            _signatureTextField.text = [UserInfoModel defaultUserInfo].introduction;
        }
    }
    return _signatureTextField;
}
- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 16 - 100 , self.signatureTextField.height - 16, 100, 12)];
        _messageLabel.textAlignment = NSTextAlignmentRight;
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = RGB_Color(74, 118, 250);
        NSInteger resulNumber = [[UserInfoModel defaultUserInfo].introduction length];
        _messageLabel.text = [NSString stringWithFormat:@"%lu\\288",resulNumber];
    }
    return _messageLabel;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"保存" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
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
    self.title = @"个人说明";
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;

    [self.signatureTextField addSubview:self.messageLabel];
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
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"introduction":self.signatureTextField.text,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
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
- (void)textViewDidChange:(UITextView *)textView{
    if([_signatureTextField.text length] > 288)
    {
        _signatureTextField.text = [_signatureTextField.text substringToIndex:288];
        return;
    }
    self.messageLabel.text = [NSString stringWithFormat:@"%lu\\288字",[_signatureTextField.text length]];

}

@end
