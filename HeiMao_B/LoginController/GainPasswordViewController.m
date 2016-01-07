//
//  GainPasswordViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "GainPasswordViewController.h"
#import <Masonry/Masonry.h>
#import "NSString+DY_MD5.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

@interface GainPasswordViewController ()
@property (strong, nonatomic) UIButton *accomplishButton;
@property (strong, nonatomic) UITextField *passWordTextFild;
@property (strong, nonatomic) UITextField *affirmTextFild;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UIButton *goBackButton;

@property (strong, nonatomic) UIView *navImage;
@end

@implementation GainPasswordViewController
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
        _topLabel.text = @"更改密码";
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
- (UIButton *)accomplishButton{
    if (_accomplishButton == nil) {
        _accomplishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _accomplishButton.backgroundColor = kDefaultTintColor;
        _accomplishButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_accomplishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accomplishButton addTarget:self action:@selector(dealNext:) forControlEvents:UIControlEventTouchUpInside];
        [_accomplishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_accomplishButton setTitle:@"完成" forState:UIControlStateNormal];
        
    }
    return _accomplishButton;
}

- (UITextField *)passWordTextFild{
    if (_passWordTextFild == nil) {
        _passWordTextFild = [[UITextField alloc]init];
        _passWordTextFild.tag = 105;
        _passWordTextFild.placeholder = @"    请输入新的密码";
        _passWordTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _passWordTextFild.layer.borderWidth = 1;
        _passWordTextFild.font  = [UIFont systemFontOfSize:15];
        _passWordTextFild.textColor = RGB_Color(153, 153, 153);
        _passWordTextFild.secureTextEntry = YES;
    }
    return _passWordTextFild;
}

- (UITextField *)affirmTextFild{
    if (_affirmTextFild == nil) {
        _affirmTextFild = [[UITextField alloc]init];
        _affirmTextFild.tag = 106;
        _affirmTextFild.placeholder = @"    确认新密码";
        _affirmTextFild.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _affirmTextFild.layer.borderWidth = 1;
        _affirmTextFild.font  = [UIFont systemFontOfSize:15];
        _affirmTextFild.textColor = RGB_Color(153, 153, 153);
        _affirmTextFild.secureTextEntry = YES;

    }
    return _affirmTextFild;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navImage];

    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.passWordTextFild];
    [self.view addSubview:self.accomplishButton];
    [self.view addSubview:self.affirmTextFild];
    [self.view addSubview:self.goBackButton];

    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.passWordTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20+55);
        make.height.mas_equalTo(@44);
    }];
    
    [self.affirmTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.passWordTextFild.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
    }];
    
    [self.accomplishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.affirmTextFild.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
}
- (void)dealNext:(UIButton *)sender {
    
    if (![self.passWordTextFild.text isEqualToString:self.affirmTextFild.text]) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"两次密码不相同" controller:self];
        [alerview show];
        return;
    }
    
   
    
//    NSDictionary *param = @{@"smscode":self.confirmString,@"password":[self.passWordTextFild.text DY_MD5],@"mobile":self.mobile};
    [NetWorkEntiry mofifyWithPhotoNumber:self.mobile password:self.passWordTextFild.text smsCode:self.confirmString success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *param = responseObject;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改密码成功" controller:self];
            [alerview show];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_passWordTextFild resignFirstResponder];
    [_affirmTextFild resignFirstResponder];
}

@end
