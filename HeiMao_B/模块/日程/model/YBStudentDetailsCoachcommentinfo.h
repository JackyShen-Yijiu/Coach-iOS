//
//	YBStudentDetailsCoachcommentinfo.h
//
//	Create by JiangangYang on 30/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "YBStudentDetailsCoachcomment.h"
#import "YBStudentDetailsCoachid.h"

@interface YBStudentDetailsCoachcommentinfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) YBStudentDetailsCoachcomment * coachcomment;
@property (nonatomic, strong) YBStudentDetailsCoachid * coachid;
@property (nonatomic, strong) NSString * finishtime;
@property (nonatomic, assign) NSInteger timestamp;
@end