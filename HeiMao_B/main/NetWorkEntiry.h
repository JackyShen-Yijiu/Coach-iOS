//
//  NetWorkEntiry.h
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ModelDefine.h"


@interface NetWorkEntiry : NSObject

// 发送验证码 GET /userinfo/coachmobileverification
+ (void)newGetSMSCodeWithPhotNUmber:(NSString *)number
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 登陆 POST /userinfo/coachloginbycode
+ (void)newloginWithPhotoNumber:(NSString *)photoNumber code:(NSString *)code
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

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
 *  获取用户信息（1用户 2教练）
 */
+ (void)getUserInfoWithUserInfoWithUserId:(NSString *)userId type:(NSString *)type
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
 */
+ (void)getCourseinfoWithUserId:(NSString *)userId reservationstate:(KCourseStatue)reservationstate pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  预约模块搜索
 *  ====================================================================================================================================
 */
+ (void)getCourseinfoWithUserId:(NSString *)userId reservationstate:(KCourseStatue)reservationstate pageIndex:(NSInteger)pageIndex pageCount:(NSInteger)pageCount searchname:(NSString *)searchname
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  获取教练每天的预约数据
 *
 *  @param userId （req）教练ID
 *  @param dayTime (req）如 2014-5-10格式 NSString 类型
 */
+ (void)getAllCourseInfoWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  获取教练每个月的日程安排
 *
 *  @param userId （req）教练ID
 *  @param yearTime 年
 *  @param monthTime 月
 */
+ (void)getAllCourseInfoWithUserId:(NSString *)userId  yearTime:(NSString *)yearTime monthTime:(NSString *)monthTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  获取教练每天的预约数据
 *
 *  @param userId （req）预约课程ID
 */
+ (void)getCoureDetailInfoWithCouresId:(NSString *)couresId
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  获取科目训练内容
 */
+ (void)getTrainContentSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  获取学员详情信息
 *
 *  @param userId （req）预约课程ID
 */
+ (void)getStudentAllInfoWithStudentId:(NSString *)studentId
                               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 * 教练拒绝（取消）| 接受学员预约
 */
+ (void)postToDealRequestOfCoureseWithCoachid:(NSString *)coachidId
                                    coureseID:(NSString *)courseID
                                    didReject:(BOOL)isRejced
                                 cancelreason:(NSString *)cancelReason
                                cancelcontent:(NSString *)cancelContent
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 * 教练确认学完课程
 */
+ (void)postToEnstureDoneofCourseWithCoachid:(NSString *)coachidId
                                   coureseID:(NSString *)courseID
                             learningcontent:(NSString *)learningcontent
                              contentremarks:(NSString *)contentr
                                  startLevel:(NSInteger)levet
                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  教练提醒学员报考
 *
 *  @param coachidId 教练id
 *  @param userid  学员id
 */

+ (void)postToEnstureExamfCourseWithCoachid:(NSString *)coachidId
                                   userid:(NSString *)userid
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
+ (void)postRecomentWithCoachidId:(NSString *)coachid
                    Reservationid:(NSString *)reservationid
                        starlevel:(CGFloat )starLevel
                        timelevel:(CGFloat)timelevel
                    attitudelevel:(CGFloat)attitudelevel
                     abilitylevel:(CGFloat)abilitylevel
                   commentcontent:(NSString *)commentStr
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
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
                                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  学员签到
 *
 *  @param userId         学员id
 *  @param coachId        教练id
 *  @param reservationId  预约id
 *  @param codeCreateTime 二维码生成时间戳
 *  @param userlatitude   学员纬度
 *  @param userLongitude  学员经度
 *  @param coachLatitude  教练纬度
 *  @param coachLongitude 教练经度
 */
+ (void)studentSignInWithUserId:(NSString *)userId
                        coachId:(NSString *)coachId
                  reservationId:(NSString *)reservationId
                 codeCreateTime:(NSString *)codeCreateTime
                   userLatitude:(NSString *)userlatitude
                  userLongitude:(NSString *)userLongitude
                  coachLatitude:(NSString *)coachLatitude
                 coachLongitude:(NSString *)coachLongitude
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *
 * 获取系统消息和咨询消息数量
 *
 */
+ (void)getMessageUnReadCountlastmessage:(NSString *)lastmessage lastnews:(NSString *)lastnews lastbulletin:(NSString *)lastbulletin
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *
 * 行业资讯调用的接口,
 *
 */
+ (void)getInformationMessageSeqindex:(NSInteger)seqindex withCount:(NSInteger)count
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *
 * 系统消息调用接口,
 *
 */
+ (void)getSystemMessageCoachid:(NSString *)coachid withSeqindex:(NSInteger)seqindex withCount:(NSInteger)count
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *
 * 修改教练工作性质
 *
 */
+ (void)modifyWorkPropertyCoachid:(NSString *)coachid type:(NSInteger)coachtype
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *
 * 修改教练授课班型
 *
 */
+ (void)modifyExamClassCoachid:(NSString *)coachid classtypelist:(NSString *)classtypelist
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 预约
+ (void)postcourseinfoUserreservationcourseWithParams:(NSDictionary *)params
                                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failur;
/**
 *
 * 获取某时间段教练预约列表
 *
 */
+ (void)getAllCourseTimeWithUserId:(NSString *)userId  DayTime:(NSString *)dayTime
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *
 * 教练获取某一节课的课程详情
 *
 */
+ (void)getcoursereservationlistWithUserId:(NSString *)userId  date:(NSString *)date
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/*
 *  获取学员列表
 *
 */
+ (void)coachStudentListWithCoachId:(NSString *)coachId
                        studentType:(NSUInteger)type
                              index:(NSUInteger)index
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/*
 *  学员模块 学员列表 v2 接口
 *
 */
+ (void)coachStudentListWithCoachId:(NSString *)coachId
                          subjectID:(NSString *)subjectID
                          studentID:(NSString *)studentID
                              index:(NSInteger)index
                              count:(NSInteger)count
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;
/**
 *
 * 统计各个状态的学员数量  v2 接口 trainingcontent
 *
 */
+ (void)getAllSubjectNumberStateWithCoachId:(NSString *)coachId
                                  subjectID:(NSString *)subjectID
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;
/**
 *
 * 获取科二科三学习内容  v2 接口 trainingcontent
 *
 */
+ (void)getSubjectTwoAndSubjectThreeContentsuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;

/*
 *  添加学员列表
 *
 */
+ (void)addstudentsListwithCoachid:(NSString *)coachId
                         subjectID:(NSString *)subjectID

                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;


/*
 *  学员详情  courseinfo/getuconfirmcourse
 *
 */
+ (void)getStudentDetailswithuserid:(NSString *)userid
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;

/*
 *  确认学完  courseinfo/getuconfirmcourse v2
 *
 */
+ (void)getCoachOfFinishStudentWihtCoachID:(NSString *)coachid
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;


/**
 *  获取学员的考试信息
 */
+ (void)getExamSummaryInfoDataWihtCoachID:(NSString *)coachid index:(NSUInteger)index count:(NSUInteger)count
                                                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;



/*
 *  通过学员列表  courseinfo/getexamstudentlist v2
 *
 */
+ (void)getPassListStudentWihtCoachID:(NSString *)coachid subjectID:(NSString *)subjectID examDate:(NSString *)examDate examState:(NSString *)examState
                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;

/*
 *  我的界面用户更改手机号  userinfo/updatemobile v1
 *
 */
+ (void)coachChangePhoneNumber:(NSString *)mobile smscode:(NSString *)code userType:(NSInteger)userType
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError * error))failure;


///  获取公告
+ (void)getBulletinWithSchoolId:(NSString *)schoolId withUserId:(NSString *)userId index:(NSUInteger)index count:(NSUInteger)count
                                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
