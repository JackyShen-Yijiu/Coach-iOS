//
//  RegisterViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/4.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+DY_MD5.h"
#import "CompleteInformationViewController.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)
#import "UserInfoModel.h"
#import "ProtocalViewController.h"
static NSString *const kregisterUser = @"kregisterUser";

static NSString *const kregisterUrl = @"userinfo/signup";

static NSString *const kcodeGainUrl = @"code";

@interface RegisterViewController ()<UITextFieldDelegate>

@property (strong, nonatomic)UIButton *goBackButton;
@property (strong, nonatomic)UIButton *sendButton;
@property (strong, nonatomic)UIButton *registerButton;
@property (strong, nonatomic)UITextField *phoneTextField;
@property (strong, nonatomic)UITextField *authCodeTextFild;
@property (strong, nonatomic)UITextField *passWordTextFild;
@property (strong, nonatomic)UITextField *affirmTextFild;
@property (strong, nonatomic)UITextField *invitationTextFild;
@property (strong, nonatomic)UILabel *noteLabel;
@property (strong, nonatomic) UILabel *topLabel;

@property (strong, nonatomic) NSMutableDictionary *paramsPost;
@property (strong, nonatomic) UIView *navImage;

@end

@implementation RegisterViewController
- (UIView *)navImage {
    if (_navImage == nil) {
        _navImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 64)];
        _navImage.backgroundColor = kDefaultTintColor;
    }
    return _navImage;
}
- (NSMutableDictionary *)paramsPost {
    if (_paramsPost == nil) {
        _paramsPost = [[NSMutableDictionary alloc] init];
    }
    return _paramsPost;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"注册";
    }
    return _topLabel;
}

- (UILabel *)noteLabel{
    if (_noteLabel == nil) {
        _noteLabel = [[UILabel alloc]init];
        _noteLabel.backgroundColor = [UIColor whiteColor];
//        [_noteLabel setTextColor:RGB_Color(153, 153, 153)];
        [_noteLabel setText:@"点击注册则表示您同意《用户服务协议》"];
        _noteLabel.font = [UIFont systemFontOfSize:13];
        _noteLabel.textColor =  RGB_Color(0x28, 0x79, 0xF3);
        _noteLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTap:)];
        [_noteLabel addGestureRecognizer:tap];
    }
    return _noteLabel;
}
- (void)dealTap:(UITapGestureRecognizer *)tap {
//    self.noteLabel.textColor = [UIColor blueColor];
    ProtocalViewController *protocal = [[ProtocalViewController alloc] init];
    [self presentViewController:protocal animated:YES completion:nil];
}
- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (UIButton *)sendButton{
    if (_sendButton == nil) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = kDefaultTintColor;
        [_sendButton addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        
    }
    return _sendButton;
}

- (UIButton *)registerButton{
    if (_registerButton == nil) {
        _registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerButton.backgroundColor = kDefaultTintColor;
        _registerButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_registerButton addTarget:self action:@selector(dealRegister:) forControlEvents:UIControlEventTouchUpInside];
        [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _registerButton;
}

- (UITextField *)phoneTextField{
    if (_phoneTextField == nil) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.delegate = self;
        _phoneTextField.tag = 102;
        _phoneTextField.placeholder = @"    手机号";
        _phoneTextField.layer.borderColor =RGB_Color(204, 204, 204).CGColor;
        _phoneTextField.layer.borderWidth = 1;
        _phoneTextField.font  = [UIFont systemFontOfSize:15];
        _phoneTextField.textColor = RGB_Color(153, 153, 153);
    }
    return _phoneTextField;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[UITextField alloc]init];
        _passWordTextFild.delegate = self;
        _passWordTextFild.tag = 103;
        _passWordTextFild.placeholder = @"    密码";
        _passWordTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _passWordTextFild.layer.borderWidth = 1;
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = RGB_Color(153, 153, 153);
        _passWordTextFild.secureTextEntry = YES;
    }
    return _passWordTextFild;
}

