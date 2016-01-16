//
//  StudentSignInController.m
//  HeiMao_B
//
//  Created by 大威 on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "StudentSignInController.h"
#import "MASonry.h"
#import "StudentSignInViewModel.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "MBProgressHUD.h"
#import "StudentSignInStatusView.h"
#import "DVVLocationStatus.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

@interface StudentSignInController ()<BMKLocationServiceDelegate>

@property (nonatomic, strong) StudentSignInViewModel *viewModel;
@property (nonatomic, strong) UILabel *studentNameLabel;
@property (nonatomic, strong) UILabel *courseProcessDescLabel;
@property (nonatomic, strong) UILabel *studentLocationAddressLabel;
@property (nonatomic, strong) UIButton *okButton;

// 定位服务
@property (nonatomic, strong) BMKLocationService *locationService;
// 是否定位成功
@property (nonatomic, assign) BOOL locationSuccess;
// 检查定位服务
@property (nonatomic, strong) DVVLocationStatus *dvvLocationStatus;

@end

@implementation StudentSignInController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"学员签到";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.studentNameLabel];
    [self.view addSubview:self.courseProcessDescLabel];
    [self.view addSubview:self.studentLocationAddressLabel];
    [self.view addSubview:self.okButton];
    [self configUI];
    [self configViewModel];
    
    // 开始定位
    [self startLocation];
    
    _studentNameLabel.text = [NSString stringWithFormat:@"学员姓名:%@", _dataModel.studentName];
    _courseProcessDescLabel.text = [NSString stringWithFormat:@"预约课时:%@", _dataModel.courseProcessDesc];
    _studentLocationAddressLabel.text = [NSString stringWithFormat:@"当前姓名:%@", _dataModel.locationAddress];
}

