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
#define KNETBASEURL

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
                                   @"usertype":@"2",
                                   @"smscode":smsCode
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
 *  获取用户信息（1用户 2教练）
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId type:(NSString *)type
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getuserinfo/%@/userid/%@",[self domain],type,userId];
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
+ (void)getCourseinfoWithUserId:(NSString *)userId reservationstate:(KCourseStatue)reservationstate pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachreservationlist",[self domain]];
    NSDictionary * dic = @{
                            @"coachid":userId,
                            @"index":@(pageIndex),
                            @"reservationstate":@(reservationstate),
                            };
    [self GET:urlStr parameters:dic success:success failure:failure];
}
/**
 *  预约模块搜索
 *  ====================================================================================================================================
 */
+ (void)getCourseinfoWithUserId:(NSString *)userId reservationstate:(KCourseStatue)reservationstate pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount searchname:(NSString *)searchname
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/searchreservationlist",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":userId,
                           @"index":@(pageIndex),
                           @"reservationstate":@(reservationstate),
                           @"searchname":searchname,
                           };
    [self GET:urlStr parameters:dic success:success failure:failure];
}

/**
 *  获取教练每个月的日程安排
 *
 *  @param userId （req）教练ID
 *  @param yearTime 年
 *  @param monthTime 月
 */
+ (void)getAllCourseInfoWithUserId:(NSString *)userId  yearTime:(NSString *)yearTime monthTime:(NSString *)monthTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !yearTime || !monthTime) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/getmonthapplydata",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":userId,
                           @"year":yearTime,
                           @"month":monthTime,
                           };
    [self GET:urlStr parameters:dic success:success failure:failure];
    
}

+ (void)getAllCourseInfoWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !dayTime) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/daysreservationlist",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":userId,
                           @"date":dayTime,
                           };
    [self GET:urlStr parameters:dic success:success failure:failure];
    
}

+ (void)getCoureDetailInfoWithCouresId:(NSString *)couresId
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!couresId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/reservationinfo/%@",[self domain],couresId];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

/**
 *  获取科目训练内容
 */
+ (void)getTrainContentSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trainingcontent",[self domain]];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)getStudentAllInfoWithStudentId:(NSString *)studentId
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if(!studentId){
        return [self missParagramercallBackFailure:failure];
    }
    NSDictionary * dic = @{
                           @"userid":studentId,
                           };
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/studentinfo",[self domain]];
    [self GET:urlStr parameters:dic success:success failure:failure];
}

+ (void)postToDealRequestOfCoureseWithCoachid:(NSString *)coachidId
                                    coureseID:(NSString *)courseID
                                    didReject:(BOOL)isRejced
                                 cancelreason:(NSString *)cancelReason
                                cancelcontent:(NSString *)cancelContent
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if(!coachidId || !courseID){
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachhandleinfo",[self domain]];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:coachidId forKey:@"coachid"];
    [dic setValue:courseID forKey:@"reservationid"];
    if (isRejced) {
        [dic setValue:@"4" forKey:@"handletype"];
    }else{
        [dic setValue:@"3" forKey:@"handletype"];
    }
    if (cancelReason) {
        [dic setValue:cancelReason forKey:@"cancelreason"];
    }
    if (cancelContent) {
        [dic setValue:cancelContent forKey:@"cancelcontent"];
    }
    [self POST:urlStr parameters:dic success:success failure:failure];
}

+ (void)postToEnstureDoneofCourseWithCoachid:(NSString *)coachidId
                                   coureseID:(NSString *)courseID
                             learningcontent:(NSString *)learningcontent
                              contentremarks:(NSString *)contentr
                                  startLevel:(NSInteger)levet
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if(!coachidId || !courseID){
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachcommentv2",[self domain]];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:coachidId forKey:@"coachid"];
    [dic setValue:courseID forKey:@"reservationid"];
    if (learningcontent) {
        [dic setValue:learningcontent forKey:@"learningcontent"];
    }
    if (contentr) {
        [dic setValue:contentr forKey:@"commentcontent"];
    }
    [dic setValue:@(levet) forKey:@"starlevel"];
    [self POST:urlStr parameters:dic success:success failure:failure];
}

/**
 *  教练提醒学员报考
 *
 *  @param coachidId 教练id
 *  @param userid  学员id
 */

