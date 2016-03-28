//
//	YBCourseCoursereservationdetial.h
//
//	Create by JiangangYang on 28/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBCourseSubject.h"
#import "YBCourseUserid.h"

@interface YBCourseCoursereservationdetial : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * begintime;
@property (nonatomic, strong) NSString * courseprocessdesc;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, strong) NSString * reservationcreatetime;
@property (nonatomic, assign) NSInteger reservationstate;
@property (nonatomic, strong) YBCourseSubject * subject;
@property (nonatomic, strong) YBCourseUserid * userid;
@end