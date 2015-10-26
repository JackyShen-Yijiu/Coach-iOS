//
//  NetWorkEntiry.h
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define KNETBASEURL          @"http://120.25.209.9/f3"


@interface NetWorkEntiry : NSObject

/**
 *  登陆模块
 *  ====================================================================================================================================
 */

/**
 * 发送验证码
 *  @param number （req） 手机号码
 */
+ (void)postSmsCodeWithPhotNUmber:(NSString *)number
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  用户注册接口
 *
 *  @param photoNumber  （req）  手机号
 *  @param password      (req)   密码 MD5加密后
 *  @param smsCode       (req)   短信验证码
 *  @param referrerCode （opt）   邀请码
 */
+ (void)registereWithWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password smsCode:(NSString *)smsCode referrerCode:(NSString *)referrerCode  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  用户教练登录 返回信息描述见 获取用户详情
 *
 *  @param photoNumber （req）  手机号
 *  @param password     (req)  密码 MD5加密后
 */
+ (void)loginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  修改密码
 *
 *  @param photoNumber (req) 手机号
 *  @param password    (req) 密码 MD5加密后
 *  @param smsCode     (req) 短信验证码
 */

+ (void)mofifyWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password smsCode:(NSString *)smsCode
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  个人信息模块
 *  ====================================================================================================================================
 */

/**
 *  通过用户ID获取用户信息 (req)
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  获取驾校训练场
 *
 *  @param schoolId 驾校ID
 */
+ (void)getSchoolTrainFieldWithSchoolId:(NSString *)schoolId
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  用户反馈信息以及bug
 *
 *  @param feedBackMessage （req）反馈内容
 */
+ (void)feedBackWtihFeedBackMessage:(NSString *)feedBackMessage useId:(NSString *)userId
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  预约模块
 *  ====================================================================================================================================
 */

/**
 *  教练获取预约列表信息
 *
 *  @param userId   （req) 教练ID
 *  @param token    （req) 登陆Token
 */
+ (void)getCourseinfoWithUserId:(NSString *)userId pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount token:(NSString *)token
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  获取教练每天的预约数据
 *
 *  @param userId （req）教练ID
 *  @param dayTime (req）如 2014-5-10格式 NSString 类型
 *  @param token   （req) 登陆Token
 */
+ (void)getAllCourseInfoWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime token:(NSString *)token
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  UGC模块
 *  ====================================================================================================================================
 */
/**
 *  获取学员的评论
 *  @param userId  学员ID
 */

+ (void)getAllRecomendWithUserID:(NSString *)userId WithIndex:(NSInteger)pageIndex
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  教练对学员评论
 *
 *  @param coachid       教练id
 *  @param reservationid 学员id
 *  @param starLevel     评论星级
 *  @param commentStr    评论内容
 */
+ (void)postRecomentWithCoachidId:(NSString *)coachid Reservationid:(NSString *)reservationid
                        starlevel:(CGFloat )starLevel commentcontent:(NSString *)commentStr
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