+ (void)postToEnstureExamfCourseWithCoachid:(NSString *)coachidId
                                     userid:(NSString *)userid
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if(!coachidId || !userid){
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/remindexam",[self domain]];
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [dic setValue:coachidId forKey:@"coachid"];
    [dic setValue:userid forKey:@"userid"];
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

+ (void)postRecomentWithCoachidId:(NSString *)coachid
                    Reservationid:(NSString *)reservationid
                        starlevel:(CGFloat )starLevel
                        timelevel:(CGFloat)timelevel
                    attitudelevel:(CGFloat)attitudelevel
                     abilitylevel:(CGFloat)abilitylevel
                   commentcontent:(NSString *)commentStr
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!coachid || !reservationid) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * strUrl = [NSString stringWithFormat:@"%@/courseinfo/coachcomment",[self domain]];
    NSDictionary * dic = @{
                           @"coachid":coachid,
                           @"reservationid":reservationid,
                           @"starlevel":@(starLevel),
                           @"timelevel":@(timelevel),
                           @"attitudelevel":@(attitudelevel),
                           @"abilitylevel":@(abilitylevel),
                           };
    NSMutableDictionary * dicInfo = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (commentStr) {
        [dicInfo setValue:commentStr forKey:@"commentcontent"];
    }else{
        [dicInfo setValue:@"" forKey:@"commentcontent"];
    }
    [self POST:strUrl parameters:dicInfo success:success failure:failure];
}
/**
 *
 * 点击购买调用的接口,
 *
 */

+ (void)postToDidClickButtonByPurchaseWithUseID:(NSString *)userid
                                      productid:(NSString *)productid
                                           name:(NSString *)name
                                         mobile:(NSString *)mobile
                                        address:(NSString *)address
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/userinfo/buyproduct",[self domain]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"2"forKey:@"usertype"];
    [dic setValue:userid forKey:@"userid"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:productid forKey:@"productid"];
    [dic setValue:address forKey:@"address"];
    
    
    
    [self POST:urlStr parameters:dic success:success failure:failure];
    
}
/**
 *
 * 获取系统消息和咨询消息数量
 *
 */
+ (void)getMessageUnReadCountlastmessage:(NSString *)lastmessage lastnews:(NSString*)lastnews
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
   
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getmessagecount",[self domain]];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:lastmessage forKey:@"lastmessage"];
    [dic setValue:lastnews forKey:@"lastnews"];
    
    [self GET:urlStr parameters:dic success:success failure:failure];
}
/**
 *
 * 行业资讯调用的接口,
 *
 */
+ (void)getInformationMessageSeqindex:(NSInteger)seqindex withCount:(NSInteger)count
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (count < 0 || seqindex < 0) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getnews?seqindex=%li&count=%ld",[self domain],seqindex,count];
    
    [self GET:urlStr parameters:nil success:success failure:failure];
}
/**
 *
 * 系统消息调用接口
 *
 */
+ (void)getSystemMessageCoachid:(NSString *)coachid withSeqindex:(NSInteger)seqindex withCount:(NSInteger)count
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (count <= 0 || seqindex <= 0) {
        return [self missParagramercallBackFailure:failure];
    }
    
//    http://101.200.204.240:8181/api/v1/userinfo/getsysteminfo?coachid=5616352721ec29041a9af889&index=1&count=10
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getsysteminfo?coachid=%@&index=%lu&count=%lu",[self domain],coachid,seqindex,count];
    
    [self GET:urlStr parameters:nil success:success failure:failure];
}

/**
 *
 * 修改教练工作性质
 *
 */
+ (void)modifyWorkPropertyCoachid:(NSString *)coachid type:(NSInteger)coachtype
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/updatecoachinfo",[self domain]];
   
    NSMutableDictionary*dict = [NSMutableDictionary dictionary];
    dict[@"coachid"] = coachid;
    dict[@"coachtype"] = @(coachtype);
    
    [self POST:urlStr parameters:dict success:success failure:failure];
}
#pragma mark 学员签到
+ (void)studentSignInWithUserId:(NSString *)userId
                        coachId:(NSString *)coachId
                  reservationId:(NSString *)reservationId
                 codeCreateTime:(NSString *)codeCreateTime
                   userLatitude:(NSString *)userLatitude
                  userLongitude:(NSString *)userLongitude
                  coachLatitude:(NSString *)coachLatitude
                 coachLongitude:(NSString *)coachLongitude
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/coursesignin",[self domain]];
    
    //    {
    //        "userid": "String,学员id",
    //        "coachid": "String,教练id",
    //        "reservationid": "string,预约id",
    //        "codecreatetime": "String,二维码生成时间戳",
    //        "userlatitude": "Number,学员纬度",
    //        "userlongitude": "Number,学员精度",
    //        "coachlatitude": "Number,教练纬度",
    //        "coachlongitude": "Number,教练经度"
    //    }
    NSDictionary *paramtersDict = @{ @"userid": userId,
                                     @"coachid": coachId,
                                     @"reservationid": reservationId,
                                     @"codecreatetime": codeCreateTime,
                                     @"userlatitude": userLatitude,
                                     @"userlongitude": userLongitude,
                                     @"coachlatitude": coachLatitude,
                                     @"coachlongitude": coachLongitude };
    
    [self POST:urlStr parameters:paramtersDict success:success failure:failure];
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
    [self addCommonValueInHead:manager];
    [manager GET:URLString parameters:parameters success:success failure:failure];
}

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addCommonValueInHead:manager];
    [manager POST:URLString parameters:parameters success:success failure:failure];
}

+ (void)addCommonValueInHead:(AFHTTPRequestOperationManager *)manager
{
    NSString *   token = [[UserInfoModel defaultUserInfo] token];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"authorization"];
}

@end
