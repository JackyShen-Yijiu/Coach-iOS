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
#import "APService.h"
#import "EaseSDKHelper.h"
#import "ProtocalViewController.h"
#import "JGUserTools.h"

static NSString *const kloginUrl = @"userinfo/userlogin";

static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kmobileNum = @"mobile";

static NSString *const kpassword = @"password";

static NSString *const kuserType = @"usertype";

#define TIME 60

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *passwordTextField;
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UIView *backGroundView;
@property (strong, nonatomic) NSMutableDictionary *userParam;

@property (strong, nonatomic) UIButton *gainNum;

@property (nonatomic,strong) UILabel *messageLabel;

@property (nonatomic,strong) UIImageView *messageImg;

@property (nonatomic,strong) UIImageView *footImg;

@property (nonatomic, strong) NSString *passwordStr;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myNavController.navigationBar setHidden:YES];
    [[self.myNavController navigationBar] setBarTintColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (NSMutableDictionary *)userParam {
    if (_userParam == nil) {
        _userParam = [[NSMutableDictionary alloc] init];
    }
    return _userParam;
}

- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        _backGroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backGroundView;
}

- (UIImageView *)logoImageView {
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        NSString *names = [NSString stringWithFormat:@"YBLoginbg_image"];
        if (YBIphone5) {
            names = [NSString stringWithFormat:@"%@",@"YBLoginbg_image5s"];
        }
        _logoImageView.image = [UIImage imageNamed:names];
    }
    return _logoImageView;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.backgroundColor = JZ_BlueColor;
        [_loginButton addTarget:self action:@selector(dealLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"立即加入" forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 3;
        
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
        _phoneNumTextField.placeholder        = @" 请输入您的手机号码";
        _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 30, 30)];
        leftView.image = [UIImage imageNamed:@"YBLoginicon_phone"];
        _phoneNumTextField.leftView = leftView;
        
        _phoneNumTextField.layer.masksToBounds = YES;
        _phoneNumTextField.layer.cornerRadius = 1;
        _phoneNumTextField.layer.borderColor = [UIColor colorWithHexString:@"CACACA"].CGColor;
        _phoneNumTextField.layer.borderWidth = 1;
        
    }
    
    return _phoneNumTextField;
    
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.delegate = self;
        _passwordTextField.placeholder = @" 请输入收到的验证码";
        _passwordTextField.tag = 101;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:15];
        _passwordTextField.textColor = RGB_Color(51, 51, 51);
        UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 30, 30)];
        leftView.image = [UIImage imageNamed:@"YBLoginicon_yanzheng"];
        _passwordTextField.leftView = leftView;
        _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextField.layer.masksToBounds = YES;
        _passwordTextField.layer.cornerRadius = 2;
        _passwordTextField.layer.borderColor = [UIColor colorWithHexString:@"CACACA"].CGColor;
        _passwordTextField.layer.borderWidth = 1;
    
        
    }
    return _passwordTextField;
}

- (UIButton *)gainNum {
    if (_gainNum == nil) {
        
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = [UIColor colorWithHexString:@"E4EDFF"];
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        [_gainNum setTitle:@"验证" forState:UIControlStateNormal];
        [_gainNum setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
        [_gainNum setTitleColor:JZ_BlueColor forState:UIControlStateHighlighted];
        _gainNum.layer.masksToBounds = YES;
        _gainNum.layer.cornerRadius = 3;
        _gainNum.layer.borderWidth = 1;
        _gainNum.layer.borderColor = [UIColor colorWithHexString:@"8CB1FE"].CGColor;
        
    }
    return _gainNum;
}


- (UIImageView *)messageImg
{
    if (_messageImg==nil) {
        _messageImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"YBLoginicon_!"]];
    }
    return _messageImg;
}

- (UIImageView *)footImg
{
    if (_footImg==nil) {
        _footImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JGLoginFootImg"]];
        _footImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_footImgDidClick)];
        [_footImg addGestureRecognizer:tap];
    }
    return _footImg;
}

