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
    NSString * urlString = [NSString stringWithFormat:@"%@/code/%@",HOST_TEST_DAMIAN,number];
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
    
    NSString * urlStr = [NSString stringWithFormat:@"%@//userinfo/signup",HOST_TEST_DAMIAN];
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
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/userlogin",HOST_TEST_DAMIAN];
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
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/updatepwd",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getuserinfo/%@/userid/%@",HOST_TEST_DAMIAN,type,userId];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)getSchoolTrainFieldWithSchoolId:(NSString *)schoolId
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!schoolId) {
        [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/getschooltrainingfield",HOST_TEST_DAMIAN];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

+ (void)feedBackWtihFeedBackMessage:(NSString *)feedBackMessage useId:(NSString *)userId
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!feedBackMessage) {
        return [self missParagramercallBackFailure:failure];
    }
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userfeedback",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachreservationlist",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/searchreservationlist",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/getmonthapplydata",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/daysreservationlist",HOST_TEST_DAMIAN];
    NSDictionary * dic = @{
                           @"coachid":userId,
                           @"date":dayTime,
                           };
    [self GET:urlStr parameters:dic success:success failure:failure];
    
}
+ (void)getcoursereservationlistWithUserId:(NSString *)userId  date:(NSString *)date
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !date) {
        return [self missParagramercallBackFailure:failure];
    }
    
    // http://127.0.0.1:8183/api/v2/courseinfo/daytimelysreservation?coachid=5666365ef14c20d07ffa6ae8&date=2016-03-25
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/daytimelysreservation?coachid=%@&date=%@",HOST_LINE_DOMAIN,userId,date];
    
    [self GET:urlStr parameters:nil success:success failure:failure];
    
}
+ (void)getAllCourseTimeWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!userId || !dayTime) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/getcoursebycoach?coachid=%@&date=%@",HOST_TEST_DAMIAN,userId,dayTime];

    [self GET:urlStr parameters:nil success:success failure:failure];
    
}
+ (void)getCoureDetailInfoWithCouresId:(NSString *)couresId
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!couresId) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/reservationinfo/%@",HOST_TEST_DAMIAN,couresId];
    [self GET:urlStr parameters:nil success:success failure:failure];
}

/**
 *  获取科目训练内容
 */
+ (void)getTrainContentSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString * urlStr = [NSString stringWithFormat:@"%@/trainingcontent",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/studentinfo",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachhandleinfo",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/coachcommentv2",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/remindexam",HOST_TEST_DAMIAN];
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/getusercomment/1/%@/%ld",HOST_TEST_DAMIAN,userId,pageIndex];
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
    NSString * strUrl = [NSString stringWithFormat:@"%@/courseinfo/coachcomment",HOST_TEST_DAMIAN];
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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/userinfo/buyproduct",HOST_TEST_DAMIAN];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"2"forKey:@"usertype"];
    [dic setValue:userid forKey:@"userid"];
    [dic setValue:name forKey:@"name"];
    [dic setValue:mobile forKey:@"mobile"];
    [dic setValue:productid forKey:@"productid"];
    [dic setValue:address forKey:@"address"];
    
    [self POST:urlStr parameters:dic success:success failure:failure];
    
}

// 预约
+ (void)postcourseinfoUserreservationcourseWithParams:(NSDictionary *)params
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!params) {
        return [self missParagramercallBackFailure:failure];
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@/courseinfo/userreservationcourse",HOST_TEST_DAMIAN];
    
    [self POST:urlStr parameters:params success:success failure:failure];
    
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
   
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getmessagecount",HOST_TEST_DAMIAN];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[UserInfoModel defaultUserInfo].userID forKey:@"coachid"];

    [dic setValue:lastmessage forKey:@"lastmessage"];
    [dic setValue:lastnews forKey:@"lastnews"];
    NSLog(@"dic:%@",dic);
    
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
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getnews?seqindex=%li&count=%ld",HOST_TEST_DAMIAN,seqindex,count];
    
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
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/getsysteminfo?coachid=%@&index=%lu&count=%lu",HOST_TEST_DAMIAN,coachid,seqindex,count];
    
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
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/updatecoachinfo",HOST_TEST_DAMIAN];
   
    NSMutableDictionary*dict = [NSMutableDictionary dictionary];
    dict[@"coachid"] = coachid;
    dict[@"coachtype"] = @(coachtype);
    
    [self POST:urlStr parameters:dict success:success failure:failure];
}
/**
 *
 * 修改教练授课班型
 *
 */
+ (void)modifyExamClassCoachid:(NSString *)coachid classtypelist:(NSString *)classtypelist
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@/userinfo/coachsetclass",HOST_TEST_DAMIAN];
    
    NSMutableDictionary*dict = [NSMutableDictionary dictionary];
    dict[@"coachid"] = coachid;
    dict[@"classtypelist"] = classtypelist;
    
    [self POST:urlStr parameters:dict success:success failure:failure];
}

/**
 *
 * 学员模块学员列表  v2 接口  courseinfo/getmystudentcount
 *
 */
