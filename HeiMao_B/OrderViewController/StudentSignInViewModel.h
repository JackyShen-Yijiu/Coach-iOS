//
//  StudentSignInViewModel.h
//  HeiMao_B
//
//  Created by 大威 on 16/1/12.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface StudentSignInViewModel : DVVBaseViewModel

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
// paramters
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *coachId;
@property (nonatomic, copy) NSString *reservationId;
@property (nonatomic, copy) NSString *codeCreateTime;
@property (nonatomic, copy) NSString *userlatitude;
@property (nonatomic, copy) NSString *userLongitude;
@property (nonatomic, copy) NSString *coachLatitude;
@property (nonatomic, copy) NSString *coachLongitude;

@end