- (UILabel *)messageLabel
{
    if (_messageLabel==nil) {
        
        _messageLabel = [[UILabel alloc] init];
        CGFloat font = 13;
        _messageLabel.font = [UIFont systemFontOfSize:font];
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.text = @" 只有联盟驾校教练才可以通过验证，加入极致驾服！";
        _messageLabel.textColor = [UIColor lightGrayColor];
        _messageLabel.numberOfLines = 0;
        
    }
    return _messageLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DYdealRegister) name:kregisterUser object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealSubmit) name:@"submitSuccess" object:nil];

    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.backGroundView];
    
    [self.view addSubview:self.messageLabel];
    [self.view addSubview:self.messageImg];
    
    [self.view addSubview:self.footImg];
    
    [self.backGroundView addSubview:self.phoneNumTextField];
    [self.backGroundView addSubview:self.passwordTextField];
    [self.backGroundView addSubview:self.gainNum];

}
- (void)dealSubmit {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    WS(ws);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NetWorkEntiry newloginWithPhotoNumber:self.phoneNumTextField.text code:self.passwordTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"登陆responseObject:%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
       
        NSDictionary *param = responseObject;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        
        if (type.integerValue == 1) {
            
            self.passwordStr = responseObject[@"data"][@"password"];

            BOOL isLoggedIn = [[EaseMob sharedInstance].chatManager isLoggedIn];
            
            if (isLoggedIn) {
                [[EaseMob sharedInstance].chatManager logoffWithUnbindDeviceToken:YES error:nil];
                
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES];
                
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                    
                } onQueue:nil];
                [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
                    
                    if (!error && info) {
                    }
                } onQueue:nil];
            }
            
            NSString *coachid = [NSString stringWithFormat:@"%@",param[@"data"][@"coachid"]];
            
            // 异步登陆账号
            [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:coachid
                                                                password:self.passwordStr
                                                              completion:
             ^(NSDictionary *loginInfo, EMError *error) {
                 
                 NSLog(@"环信登陆loginInfo:%@ error:%@",loginInfo,error);
                 
                 [MBProgressHUD hideHUDForView:self.view animated:NO];
                 
                 if (loginInfo && !error) {
                     
                     NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param[@"data"]];
                     
                     [[UserInfoModel defaultUserInfo] loginViewDic:dic];
                     
                     NSString *coachID = [NSString stringWithFormat:@"%@",[UserInfoModel defaultUserInfo].driveschoolinfo[@"id"]];
                     NSSet *set = [NSSet setWithObjects:JPushTag,coachID, nil];
                     [APService setTags:set alias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                     
                     // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
                     EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
                     if (!error) {
                         //获取数据库中数据
                         error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                     }
                     
//                    [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:NO];
                     
                     // 设置自动登录
                     [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
                     
                     self.passwordTextField.text = @"";
                     
                     if ([_delegate respondsToSelector:@selector(loginViewControllerdidLoginSucess:)]) {
                         [_delegate loginViewControllerdidLoginSucess:self];
                     }
                     
                 }
                 else
                 {
                     ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:error.description controller:self];
                     [alerview show];
                     
                 }
                 
             } onQueue:nil];
            
        }else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
            [ws.passwordTextField becomeFirstResponder];
        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];

}
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    
    NSLog(@"TagsAlias回调:%@", callbackString);
}

#pragma mark - textfieldDelegate 业务逻辑

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100) {
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
    
    
    CGFloat height = 275;
    if (YBIphone5) {
        height = 235;
    }
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImageView.mas_bottom).with.offset(30);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.height.mas_equalTo(@105);
    }];
    
    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(@45);
        make.width.mas_equalTo(@75);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(self.gainNum.mas_left).offset(-10);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(@45);
    }];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(15);
        make.height.mas_equalTo(@45);
    }];
    
    [self.messageImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left);
        make.centerY.mas_equalTo(self.messageLabel.mas_centerY);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundView.mas_bottom).with.offset(11);
        make.left.mas_equalTo(self.messageImg.mas_right).offset(5);
        make.right.mas_equalTo(self.backGroundView.mas_right);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.top.mas_equalTo(self.messageLabel.mas_bottom).with.offset(16);
        make.height.mas_equalTo(@44);
    }];
    
    
    [self.footImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-20);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(13);
    }];
    
}

- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length < 11) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号不正确" controller:self];
        [alerview show];
        return;
    }else {
        WS(ws);
        [NetWorkEntiry newGetSMSCodeWithPhotNUmber:self.phoneNumTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"发送验证码responseObject:%@",responseObject);
            
            NSDictionary *param = responseObject;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            
            if (type.integerValue != 1) {
            
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
                [alert show];
                
            }else{
                [ws.phoneNumTextField resignFirstResponder];
                [ws.passwordTextField becomeFirstResponder];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
    
    sender.userInteractionEnabled = NO;
    __block int count = TIME;
    dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, myQueue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (count < 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.gainNum setTitle:@"验证" forState:UIControlStateNormal];
                self.gainNum.userInteractionEnabled = YES;
                
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"%ds",count];
            dispatch_async(dispatch_get_main_queue(), ^{

                [self.gainNum setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneNumTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)_footImgDidClick
{
    NSLog(@"%s",__func__);
    ProtocalViewController *vc = [[ProtocalViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
