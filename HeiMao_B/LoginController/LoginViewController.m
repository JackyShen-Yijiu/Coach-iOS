//
//  LoginViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import "RegisterViewController.h"
#import <Masonry/Masonry.h>
#import "NSString+DY_MD5.h"
#import "NSString+DY_MD5.h"
#import "UIView+Sizes.h"
#import "UserInfoModel.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

static NSString *const kloginUrl = @"userinfo/userlogin";

static NSString *const kregisterUser = @"kregisterUser";


static NSString *const kmobileNum = @"mobile";

static NSString *const kpassword = @"password";

static NSString *const kuserType = @"usertype";

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIButton *forgetButton;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *bottomButton;
@property (strong, nonatomic) UIImageView *rightImageView;
@property (strong, nonatomic) NSMutableDictionary *userParam;

@end

@implementation LoginViewController



- (NSMutableDictionary *)userParam {
    if (_userParam == nil) {
        _userParam = [[NSMutableDictionary alloc] init];
    }
    return _userParam;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"随便看看"];
    }
    return _rightImageView;
}

- (UIButton *)bottomButton {
    if (_bottomButton == nil) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"先随便看看" forState:UIControlStateNormal];
        _bottomButton.layer.borderColor = kDefaultTintColor.CGColor;
        _bottomButton.layer.borderWidth = 1;
        [_bottomButton setTitleColor:kDefaultTintColor forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_bottomButton addTarget:self action:@selector(dealBottom:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }
    return _bottomButton;
    
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _backGroundView.layer.borderWidth = 1;
        _backGroundView.userInteractionEnabled = YES;
    }
    return _backGroundView;
}
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.layer.borderWidth = 1;
        _lineView.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
    }
    return _lineView;
}
- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"登录logo"];
    }
    return _logoImageView;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = [UIColor whiteColor];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_registerButton setTitleColor:kDefaultTintColor  forState:UIControlStateNormal];
        
    }
    return _registerButton;
}

- (UIButton *)forgetButton{
    if (_forgetButton == nil) {
        _forgetButton =[UIButton buttonWithType:UIButtonTypeCustom];
        _forgetButton.backgroundColor = [UIColor whiteColor];
        [_forgetButton addTarget:self action:@selector(dealForget:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_forgetButton setTitleColor:RGB_Color(102, 102, 102) forState:UIControlStateNormal];
    }
    return _forgetButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = kDefaultTintColor;

        [_loginButton addTarget:self action:@selector(dealLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _loginButton;
    
}

- (UITextField *) phoneNumTextField {
    
    if (_phoneNumTextField == nil) {
        
        _phoneNumTextField                    = [[UITextField alloc] init];
        
        _phoneNumTextField.delegate           = self;
        
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = RGB_Color(51, 51, 51);
        
        _phoneNumTextField.tag = 100;
        
        _phoneNumTextField.placeholder        = @" 请填写手机号";
        
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"电话"];
        
        _phoneNumTextField.leftView = leftView;

    }
    
    return _phoneNumTextField;
    
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = @" 请填写密码";
        _passwordTextField.tag = 101;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.textColor = RGB_Color(51, 51, 51);
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, 20, 20)];
        leftView.image = [UIImage imageNamed:@"密码"];
        
        _passwordTextField.leftView = leftView;
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYdealRegister) name:kregisterUser object:nil];
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.backGroundView];
    [self.backGroundView addSubview:self.lineView];
    [self.backGroundView addSubview:self.phoneNumTextField];
    [self.backGroundView addSubview:self.passwordTextField];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.bottomButton];
    [self.bottomButton addSubview:self.rightImageView];
    
}

- (void)DYdealRegister {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - loginAction

- (void)dealLogin:(UIButton *)sender {
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length  == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号为空" controller:self];
        [alerview show];
        return;
    }
    if (self.passwordTextField.text == nil || self.passwordTextField.text.length  == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"密码为空" controller:self];
        [alerview show];
        return;
    }
    //网络请求
    [self.passwordTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetWorkEntiry loginWithPhotoNumber:self.phoneNumTextField.text password:self.passwordTextField.text.DY_MD5 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        NSDictionary *param = responseObject;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"登录成功" controller:self];
            [alerview show];
            [[UserInfoModel defaultUserInfo] loginViewDic:param[@"data"]];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
   

}

#pragma mark - textfieldDelegate 业务逻辑

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
        NSString *phoneNum = textField.text;
        NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNum];
        if (!isMatch) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号不符" controller:self];
            [alerview show];
            return;
        }
        [self.userParam setObject:textField.text forKey:kmobileNum];
    }else if (textField.tag == 101) {
        [self.userParam setObject:[textField.text DY_MD5] forKey:kpassword];
    }
}
- (void)dealBottom:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealForget:(UIButton *)sender{
    ForgetViewController *forgetVc = [[ForgetViewController alloc]init];
    [self presentViewController:forgetVc animated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender{
    RegisterViewController *registerVc = [[RegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:nil];
    
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
#pragma make - 自动布局
    
    
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(50);
        make.height.mas_equalTo(@90);
        make.width.mas_equalTo(@90);
    }];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(42);
        make.height.mas_equalTo(@80);
    }];
    
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(0);
        
        make.height.mas_equalTo(@40);
        
    }];

    
    
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(0);
        
        make.height.mas_equalTo(@40);
        
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_top).with.offset(40.5);
        make.left.mas_equalTo(self.backGroundView.mas_left).with.offset(0);
        make.right.mas_equalTo(self.backGroundView.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        
        make.top.mas_equalTo(self.backGroundView.mas_bottom).with.offset(20);
        
        make.height.mas_equalTo(@44);
        
    }];

    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(14);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@25);
    }];


    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-32);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@122);
        make.height.mas_equalTo(@34);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(self.bottomButton.mas_top).offset(-50);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@25);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomButton.mas_centerY);
        make.right.mas_equalTo(self.bottomButton.mas_right).with.offset(-15);
        make.height.mas_equalTo(@15);
        make.width.mas_equalTo(@15);
    }];
    
}


@end
