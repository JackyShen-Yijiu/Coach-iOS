//
//  YBSignUpStuentListModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBSignUpStuentListModel.h"
/*
 {
 "type": 1,
 "msg": "",
 
 "data": [
 {
 
 "userid":
 
 {
 "_id": "5611292a193184140355c49a",
 "headportrait":
 
 {
 "height": "",
 "width": "",
 "thumbnailpic": "",
 "originalpic": ""
 },
 
 "name": "nimenhao"
 },
 
 "reservationstate": 1,
 "reservationcreatetime": "2015-10-24T12:39:34.044Z",
 "subject":
 
 {
 "subjectid": 2,
 "name": "科目二"
 },
 "is_shuttle": true,
 "shuttleaddress": "北京市",
 "courseprocessdesc": "科目二 第7-8学时",
 "classdatetimedesc": "2015年11月01日 04:00--05:00",
 "trainfieldlinfo":
 {
 "name": "海淀练场",
 "id": "561636cc21ec29041a9af88e"
 }
 
 }
 ]
 
 
 }
 */


@implementation YBSignUpStuentListModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]] ||![dictionary allKeys].count) {
        return nil;
    }
    self = [super init];
    if (self) {
        _userInfooModel = [YBUserInfoModel converJsonDicToModel:[dictionary objectForKey:@"userid"]];
        _reservationstate =[dictionary objectForKey:@"reservationstate"];
        _reservationcreatetime = [dictionary objectForKey:@"reservationcreatetime"];
        _subjectModel = [YBSubjectMoel converJsonDicToModel:[dictionary objectForKey:@"dictionary"]];
        _is_shuttle =[dictionary objectStringForKey:@"is_shuttle"];
        _shuttleaddress = [dictionary objectStringForKey:@"shuttleaddress"];
        _courseprocessdesc = [dictionary objectStringForKey:@"courseprocessdesc"];
        _classdatetimedesc = [dictionary objectStringForKey:@"classdatetimedesc"];
        _trainfieldlinfoModel = [YBTrainfieldlinfoModel converJsonDicToModel:[dictionary objectForKey:@"trainfieldlinfo"]];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
