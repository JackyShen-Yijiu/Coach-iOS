//
//  AppDelegate+YJPush.h
//  HeiMao_B
//
//  Created by 大威 on 16/1/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (YJPush)

/**
 *  统一处理JPush推送
 *
 *  @param dict 推送消息字典
 */
- (void)handleJPushNotification:(NSDictionary *)userInfo;

@end
