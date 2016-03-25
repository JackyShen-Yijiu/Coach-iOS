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
// 用户头像
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
//挂靠驾校
@property(nonatomic,strong)NSDictionary *driveschoolinfo;
//训练场地
@property(nonatomic,strong)NSDictionary *trainfieldlinfo;
//班型设置
@property(nonatomic,strong)NSDictionary *carmodel;
//可授科目
@property(nonatomic,strong)NSArray *subject;

@property(nonatomic,assign)BOOL setClassMode;

//请假开始时间
@property(nonatomic,strong)NSString *leavebegintime;
//请假结束时间
@property(nonatomic,strong)NSString * leaveendtime;

@property(nonatomic,strong)NSString *worktimedesc;
@property(nonatomic,strong)NSArray * workweek;
@property(nonatomic,strong)NSString *beginTime;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString * md5Pass;
@property(nonatomic,strong)NSString * invitationcode;
//审核状态
@property(nonatomic,assign)BOOL is_validation;
//工作性质
@property(nonatomic,assign)NSInteger coachtype;
//Y码
@property(nonatomic,assign)NSInteger fcode;
//教龄
@property(nonatomic,assign)NSInteger Seniority;

+ (UserInfoModel *)defaultUserInfo;

+ (BOOL)isLogin;
- (void)loginOut;
- (BOOL)loginViewDic:(NSDictionary *)info;

- (NSDictionary *)messageExt;
@end
