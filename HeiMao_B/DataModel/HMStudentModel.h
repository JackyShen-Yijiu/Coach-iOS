//
//  HMStudentModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSchoolInfoModel.h"
#import "HMClassInfoModel.h"
#import "HMPortraitInfoModel.h"
#import "HMCarLicenseModel.h"
#import "HMSubjectModel.h"

@interface HMStudentModel : NSObject
//用户信息
@property(nonatomic,strong)NSString * userId;
@property(nonatomic,strong)NSString * disPlayId;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)NSString * telPhoto;
@property(nonatomic,strong)HMPortraitInfoModel * porInfo;
//学车信息
@property(nonatomic,strong)HMSchoolInfoModel * schoolInfo;  //报考驾校
@property(nonatomic,strong)HMCarLicenseModel * carLicenseInfo;       //车型    C1本
@property(nonatomic,strong)NSString * courseSchedule;       //课程进度 科目二第16学时
@property(nonatomic,strong)NSString * commmonAddress;       //常用地址 北京市昌平区天通苑

//评论信息
@property(nonatomic,strong)NSMutableArray * recommendArrays;


/*
 * v1.1.0添加剩余多少课时，漏课统计
 */
@property(nonatomic,assign)NSInteger leavecoursecount;
@property(nonatomic,assign)NSInteger missingcoursecount;
@property(nonatomic,strong)HMSubjectModel* subjectInfo;
+ (HMStudentModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