+ (void)coachStudentListWithCoachId:(NSString *)coachId
                          subjectID:(NSString *)subjectID
                          studentID:(NSString *)studentID
                              index:(NSInteger)index
                              count:(NSInteger)count
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/getmystudentlist",HOST_LINE_DOMAIN];
    NSDictionary *paramterDict = @{ @"coachid": coachId,
                                    @"subjectid": subjectID,
                                    @"studentstate":subjectID,
                                    @"count": [NSString stringWithFormat:@"%lu", count],
                                    @"index": [NSString stringWithFormat:@"%lu", index]
                                    };
    NSLog(@"urlStr = urlStr %@",urlStr);
    NSLog(@"paramterDict = %@",paramterDict);
    [self GET:urlStr parameters:paramterDict success:success failure:failure];
}

/**
 *
 * 统计各个状态的学员数量  v2 接口
 *
 */
+ (void)getAllSubjectNumberStateWithCoachId:(NSString *)coachId
                          subjectID:(NSString *)subjectID
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/getmystudentcount",HOST_LINE_DOMAIN];
    NSDictionary *paramterDict = @{ @"coachid": coachId,
                                    @"subjectid": subjectID,
                                    
                                    };
    NSLog(@"urlStr = urlStr %@",urlStr);
    NSLog(@"paramterDict = %@",paramterDict);
    [self GET:urlStr parameters:paramterDict success:success failure:failure];
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
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/coursesignin",HOST_TEST_DAMIAN];
    
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

+ (void)coachStudentListWithCoachId:(NSString *)coachId
                        studentType:(NSUInteger)type
                              index:(NSUInteger)index
                            success:(void (^)(AFHTTPRequestOperation *, id))success
                            failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@/userinfo/coachstudentlist",HOST_TEST_DAMIAN];
    NSDictionary *paramterDict = @{ @"coachid": coachId,
                                    @"studenttype": [NSString stringWithFormat:@"%zd", type],
                                    @"index": [NSString stringWithFormat:@"%zd", index] };
    [self GET:urlStr parameters:paramterDict success:success failure:failure];
}
// 添加学员列表
+ (void)addstudentsListwithCoachid:(NSString *)coachId
                         subjectID:(NSString *)subjectID

                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/getureservationuserlist",HOST_LINE_DOMAIN];
    NSDictionary *paramterDict = @{ @"coachid": coachId,
                                    @"subjectid": subjectID
                                   };
//    NSLog(@"urlStr = %@",urlStr);
//    NSLog(@"paramterDict = %@",paramterDict);
    [self GET:urlStr parameters:paramterDict success:success failure:failure];
}

/*
 *  学员详情
 *
 */
+ (void)getStudentDetailswithuserid:(NSString *)userid
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure
{
    NSString *url = [NSString stringWithFormat:@"http://jzapi.yibuxueche.com/api/v2/courseinfo/studentdetialinfo?userid=%@",userid];
    
    [self GET:url parameters:nil success:success failure:failure];
}

/**
 *
 * 获取科二科三学习内容  v2 接口
 *
 */
+ (void)getSubjectTwoAndSubjectThreeContentsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/trainingcontent",HOST_TEST_DAMIAN];
    [self GET:urlStr parameters:nil success:success failure:failure];
    
}
/*
 *  确认学完  courseinfo/getuconfirmcourse v2
 *
 */
+ (void)getCoachOfFinishStudentWihtCoachID:(NSString *)coachid
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure{
    NSString *url = [NSString stringWithFormat:@"http://jzapi.yibuxueche.com/api/v2/courseinfo/getuconfirmcourse?coachid=%@",coachid];
//    http://jzapi.yibuxueche.com/api/v2/courseinfo/getuconfirmcourse?coachid=5666365ef14c20d07ffa6ae8
    [self GET:url parameters:nil success:success failure:failure];
    
}
/*
 *  通过学员列表  courseinfo/getexamstudentlist v2
 *
 */
+ (void)getPassListStudentWihtCoachID:(NSString *)coachid subjectID:(NSString *)subjectID examDate:(NSString *)examDate examState:(NSString *)examState
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%@/courseinfo/getexamstudentlist",HOST_LINE_DOMAIN];
    NSDictionary *paramterDict = @{ @"coachid": coachid,
                                    @"subjectid": subjectID,
                                    @"examdate":examDate,
                                    @"examstate":examState
                                    };
    [self GET:urlStr parameters:paramterDict success:success failure:failure];

    
}








#pragma mark - 获取学员的考试信息
+ (void)getExamSummaryInfoDataWihtCoachID:(NSString *)coachid index:(NSUInteger)index count:(NSUInteger)count
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure {
    
    NSString *url = @"http://jzapi.yibuxueche.com/api/v2/courseinfo/getexamsummaryinfo";
    
    NSDictionary *paramterDict = @{ @"coachid": coachid,
                                    @"index":[NSString stringWithFormat:@"%zd",index],
                                    @"count":[NSString stringWithFormat:@"%zd",count]
                                    };
    
    [self GET:url parameters:paramterDict success:success failure:failure];

    
    
}


#pragma mark - Common Method

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
