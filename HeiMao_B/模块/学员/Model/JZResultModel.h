//
//  JZResultModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/29.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Applyclasstypeinfo.h"
#import "Courseinfo.h"
#import "Headportrait.h"
#import "Subject.h"


@interface JZResultModel : NSObject
/*
 {
 "userid": "56e6341394aaa86c3244d9a1",
 "name": "李亚飞",
 "mobile": "15652305650",
 "headportrait": {
 "originalpic": "",
 "thumbnailpic": "",
 "width": "",
 "height": ""
 },
 "applyclasstypeinfo": {
 "price": 1,
 "onsaleprice": 1,
 "name": "测试班型 跳楼价",
 "id": "56aecf9b70667d997fda6247"
 },
 "subject": {
 "subjectid": 1,
 "name": "科目一"
 },
 "courseinfo": {
 "totalcourse": 24,
 "buycoursecount": 0,
 "reservation": 0,
 "finishcourse": 0,
 "missingcourse": 0,
 "progress": "未开始",
 "officialhours": 1773,
 "officialfinishhours": 1773
 },
 "examinationdate": "2016-03-29T02:44:05.898Z",
 "applydate": "2016-03-29T02:44:05.898Z",
 "applyenddate": "2016-03-29T02:44:05.898Z",
 "testcount": 0
 }
 ]
 */
@property (nonatomic, strong) Applyclasstypeinfo * applyclasstypeinfo;
@property (nonatomic, strong) NSString * applydate;
@property (nonatomic, strong) NSString * applyenddate;
@property (nonatomic, strong) Courseinfo * courseinfo;
@property (nonatomic, strong) NSString * examinationdate;
@property (nonatomic, strong) Headportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) Subject * subject;
@property (nonatomic, assign) NSInteger testcount;
@property (nonatomic, strong) NSString * userid;





@end
