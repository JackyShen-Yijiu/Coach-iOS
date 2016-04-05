//
//	YBStudentDetailsSubjectfour.h
//
//	Create by JiangangYang on 30/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface YBStudentDetailsSubjectfour : NSObject

@property (nonatomic, assign) NSInteger examinationresult;
@property (nonatomic, strong) NSString * examinationresultdesc;

@property (nonatomic, assign) NSInteger testcount;
@property (nonatomic, strong) NSString * examinationdate;
@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) NSString * progress;

@property (nonatomic, assign) NSInteger totalcourse;
@property (nonatomic, assign) NSInteger reservation;
@property (nonatomic, assign) NSInteger finishcourse;
@property (nonatomic, assign) NSInteger missingcourse;
@property (nonatomic, assign) NSInteger officialhours;
@property (nonatomic, assign) NSInteger officialfinishhours;

@end
//
//        "totalcourse": 24,// 规定
//        "reservation": 0,// 预约中
//        "finishcourse": 0,// 完成
//        "missingcourse": 0,// 漏课
//        "progress": "未开始",
//        "officialhours": 0,// 官方总课时
//        "officialfinishhours": 0// 官方完成
//