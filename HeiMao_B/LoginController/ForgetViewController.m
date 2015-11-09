#import "ForgetViewController.h"
#import <Masonry/Masonry.h>


#import "GainPasswordViewController.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

static NSString *const kchangePassword = @"kchangePassword";


@interface ForgetViewController ()
@property (strong, nonatomic) UITextField *phoneNumTextField;
@property (strong, nonatomic) UITextField *confirmTextField;
@property (strong, nonatomic) UIButton *gainNum;
@property (strong, nonatomic) UIButton *runNextButton;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIView *navImage;

@end

@implementation ForgetViewController
- (UIView *)navImage {
    if (_navImage == nil) {
        _navImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 64)];
        _navImage.backgroundColor = kDefaultTintColor;
    }
    return _navImage;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"找回密码";
    }
    return _topLabel;
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
- (UITextField *)phoneNumTextField {
    if (_phoneNumTextField == nil) {
        _phoneNumTextField = [[UITextField alloc]init];
        //        _phoneNumTextField.delegate = self;
        _phoneNumTextField.tag = 102;
        _phoneNumTextField.placeholder = @"  手机号";
        _phoneNumTextField.font = [UIFont systemFontOfSize:15];
        _phoneNumTextField.textColor = RGB_Color(153, 153, 153);
        _phoneNumTextField.layer.borderWidth = 1;
        _phoneNumTextField.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
    }
    return _phoneNumTextField;
}
- (UITextField *)confirmTextField {
    if (_confirmTextField == nil) {
        _confirmTextField = [[UITextField alloc]init];
        _confirmTextField.tag = 103;
        _confirmTextField.placeholder = @"  验证码";
        _confirmTextField.font = [UIFont systemFontOfSize:15];
        _confirmTextField.textColor = RGB_Color(153, 153, 153);
        _confirmTextField.layer.borderWidth = 1;
        _confirmTextField.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
    }
    return _confirmTextField;
}
- (UIButton *)gainNum {
    if (_gainNum == nil) {
        _gainNum = [UIButton buttonWithType:UIButtonTypeCustom];
        _gainNum.backgroundColor = kDefaultTintColor;
        [_gainNum addTarget:self action:@selector(dealSend:) forControlEvents:UIControlEventTouchUpInside];
        _gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    return _gainNum;
}

- (UIButton *)runNextButton {
    if (_runNextButton == nil) {
        _runNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _runNextButton.backgroundColor = kDefaultTintColor;
        [_runNextButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_runNextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _runNextButton.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_runNextButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _runNextButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChangePassword) name:kchangePassword object:nil];
    
    [self.view addSubview:self.navImage];
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.phoneNumTextField];
    [self.view addSubview:self.confirmTextField];
    [self.view addSubview:self.runNextButton];
    [self.view addSubview:self.gainNum];
    [self.view addSubview:self.goBackButton];
    
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
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55);
        make.height.mas_equalTo(@44);
    }];
    
    [self.gainNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@117);
    }];
    
    [self.confirmTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.gainNum.mas_left).with.offset(-10);
        make.top.mas_equalTo(self.phoneNumTextField.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    
    
    [self.runNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.confirmTextField.mas_bottom).with.offset(20);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
}
#define TIME 60
- (void)dealSend:(UIButton *)sender {
    NSLog(@"发送验证码");
    
    if (self.phoneNumTextField.text == nil || self.phoneNumTextField.text.length <= 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号为空" controller:self];
        [alerview show];
        return;
    }else {
       
        [NetWorkEntiry postSmsCodeWithPhotNUmber:self.phoneNumTextField.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
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
                
                self.gainNum.titleLabel.font = [UIFont systemFontOfSize:15];
                self.gainNum.backgroundColor  = kDefaultTintColor;
                [self.gainNum setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.gainNum.userInteractionEnabled = YES;

            });
        }else {
            NSString *str = [NSString stringWithFormat:@"剩余(%d)s",count];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gainNum.backgroundColor = RGB_Color(204, 204, 204);
                [self.gainNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.gainNum setTitle:str forState:UIControlStateNormal];
                
            });
            count--;
        }
    });
    dispatch_resume(timer);
}





- (void)dealNext:(UIButton *)sender {
    
    NSString *phoneNum = self.phoneNumTextField.text;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNum];
    if (!isMatch) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"手机号不符" controller:self];
        [alerview show];
        return;
    }
    
    if (self.confirmTextField.text.length <= 0 || self.confirmTextField.text == nil) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"验证码为空" controller:self];
        [alerview show];
        return;
    }
    
    GainPasswordViewController *gain = [[GainPasswordViewController alloc] init];
    gain.confirmString = self.confirmTextField.text;
    gain.mobile = self.phoneNumTextField.text;
    [self presentViewController:gain animated:YES completion:nil];
    
}

- (void)dealChangePassword{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

