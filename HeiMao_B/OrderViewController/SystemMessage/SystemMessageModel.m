//
//  SystemMessageModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

/*
 
 @property (nonatomic, copy) NSString * _id;
 
 @property (nonatomic, copy) NSString * seqindex;
 
 @property (nonatomic, copy) NSString * __v;
 
 @property (nonatomic, copy) NSString * messagetype;
 
 @property (nonatomic, copy) NSString * is_read;
 
 @property (nonatomic, copy) NSString * detial;
 
 @property (nonatomic, copy) NSString * descriptionStr;
 
 @property (nonatomic, copy) NSString * title;
 
 @property (nonatomic, copy) NSString * userid;
 
 @property (nonatomic, copy) NSString * createtime;

 {
 "type": 1,
 "msg": "",
 "data": [
 {
 "_id": "569752699f8f87583033f161",
 "seqindex": 1,
 "__v": 0,
 "Messagetype": 0,
 "is_read": false,
 "detial": "金额增加通知恭喜您获得1元",
 "description": "恭喜您获得1元",
 "title": "金额增加通知",
 "userid": "5616352721ec29041a9af889",
 "createtime": "2016-01-14T07:46:49.204Z"
 },
 */

#import "SystemMessageModel.h"

@implementation SystemMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _ID = [dictionary objectStringForKey:@"_id"];
        _seqindex = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"seqindex"]];
         _v = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"__v"]];
        _messagetype = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"Messageype"]];
        _detial = [dictionary objectStringForKey:@"detial"];
        _descriptionStr = [dictionary objectStringForKey:@"description"];
        _title = [dictionary objectStringForKey:@"title"];
        _userid = [dictionary objectStringForKey:@"userid"];
        _createtime = [dictionary objectStringForKey:@"createtime"];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
