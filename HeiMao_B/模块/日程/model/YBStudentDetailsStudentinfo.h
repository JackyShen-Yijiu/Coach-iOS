//
//	YBStudentDetailsStudentinfo.h
//
//	Create by JiangangYang on 30/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBStudentDetailsApplyclasstypeinfo.h"
#import "YBStudentDetailsExaminationinfo.h"
#import "YBStudentDetailsHeadportrait.h"
#import "YBStudentDetailsSubject.h"
#import "YBStudentDetailsSubjectfour.h"
#import "YBStudentDetailsSubjectfour.h"
#import "YBStudentDetailsSubjectfour.h"
#import "YBStudentDetailsSubjectfour.h"

@interface YBStudentDetailsStudentinfo : NSObject

@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) YBStudentDetailsApplyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) YBStudentDetailsExaminationinfo * examinationinfo;
@property (nonatomic, strong) YBStudentDetailsHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) YBStudentDetailsSubject * subject;
@property (nonatomic, strong) YBStudentDetailsSubjectfour * subjectfour;
@property (nonatomic, strong) YBStudentDetailsSubjectfour * subjectone;
@property (nonatomic, strong) YBStudentDetailsSubjectfour * subjectthree;
@property (nonatomic, strong) YBStudentDetailsSubjectfour * subjecttwo;
@property (nonatomic, strong) NSString * userid;

@end