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
#import "WorkTypeListController.h"

#define url [NSString stringWithFormat:@"%@/userinfo/applyverification",HOST_TEST_DAMIAN]

@interface CompleteInformationViewController ()<QueryViewControllerDelegate,WorkTypeListControllerDelegate>
@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic) UITextField *idcarNumTextField;
@property (strong, nonatomic) UITextField *caochIdNumTextField;
@property (strong, nonatomic) UITextField *invitationTextFild;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UIButton    * drivingDetail;
@property (strong, nonatomic) UILabel     * drivingLabel;
@property (strong, nonatomic) UIImageView * indexImage;
@property (strong, nonatomic) UIButton    * workDetailButton;
@property (strong, nonatomic) UILabel     * workTypeLabel;
@property (strong, nonatomic) UIImageView * workTypeArrow;
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
        _drivingLabel.text = @"所在驾校";
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

- (UILabel *)workTypeLabel
{
    if (_workTypeLabel == nil) {
        _workTypeLabel = [[UILabel alloc] init];
        _workTypeLabel.text = @"工作性质";
        _workTypeLabel.textColor = RGB_Color(194, 194, 200);
        _workTypeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _workTypeLabel;
}

- (UIImageView *)workTypeArrow
{
    if (_workTypeArrow == nil) {
        _workTypeArrow = [[UIImageView alloc] init];
        _workTypeArrow.image = [UIImage imageNamed:@"右箭头.png"];
    }
    return _workTypeArrow;
}


- (UIButton *)workDetailButton
{
    if (_workDetailButton == nil) {
        _workDetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _workDetailButton.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _workDetailButton.layer.borderWidth = 1;
        [_workDetailButton addTarget:self action:@selector(workTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _workDetailButton;

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
        _topLabel.text = @"提交审核";
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
- (UITextField *)nameTextField{
    if (_nameTextField == nil) {
        _nameTextField = [[UITextField alloc]init];
        _nameTextField.tag = 106;
        _nameTextField.placeholder = @"    姓名";
        _nameTextField.layer.borderColor = RGB_Color(204, 204, 204).CGColor;
        _nameTextField.layer.borderWidth = 1;
        _nameTextField.font  = [UIFont systemFontOfSize:15];
        _nameTextField.textColor = RGB_Color(153, 153, 153);
        
    }
    return _nameTextField;
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
        
    }
    return _idcarNumTextField;
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

        
    }
    return _caochIdNumTextField;
}
- (UITextField *)invitationTextFild{
    if (_invitationTextFild == nil) {
        _invitationTextFild = [[UITextField alloc]init];
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
    [self.view addSubview:self.nameTextField];
    [self.view addSubview:self.idcarNumTextField];
//    [self.view addSubview:self.drivingIdNumTextField];
    [self.view addSubview:self.caochIdNumTextField];
    [self.view addSubview:self.invitationTextFild];
    [self.view addSubview:self.drivingDetail];
    [self.view addSubview:self.workDetailButton];
    [self.view addSubview:self.submitButton];
    
    [self.drivingDetail addSubview:self.drivingLabel];
    [self.drivingDetail addSubview:self.indexImage];
    
    [self.workDetailButton addSubview:self.workTypeLabel];
    [self.workDetailButton addSubview:self.workTypeArrow];
    
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
    
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.goBackButton.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];
    
    [self.idcarNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.nameTextField.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);

    }];
    [self.caochIdNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.idcarNumTextField.mas_bottom).with.offset(7);
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
    
    [self.workDetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
        make.top.mas_equalTo(self.drivingDetail.mas_bottom).with.offset(7);
        make.height.mas_equalTo(@44);
    }];

    
    [self.workTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.workDetailButton.mas_left).offset(15);
        make.centerY.mas_equalTo(self.workDetailButton.mas_centerY);
    }];
    
    [self.workTypeArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.workDetailButton.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.workDetailButton.mas_centerY);
        make.height.mas_equalTo(@25);
        make.width.mas_equalTo(@25);
    }];

    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(self.workDetailButton.mas_bottom).offset(7);
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

- (void)workTypeButtonClick:(UIButton *)button
{
    WorkTypeListController * listController = [[WorkTypeListController alloc] init];
    listController.delegate = self;
    [self presentViewController:listController animated:YES completion:nil];
}

- (void)workTypeListController:(WorkTypeListController *)controller didSeletedWorkType:(KCourseWorkType)type workName:(NSString *)name
{
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    self.workTypeLabel.text = name;
}

- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)clickSubmit:(UIButton *)sender {
    NSString *urlstring = url;
    NSMutableDictionary *mubDic = [[NSMutableDictionary alloc] init];
    
    if (self.nameTextField == nil || self.nameTextField.text.length == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"挂靠驾校未选择" controller:self];
        [alerview show];
    }else {
        [mubDic setObject:self.nameTextField.text forKey:@"name"];
    }
    
    if (self.drivingId == nil || self.drivingId.length == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"挂靠驾校未选择" controller:self];
        [alerview show];
    }else {
        [mubDic setObject:self.drivingId forKey:@"driveschoolid"];
    }
    if (self.idcarNumTextField.text == nil || self.idcarNumTextField.text.length == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"身份证为空" controller:self];
        [alerview show];
    }else {
        [mubDic setObject:self.idcarNumTextField.text forKey:@"idcardnumber"];
    }
    
    if (self.workTypeLabel.text == nil || self.workTypeLabel.text.length == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"工作性质为空" controller:self];
        [alerview show];
    }else {
        [mubDic setObject:@([WorkTypeModel converStringToType:self.workTypeLabel.text]) forKey:@"coachtype"];
    }
    if (self.caochIdNumTextField.text == nil || self.caochIdNumTextField.text.length == 0) {
        ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"教练证为空" controller:self];
        [alerview show];
    }else {
        [mubDic setObject:self.caochIdNumTextField.text forKey:@"coachnumber"];
    }
    if ([UserInfoModel defaultUserInfo].userID) {
        [mubDic setObject:[UserInfoModel defaultUserInfo].userID forKey:@"coachid"];
    }
    
    NSString *   token = [[UserInfoModel defaultUserInfo] token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"authorization"];
    
    [manager POST:urlstring parameters:mubDic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *param = responseObject;
        NSNumber *type = param[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",param[@"msg"]];
        if (type.integerValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"提交审核成功" controller:self];
            [alerview show];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"submitSuccess" object:nil];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_idcarNumTextField resignFirstResponder];
//    [_drivingIdNumTextField resignFirstResponder];
    [_caochIdNumTextField resignFirstResponder];
    [_invitationTextFild resignFirstResponder];
}
@end
