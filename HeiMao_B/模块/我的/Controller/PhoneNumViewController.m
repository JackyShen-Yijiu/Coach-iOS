//
//  PhoneNumViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PhoneNumViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "ToolHeader.h"
//static NSString *const kupdateUserInfo = @"userinfo/updatecoachinfo";


#define margin 10
@interface PhoneNumViewController ()

@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@property (nonatomic, strong) UIView *bgView;
@property (strong, nonatomic) UITextField *modifyNameTextField;
@property (nonatomic, strong) UIView *lineView;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;



@end

@implementation PhoneNumViewController

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kSystemWide, 89)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UITextField *)modifyNameTextField {
    if (_modifyNameTextField == nil) {
        _modifyNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(margin, 0, kSystemWide - margin, 44)];
        _modifyNameTextField.backgroundColor = [UIColor clearColor];
        _modifyNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        _modifyNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        if ([UserInfoModel defaultUserInfo].name) {
            _modifyNameTextField.text = [UserInfoModel defaultUserInfo].tel;
        }
    }
    return _modifyNameTextField;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(margin,CGRectGetMaxY(self.modifyNameTextField.frame), kSystemWide - margin, 0.5)];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[UITextField alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(self.lineView.frame), kSystemWide - margin, 49)];
        _confirmTextField.tag = 103;
        _confirmTextField.placeholder = @"请输入验证码";
        _confirmTextField.font = [UIFont systemFontOfSize:14];
//        _confirmTextField.textColor = JZ_FONTCOLOR_DRAK;
        _confirmTextField.keyboardType = UIKeyboardTypeNumberPad;
        _confirmTextField.backgroundColor = [UIColor clearColor];

       
    }
    return _confirmTextField;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.frame = CGRectMake(kSystemWide - 100 - 16, 5, 100, 34);
        _gainNum.backgroundColor = JZ_BlueColor;
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
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
    self.title = @"手机号";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    [self.bgView addSubview:self.modifyNameTextField];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.confirmTextField];
    [self.confirmTextField addSubview:self.gainNum];
    [self.view addSubview:self.bgView];
    
    [self.modifyNameTextField becomeFirstResponder];
}
- (void)clickLeft:(UIButton *)sender {
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)isValidateMobile:(NSString *)mobile
{
    //    NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSString *regex = @"^(1[0-9])\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}
- (void)clickRight:(UIButton *)sender {
    //
    BOOL isRight = [self isValidateMobile:_modifyNameTextField.text];
    if (!isRight) {
        [self showTotasViewWithMes:@"请输入正确的手机号码"];
        return;
    }
    if (_confirmTextField.text == nil || [_confirmTextField.text isEqualToString:@""]) {
        [self showTotasViewWithMes:@"请输入验证码"];
        return;
    }
    [NetWorkEntiry coachChangePhoneNumber:_modifyNameTextField.text smscode:_confirmTextField.text userType:2 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dataParam = responseObject;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [UserInfoModel defaultUserInfo].tel = self.modifyNameTextField.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kPhoneNumChange object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"网络错误" controller:self];
        [alerview show];
    }];
    
    
    
    
}
#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.modifyNameTextField.text == nil || self.modifyNameTextField.text.length <= 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号为空" controller:self];
        [alerview show];
        return;
    }
    BOOL isRight = [self isValidateMobile:_modifyNameTextField.text];
    if (!isRight) {
        [self showTotasViewWithMes:@"请输入正确的手机号码"];
        return;
    }
else {
        WS(ws);
        [NetWorkEntiry postSmsCodeWithPhotNUmber:self.modifyNameTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *param = responseObject;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            
            if (type.integerValue != 1) {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
                [alerview show];
            }else{
                [ws.modifyNameTextField resignFirstResponder];
                [ws.confirmTextField becomeFirstResponder];
                [self showTotasViewWithMes:@"发送成功"];
                [self sendCode:sender];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    }
- (void)sendCode:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    __block int count = TIME;
    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (count < 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
                self.gainNum.backgroundColor  = JZ_BlueColor;
                [self.gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.gainNum.userInteractionEnabled = YES;
                
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gainNum.backgroundColor = RGB_Color(204, 204, 204);
                [self.gainNum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                [self.gainNum setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);

}
@end
