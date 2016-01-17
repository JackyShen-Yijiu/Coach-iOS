//
//  JGUserTools.h
//  KongfuziStudent
//
//  Created by linhuijie on 3/13/15.
//  Copyright (c) 2015 kongfuzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGUserModel.h"

@interface JGUserTools : NSObject

+(void) checkInitialization;

/**
 *将从我们的服务器上得到的用户昵称和头像等信息保存到本地数据库中
 */
+ (void)saveKFZUser:(JGUserModel *) user;
/**
 *根据环信ID获取对应的我们的服务器上的用户昵称和头像等信息
 */
+ (JGUserModel *) getKFZUserByEMUserName:(NSString *)mEMUserName;
/**
 *根据环信ID获取对应的我们的服务器上的用户昵称
 */
+ (NSString *) getNickNameByEMUserName:(NSString *)mEMUserName;
/**
 *根据环信ID获取对应的我们的服务器上的头像url
 */
+ (NSString *) getAvatarUrlByEMUserName:(NSString *)mEMUserName;
/**
 *根据本地数据库中保存的JGUserModel对象，其中包含用户昵称和头像等信息
 */
+ (NSMutableDictionary *) loadKFZUserListDict;
/**
 *返回全局的JGUserModel Dictionary对象，其中包含用户昵称和头像等信息
 */
+ (NSMutableDictionary *) getKFZUserListDict;
/**
 *从我们的服务器上获取用户信息，同步方法
 */
+(JGUserModel *)queryUserFromRemote:(NSString *)mEMUsername;
/**
 *从我们的服务器上获取用户信息，异步方法
 */
+(void)queryUserFromRemoteAsync:(NSString *)mEMUsername;

@end

