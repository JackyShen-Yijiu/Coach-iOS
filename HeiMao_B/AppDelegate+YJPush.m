//
//  AppDelegate+YJPush.m
//  HeiMao_B
//
//  Created by 大威 on 16/1/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "AppDelegate+YJPush.h"

@implementation AppDelegate (YJPush)

- (void)handleJPushNotification:(NSDictionary *)userInfo {
    
    if (![userInfo isKindOfClass:[NSDictionary class]]) {
        return ;
    }
    NSString *type = [userInfo objectForKey:@"type"];
    if (!type) {
        return ;
    }
    
    // 获取提示信息
    NSDictionary *aps = userInfo[@"aps"];
    
    if (aps&&aps.count!=0) {
        
        NSString *message = aps[@"alert"];
        
        // 审核通过
        if ([type isEqualToString:@"auditsucess"]) {
            [self showAlertWithMessage:message];
        }
        // 审核未通过
        if ([type isEqualToString:@"auditfailed"]) {
            [self showAlertWithMessage:message];
        }
        // 新的预约
        if ([type isEqualToString:@"newreservation"]) {
            [self showAlertWithMessage:message];
        }
        // 预约取消
        if ([type isEqualToString:@"reservationcancel"]) {
            [self showAlertWithMessage:message];
        }
        // 得到新的评价
        if ([type isEqualToString:@"newcommnent"]) {
            [self showAlertWithMessage:message];
        }
        // 系统通知
        if ([type isEqualToString:@"systemmsg"]) {
            [self showAlertWithMessage:@"您有一条新系统消息"];
        }
        // 钱包更新
        if ([type isEqualToString:@"walletupdate"]) {
            [self showAlertWithMessage:message];
        }
        // 新版本
        if ([type isEqualToString:@"newversion"]) {
            [self showAlertWithMessage:message];
        }
    }
}

#pragma mark 显示弹窗提示
- (void)showAlertWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

@end