- (UITextField *)authCodeTextFild{
    if (_authCodeTextFild == nil) {
        _authCodeTextFild = [[UITextField alloc]init];
        _authCodeTextFild.delegate = self;
        _authCodeTextFild.tag = 104;
        _authCodeTextFild.placeholder = @"    验证码";
        _authCodeTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _authCodeTextFild.layer.borderWidth = 1;
        _authCodeTextFild.font  = [UIFont systemFontOfSize:15];
        _authCodeTextFild.textColor = RGB_Color(153, 153, 153);
    }
    return _authCodeTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[UITextField alloc]init];
        _affirmTextFild.delegate = self;
        _affirmTextFild.tag = 105;
        _affirmTextFild.placeholder = @"    确认密码";
        _affirmTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _affirmTextFild.layer.borderWidth = 1;
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = RGB_Color(153, 153, 153);
        _affirmTextFild.secureTextEntry = YES;
    }
    return _affirmTextFild;
}

- (UITextField *)invitationTextFild{
    if (_invitationTextFild == nil) {
        _invitationTextFild = [[UITextField alloc]init];
        _invitationTextFild.delegate = self;
        _invitationTextFild.tag = 106;
        _invitationTextFild.placeholder = @"    输入邀请码,获得奖励";
        _invitationTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _invitationTextFild.layer.borderWidth = 1;
        _invitationTextFild.font  = [UIFont systemFontOfSize:15];
        _invitationTextFild.textColor = RGB_Color(153, 153, 153);
    }
    return _invitationTextFild;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealSubmit) name:@"submitSuccess" object:nil];
    [self.view addSubview:self.navImage];
    
    [self.view addSubview:self.topLabel];
    
    [self.view addSubview:self.goBackButton];
    
    [self.view addSubview:self.sendButton];
    
    [self.view addSubview:self.registerButton];
    
    [self.view addSubview:self.phoneTextField];
    
    [self.view addSubview:self.authCodeTextFild];
    
    [self.view addSubview:self.passWordTextFild];
    
    [self.view addSubview:self.invitationTextFild];
    
    [self.view addSubview:self.affirmTextFild];
    
    [self.view addSubview:self.noteLabel];
    
}

- (void)dealSubmit {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma make :自动布局


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.goBackButton.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.authCodeTextFild mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.sendButton.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    
    
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.authCodeTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.invitationTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@40);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
    
    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.top.mas_equalTo(self.registerButton.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@250);
    }];
    
    
}
#pragma mark - buttonAction

#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneTextField.text == nil || self.phoneTextField.text.length <= 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号为空" controller:self];
        [alerview show];
        return;
    }else {
        
        [NetWorkEntiry postSmsCodeWithPhotNUmber:self.phoneTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *param = responseObject;
            NSNumber *type = param[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
            if (type.integerValue == 1) {
              
            }else {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
                [alerview show];
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
                self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15];
                self.sendButton.backgroundColor  = kDefaultTintColor;
                [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sendButton.backgroundColor = RGB_Color(204, 204, 204);
                [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.sendButton setTitle:str forState:UIControlStateNormal];
                
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealRegister:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneTextField.text;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
//        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号不符" controller:self];
//        [alerview show];
//        return;
    }
    if (self.authCodeTextFild.text.length <= 0 || self.authCodeTextFild.text == nil) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"验证码为空" controller:self];
        [alerview show];
        return;
    }
    [self.paramsPost setObject:self.authCodeTextFild.text forKey:@"smscode"];
    if (self.passWordTextFild.text == nil || self.passWordTextFild.text.length <= 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"密码为空" controller:self];
        [alerview show];
        return;
        
    }
    
    if (self.affirmTextFild.text == nil || self.affirmTextFild.text.length <= 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"确认密码为空" controller:self];
        [alerview show];
        return;
    }
    if (![self.passWordTextFild.text isEqualToString:self.affirmTextFild.text]) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"两次密码不相同" controller:self];
        [alerview show];
        return;
    }
    //网络请求
    
    
    [NetWorkEntiry registereWithWithPhotoNumber:self.phoneTextField.text password:self.passWordTextFild.text smsCode:self.authCodeTextFild.text referrerCode:self.invitationTextFild.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *param = responseObject;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            [[UserInfoModel defaultUserInfo] loginViewDic:param[@"data"]];
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"注册成功" controller:self];
            [alerview show];
            CompleteInformationViewController *comInformation = [[CompleteInformationViewController alloc] init];
            [self presentViewController:comInformation animated:YES completion:nil];

           
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_phoneTextField resignFirstResponder];
    [_authCodeTextFild resignFirstResponder];
    [_passWordTextFild resignFirstResponder];
    [_affirmTextFild resignFirstResponder];
    [_invitationTextFild resignFirstResponder];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
