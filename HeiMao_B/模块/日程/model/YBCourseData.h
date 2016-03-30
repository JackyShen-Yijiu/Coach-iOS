//
//	YBCourseData.h
//
//	Create by JiangangYang on 28/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBCourseCoursereservationdetial.h"
#import "YBCourseCoursetime.h"

@interface YBCourseData : NSObject

@property (nonatomic, strong) NSString * idField;
///  教练id
@property (nonatomic, strong) NSString * coachid;
@property (nonatomic, strong) NSString * coursebegintime;
@property (nonatomic, strong) NSString * coursedate;
@property (nonatomic, strong) NSString * courseendtime;
@property (nonatomic, strong) NSArray * coursereservation;
@property (nonatomic, strong) NSArray * coursereservationdetial;
///  学员数量
@property (nonatomic, assign) NSInteger coursestudentcount;
@property (nonatomic, strong) YBCourseCoursetime * coursetime;
@property (nonatomic, strong) NSArray * courseuser;
@property (nonatomic, strong) NSString * createtime;
@property (nonatomic, strong) NSString * driveschool;
@property (nonatomic, assign) NSInteger selectedstudentcount;
@property (nonatomic, assign) NSInteger signinstudentcount;

@property (nonatomic,assign) CGFloat appointMentViewH;

@end