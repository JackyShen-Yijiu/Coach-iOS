//
//  InformationMessageModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationMessageModel : NSObject

//{
//    "type": 1,
//    "msg": "",
//    "data": [
//             {
//                 "newsid": "5659a2ba46c2e43423b738d9",
//                 "title": "邢台14岁“驾驶员”超载驾车为“练手”",
//                 "logimg": "http://www.bjjatd.com/images/img05.jpg",
//                 "description": "河北新闻网邢台电(燕赵都市报记者张会武 通讯员王宏屹、崔信行)12月1日上午，一少年无证驾驶两轮摩托车超员载人，并在受到执勤民警查纠时强行闯红灯逃离",
//                 "contenturl": "http://www.bjjatd.com/content.aspx?cateid=12&articleid=20",
//                 "createtime": "2015-11-28T12:48:52.977Z",
//                 "seqindex": 7
//             }

@property (nonatomic, copy) NSString * newsid;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * logimg;

@property (nonatomic, copy) NSString * descriptionString;

@property (nonatomic, copy) NSString * contenturl;

@property (nonatomic, copy) NSString * createtime;

@property (nonatomic, copy) NSString * seqindex;

- (instancetype)initWithDictionary:(id)dictionary;
@end
