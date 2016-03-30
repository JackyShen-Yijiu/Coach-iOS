//
//	YBStudentDetailsData.h
//
//	Create by JiangangYang on 30/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBStudentDetailsCoachcommentinfo.h"
#import "YBStudentDetailsStudentinfo.h"

@interface YBStudentDetailsData : NSObject

@property (nonatomic, strong) NSArray * coachcommentinfo;
@property (nonatomic, strong) YBStudentDetailsStudentinfo * studentinfo;
@end