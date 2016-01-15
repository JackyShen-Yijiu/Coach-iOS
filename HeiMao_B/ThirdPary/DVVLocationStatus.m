//
//  DVVLocationStatus.m
//  studentDriving
//
//  Created by 大威 on 16/1/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "DVVLocationStatus.h"
#import <CoreLocation/CLLocationManager.h>

@interface DVVLocationStatus ()<UIAlertViewDelegate>

@property (nonatomic, copy) dispatch_block_t selectCancelBlock;
@property (nonatomic, copy) dispatch_block_t selectOkBlock;

@end

@implementation DVVLocationStatus

- (void)remindUser {
    
    if (![self checkLocationStatus]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"使用此功能需要您在设置中开启定位！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (0 == buttonIndex) {
        if (_selectCancelBlock) {
            _selectCancelBlock();
        }
    }else {
        // 打开应用设置面板
        NSURL *appSettingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:appSettingUrl];
        if (_selectOkBlock) {
            _selectOkBlock();
        }
    }
}

#pragma mark 检查定位功能是否可用
- (BOOL)checkLocationStatus {
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] ==
         kCLAuthorizationStatusAuthorizedWhenInUse ||
         [CLLocationManager authorizationStatus] ==
         kCLAuthorizationStatusAuthorizedAlways)) {
            // 定位功能可用
            return YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        // 定位功能不可用
        return NO;
    }
    return NO;
}

#pragma mark - set block
- (void)setSelectCancelButtonBlock:(dispatch_block_t)handle {
    _selectCancelBlock = handle;
}
- (void)setSelectOkButtonBlock:(dispatch_block_t)handle {
    _selectOkBlock = handle;
}

@end
