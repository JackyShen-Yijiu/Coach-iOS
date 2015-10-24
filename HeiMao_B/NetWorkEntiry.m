//
//  NetWorkEntiry.m
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "NetWorkEntiry.h"
#import "JSONKit.h"
#import "NSString+MD5.h"
#import "Reachability.h"

#define  HOST_TEST_DAMIAN @"http://101.200.204.240"
#define  HOST_LINE_DOMAIN @""

#define QA_TEST


@implementation NetWorkEntiry

/**
 *  登陆模块
 *  ====================================================================================================================================
 */

+ (void)postSmsCodeWithPhotNUmber:(NSString *)number
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if(!number){
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlString = [NSString stringWithFormat:@"%@/code/%@",[self domain],number];
    [self GET:urlString parameters:nil success:success failure:failure];
}

+ (void)registereWithWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password smsCode:(NSString *)smsCode referrerCode:(NSString *)referrerCode  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * mdsPass = [password MD5Digest];
    if (!photoNumber || !mdsPass || !smsCode || !referrerCode) {
        return [self missParagramercallBackFailure:failure];
    }
    NSMutableDictionary * dic = [@{@"mobile":photoNumber,
                                   @"password":mdsPass,
                                   @"usertype":@"2"
                                   } mutableCopy];
    if (referrerCode) {
        [dic setObject:referrerCode forKey:@"referrerCode"];
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@//userinfo/signup",[self domain]];
    [self POST:urlStr parameters:dic success:success failure:failure];
}



+ (void)loginWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    
    NSString * md5Pass = [password MD5Digest];
    if (!photoNumber || !md5Pass)  {
        return [self missParagramercallBackFailure:failure];
    };
    NSDictionary * dic = @{@"mobile":photoNumber,
                           @"password":md5Pass,
                           @"usertype":@"2"
                           };
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/userlogin",[self domain]];
    [self POST:urlStr parameters:dic success:success failure:failure];
}


+ (void)mofifyWithPhotoNumber:(NSString *)photoNumber password:(NSString *)password smsCode:(NSString *)smsCode
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * mdsPass = [password MD5Digest];
    if (!photoNumber || !mdsPass || !smsCode) {
        return[self missParagramercallBackFailure:failure];
    }
    NSDictionary * dic = @{
                           @"mobile":photoNumber,
                           @"password":mdsPass,
                           @"usertype":@"2",
                           @"smscode":smsCode
                           };
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/updatepwd",[self domain]];
    [self POST:urlStr parameters:dic success:success failure:failure];
}

/**
 *  个人信息模块
 *  ====================================================================================================================================
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getuserinfo/2/userid/%@",[self domain],userId];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)getSchoolTrainFieldWithSchoolId:(NSString *)schoolId
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!schoolId) {
        [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/getschooltrainingfield",[self domain]];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)feedBackWtihFeedBackMessage:(NSString *)feedBackMessage useId:(NSString *)userId
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!feedBackMessage) {
        return [self missParagramercallBackFailure:failure];
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userfeedback",[self domain]];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    if (userId) {
        [dic setValue:userId forKey:@"userid"];
    }
    //设备版本号
    UIDevice * device = [UIDevice currentDevice];
    NSString * mobileversion = [NSString stringWithFormat:@"%@ %@%@",[device model],[device systemName],[device systemVersion]];
    [dic setValue:mobileversion forKey:@"mobileversion"];
    
    //网络信号
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    AFNetworkReachabilityStatus statue = [manager networkReachabilityStatus];
    NSString * statueStr = [self netWorkStatueStringWithstatus:statue];
    [dic setValue:statueStr forKey:@"network"];
    
    NSString * version =[[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    [dic setValue:version forKey:@"appversion"];
    
    [self POST:urlStr parameters:dic success:success failure:failure];
    
}
    
+ (NSString *)netWorkStatueStringWithstatus:(AFNetworkReachabilityStatus)statue
{
    switch (statue) {
        case AFNetworkReachabilityStatusUnknown:
            return @"未知";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            return @"无网络";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"WWAN";
            break;
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"WiFi";
            break;
        default:
            break;
    }
}

/**
 *  预约模块
 *  ====================================================================================================================================
 */
+ (void)getCourseinfoWithUserId:(NSString *)userId pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount token:(NSString *)token
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !token) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachreservationlist",[self domain]];
    NSDictionary * dic = @{
                            @"coachid":userId,
                            @"index":@(pageIndex),
                            @"authorization":token
                            };
    [self POST:urlStr parameters:dic success:success failure:failure];
}


+ (void)getAllCourseInfoWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime token:(NSString *)token
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !token || !dayTime) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/daysreservationlist",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":userId,
                           @"date":dayTime,
                           @"authorization":token
                           };
    [self POST:urlStr parameters:dic success:success failure:failure];
    
}

/**
 *  UGC模块
 *  ====================================================================================================================================
 */
+ (void)getAllRecomendWithUserID:(NSString *)userId WithIndex:(NSInteger)pageIndex
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (pageIndex <= 0 || !userId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/getusercomment/1/%@/%ld",[self domain],userId,pageIndex];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)postRecomentWithCoachidId:(NSString *)coachid Reservationid:(NSString *)reservationid
                        starlevel:(CGFloat )starLevel commentcontent:(NSString *)commentStr
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!coachid || !reservationid || starLevel < 0 || starLevel > 5 || !commentStr) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * strUrl = [NSString stringWithFormat:@"%@/courseinfo/coachcomment",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":coachid,
                           @"reservationid":reservationid,
                           @"starlevel":@(starLevel),
                           @"commentcontent":commentStr
                           };
    [self POST:strUrl parameters:dic success:success failure:failure];
}

#pragma mark - Common Method

+ (NSString *)domain
{
#ifdef QA_TEST
    return HOST_TEST_DAMIAN;
#else
    return HOST_LINE_DOMAIN;
#endif
}

+ (void)missParagramercallBackFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError * error = [NSError errorWithDomain:@"Deomin" code:0
                                      userInfo:@{@"error":@"缺少参数"}];
    failure(nil,error);
}

+(void)GET:(NSString *)URLString
    parameters:(id)parameters
   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:parameters success:success failure:failure];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:URLString parameters:parameters success:success failure:failure];
}

@end
