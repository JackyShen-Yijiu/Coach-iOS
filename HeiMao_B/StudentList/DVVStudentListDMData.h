//
//  DVVStudentListDMData.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVStudentListDMHeadPortrait.h"
#import "DVVStudentListDMSubject.h"
#import "YYModel.h"

@interface DVVStudentListDMData : NSObject<YYModel>
//{
//    "_id" = 5677bf31d1aab0e330a6ef98;
//    headportrait =             {
//        height = "";
//        originalpic = "";
//        thumbnailpic = "";
//        width = "";
//    };
//    leavecoursecount = 0;
//    missingcoursecount = 0;
//    mobile = 15110109598;
//    name = "\U80e1\U4e1c\U82d1";
//    subject =             {
//        name = "\U65b0\U624b\U4e0a\U8def";
//        subjectid = 5;
//    };
//    subjectprocess = "";
//}

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) DVVStudentListDMHeadPortrait *headportrait;
@property (nonatomic, assign) NSInteger leavecoursecount;
@property (nonatomic, assign) NSInteger missingcoursecount;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) DVVStudentListDMSubject *subject;
@property (nonatomic, copy) NSString *subjectprocess;

@end
