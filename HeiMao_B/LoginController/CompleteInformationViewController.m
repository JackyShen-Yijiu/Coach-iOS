//
//  CompleteInformationViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CompleteInformationViewController.h"
#import <Masonry/Masonry.h>
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)
#import "QueryViewController.h"

@interface CompleteInformationViewController ()<QueryViewControllerDelegate>
@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UITextField *idcarNumTextField;
@property (strong, nonatomic) UITextField *drivingIdNumTextField;
@property (strong, nonatomic) UITextField *caochIdNumTextField;
@property (strong, nonatomic) UITextField *invitationTextFild;

@property (strong, nonatomic) UIButton *drivingDetail;
@property (strong, nonatomic) UILabel *drivingLabel;
@property (strong, nonatomic) UIImageView *indexImage;
@property (strong, nonatomic) UIButton *submitButton;
@property (copy, nonatomic) NSString *drivingId;
@end

@implementation CompleteInformationViewController

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        _submitButton.backgroundColor = kDefaultTintColor;
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];

        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (UILabel *)drivingLabel {
    if (_drivingLabel == nil) {
        _drivingLabel = [[UILabel alloc] init];
        _drivingLabel.text = @"挂靠驾校";
        _drivingLabel.textColor = RGB_Color(194, 194, 200);
        _drivingLabel.font = [UIFont systemFontOfSize:15];
    }
    return _drivingLabel;
}
- (UIImageView *)indexImage {
    if (_indexImage == nil) {
        _indexImage = [[UIImageView alloc] init];
        _indexImage.image = [UIImage imageNamed:@"右箭头.png"];
    }
    return _indexImage;
}
- (UIButton *)drivingDetail {
    if (_drivingDetail == nil) {
        _drivingDetail = [UIButton buttonWithType:UIButtonTypeCustom];
        _drivingDetail.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _drivingDetail.layer.borderWidth = 1;
        [_drivingDetail addTarget:self action:@selector(dealDriving:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _drivingDetail;
}

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

- (UITextField *)idcarNumTextField{
    if (_idcarNumTextField == nil) {
        _idcarNumTextField = [[UITextField alloc]init];
        _idcarNumTextField.tag = 106;
        _idcarNumTextField.placeholder = @"    身份证";
        _idcarNumTextField.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _idcarNumTextField.layer.borderWidth = 1;
        _idcarNumTextField.font  = [UIFont systemFontOfSize:15];
        _idcarNumTextField.textColor = RGB_Color(153, 153, 153);
        _idcarNumTextField.secureTextEntry = YES;
        
    }
    return _idcarNumTextField;
}
- (UITextField *)drivingIdNumTextField{
    if (_drivingIdNumTextField == nil) {
        _drivingIdNumTextField = [[UITextField alloc]init];
        _drivingIdNumTextField.tag = 106;
        _drivingIdNumTextField.placeholder = @"    驾驶证";
        _drivingIdNumTextField.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _drivingIdNumTextField.layer.borderWidth = 1;
        _drivingIdNumTextField.font  = [UIFont systemFontOfSize:15];
        _drivingIdNumTextField.textColor = RGB_Color(153, 153, 153);
        _drivingIdNumTextField.secureTextEntry = YES;
        
    }
    return _drivingIdNumTextField;
}
- (UITextField *)caochIdNumTextField{
    if (_caochIdNumTextField == nil) {
        _caochIdNumTextField = [[UITextField alloc]init];
        _caochIdNumTextField.tag = 106;
        _caochIdNumTextField.placeholder = @"    教练证";
        _caochIdNumTextField.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _caochIdNumTextField.layer.borderWidth = 1;
        _caochIdNumTextField.font  = [UIFont systemFontOfSize:15];
        _caochIdNumTextField.textColor = RGB_Color(153, 153, 153);
        _caochIdNumTextField.secureTextEntry = YES;
        
    }
    return _caochIdNumTextField;
}
- (UITextField *)invitationTextFild{
    if (_invitationTextFild == nil) {
        _invitationTextFild = [[UITextField alloc]init];
//        _invitationTextFild.delegate = self;
        _invitationTextFild.tag = 106;
        _invitationTextFild.placeholder = @"    输入邀请码获得奖励";
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
    [self.view addSubview:self.navImage];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.goBackButton];
    [self.view addSubview:self.idcarNumTextField];
    [self.view addSubview:self.drivingIdNumTextField];
    [self.view addSubview:self.caochIdNumTextField];
    [self.view addSubview:self.invitationTextFild];
    [self.view addSubview:self.drivingDetail];
    [self.view addSubview:self.submitButton];
    
    [self.drivingDetail addSubview:self.drivingLabel];
    [self.drivingDetail addSubview:self.indexImage];
    
    
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
    
    [self.idcarNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.goBackButton.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);

    }];
    
    [self.drivingIdNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.idcarNumTextField.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    [self.caochIdNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.drivingIdNumTextField.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.invitationTextFild mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.caochIdNumTextField.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.drivingDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.invitationTextFild.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.drivingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drivingDetail.mas_left).offset(15);
        make.centerY.mas_equalTo(self.drivingDetail.mas_centerY);
    }];
    
    [self.indexImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.drivingDetail.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.drivingDetail.mas_centerY);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@25);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(self.drivingDetail.mas_bottom).offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    
}
- (void)dealDriving:(UIButton *)sender {
    QueryViewController *query = [[QueryViewController alloc] init];
    query.delegate = self;
    [self presentViewController:query animated:YES completion:nil];
}
- (void)senderData:(NSDictionary *)dic {
    self.drivingLabel.text = dic[@"name"];
    self.drivingId = dic[@"id"];
}
- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clickSubmit:(UIButton *)sender {
    
    
    
}
@end