#pragma mark 开始定位
- (void)startLocation {
    
    // 检查用户是否开启了定位服务
    _dvvLocationStatus = [DVVLocationStatus new];
    __weak typeof(self) ws = self;
    [_dvvLocationStatus setSelectCancelButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    [_dvvLocationStatus setSelectOkButtonBlock:^{
        [ws.navigationController popViewControllerAnimated:YES];
    }];
    if (![_dvvLocationStatus checkLocationStatus]) {
        [_dvvLocationStatus remindUser];
        return ;
    }
    // 启动LocationService
    [self.locationService startUserLocationService];
}

#pragma mark - action
- (void)okButtonAction:(UIButton *)sender {
//    __weak typeof(self) ws = self;
//    StudentSignInStatusView *statusView = [[StudentSignInStatusView alloc] initWithFrame:ws.view.bounds imageName:@"iconfont-iconfontdui" message:@"恭喜您，学员签到成功！"];
//    [self.view addSubview:statusView];
//    statusView.okButton.tag = 1;
//    [statusView.okButton addTarget:self action:@selector(statusViewOkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    StudentSignInStatusView *statusView = [[StudentSignInStatusView alloc] initWithFrame:ws.view.bounds imageName:@"iconfont-cuo" message:@"学员签到失败！"];
//    [self.view addSubview:statusView];
//    [statusView.okButton setTitle:@"确定" forState:UIControlStateNormal];
//    [statusView.okButton addTarget:self action:@selector(statusViewOkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 验证二维码信息是否正确，防止传参数时崩溃
    NSString *errorMsg = @"信息不完整，请重新扫码！";
    if (!_dataModel) {
        [self showAlertWithMessage:errorMsg];
        return ;
    }
    if (!_dataModel.studentId) {
        [self showAlertWithMessage:errorMsg];
        return ;
    }
    
    if (_locationSuccess) { // 如果定位成功则直接搜索
        [self startVerification];
    }else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self.locationService startUserLocationService];
    }
}
#pragma mark 开始验证学员签到
- (void)startVerification {
    
    // 设置请求参数
    _viewModel.userId = _dataModel.studentId;
    _viewModel.coachId = [UserInfoModel defaultUserInfo].userID;
    _viewModel.reservationId = _dataModel.reservationId;
    _viewModel.codeCreateTime = _dataModel.createTime;
    _viewModel.userlatitude = _dataModel.latitude;
    _viewModel.userLongitude = _dataModel.longitude;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // 请求网络数据
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark config viewModel
- (void)configViewModel {
    
    __weak typeof(self) ws = self;
    _viewModel = [StudentSignInViewModel new];
    [_viewModel dvvSetRefreshSuccessBlock:^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        [self showAlertWithMessage:@"签到成功"];
//        [self showToastWithImageName:@"iconfont-iconfontdui" message:@"签到成功"];
        StudentSignInStatusView *statusView = [[StudentSignInStatusView alloc] initWithFrame:ws.view.bounds imageName:@"iconfont-iconfontdui" message:@"恭喜您，学员签到成功！"];
        [self.view addSubview:statusView];
        statusView.okButton.tag = 1;
        [statusView.okButton addTarget:self action:@selector(statusViewOkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        StudentSignInStatusView *statusView = [[StudentSignInStatusView alloc] initWithFrame:ws.view.bounds imageName:@"iconfont-cuo" message:@"学员签到失败！"];
        [self.view addSubview:statusView];
        [statusView.okButton setTitle:@"确定" forState:UIControlStateNormal];
        [statusView.okButton addTarget:self action:@selector(statusViewOkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self showAlertWithMessage:@"签到失败!"];
//        [self showToastWithImageName:@"iconfont-cuo" message:@"签到失败"];
    }];
}
- (void)statusViewOkButtonAction:(UIButton *)button {
    if (button.tag) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [button.superview removeFromSuperview];
    }
}

#pragma mark - 定位功能
#pragma mark 处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _locationSuccess = YES;
    // 保存经纬度
    _viewModel.coachLatitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    _viewModel.coachLongitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    // 定位成功，开始验证学员签到
    [self startVerification];
}

#pragma mark - configUI
- (void)configUI {
    
    __weak typeof(self) ws = self;
    [_studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64 + 15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(15);
        make.height.mas_equalTo(20);
    }];
    [_courseProcessDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.studentNameLabel.mas_bottom);
        make.left.mas_equalTo(ws.studentNameLabel.mas_left);
        make.right.mas_equalTo(ws.studentNameLabel.mas_right);
        make.height.mas_equalTo(ws.studentNameLabel.mas_height);
    }];
    [_studentLocationAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.courseProcessDescLabel.mas_bottom);
        make.left.mas_equalTo(ws.studentNameLabel.mas_left);
        make.right.mas_equalTo(ws.studentNameLabel.mas_right);
        make.height.mas_equalTo(ws.studentNameLabel.mas_height);
    }];
    [_okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.studentLocationAddressLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    
    _okButton.backgroundColor = kDefaultTintColor;
}

#pragma mark - lazy load
- (BMKLocationService *)locationService {
    if (!_locationService) {
        _locationService = [BMKLocationService new];
        // 精确度100米
        _locationService.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationService.distanceFilter = kCLDistanceFilterNone;
        _locationService.delegate = self;
    }
    return _locationService;
}
- (UILabel *)studentNameLabel {
    if (!_studentNameLabel) {
        _studentNameLabel = [UILabel new];
        _studentNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _studentNameLabel;
}
- (UILabel *)courseProcessDescLabel {
    if (!_courseProcessDescLabel) {
        _courseProcessDescLabel = [UILabel new];
        _courseProcessDescLabel.font = [UIFont systemFontOfSize:14];
    }
    return _courseProcessDescLabel;
}
- (UILabel *)studentLocationAddressLabel {
    if (!_studentLocationAddressLabel) {
        _studentLocationAddressLabel = [UILabel new];
        _studentLocationAddressLabel.font = [UIFont systemFontOfSize:14];
    }
    return _studentLocationAddressLabel;
}
- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton new];
        [_okButton setTitle:@"提交" forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okButton;
}

#pragma mark 显示提示窗
- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:okAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)showToastWithImageName:(NSString *)imageName
                       message:(NSString *)message {
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = message;
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
