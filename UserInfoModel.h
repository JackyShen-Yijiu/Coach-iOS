//
//  UserInfoModel.h
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelDefine.h"


@interface UserInfoModel : NSObject
@property(nonatomic,strong)NSString * userID;
@property(nonatomic,strong)NSString * portrait;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * token;
@property(nonatomic,strong)NSString * displaycoachid;
@property(nonatomic,strong)NSString * introduction;
@property(nonatomic,strong)NSString * Gender;
@property(nonatomic,strong)NSString * idcardnumber;
//驾驶证号
@property(nonatomic,strong)NSString * drivinglicensenumber;
@property(nonatomic,strong)NSString * schoolId;
@property(nonatomic,strong)NSString * md5Pass;
@property(nonatomic,strong)NSString * invitationcode;

+ (UserInfoModel *)defaultUserInfo;

+ (BOOL)isLogin;
- (void)loginOut;
- (BOOL)loginViewDic:(NSDictionary *)info;

- (NSDictionary *)messageExt;
@end
