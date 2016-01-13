//
//  InformationMessageModelRootClass.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "InformationMessageModelRootClass.h"
#import "InformationMessageModel.h"

/*
 
 {
 "type": 1,
 "msg": "",
 "data": [
 {
 "newsid": "5662ba7bff55bf30211d58e0",
 "title": "邢台14岁“驾驶员”超载驾车为“练手",
 "logimg": "http://www.bjjatd.com/images/img05.jpg",
 "description": "河北新闻网邢台电(燕赵都市报记者张会武 通讯员王宏屹、崔信行)12月1日上午，一少年无证驾驶两轮摩托车超员载人，并在受到执勤民警查纠时强行闯红灯逃离",
 "contenturl": "http://www.bjjatd.com/content.aspx?cateid=12&articleid=20",
 "createtime": "2015-12-05T10:20:43.092Z",
 "seqindex": 15
 },
 */
@implementation InformationMessageModelRootClass
- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            InformationMessageModel *messageModel = [[InformationMessageModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:messageModel];
        }
        _data = marray;
    }
    return self;
}

@end
