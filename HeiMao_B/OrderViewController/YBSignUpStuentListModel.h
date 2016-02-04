//
//  YBSignUpStuentListModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBUserInfoModel.h"
#import "YBSubjectMoel.h"
#import "YBTrainfieldlinfoModel.h"

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

@interface YBSignUpStuentListModel : NSObject

@property (nonatomic, strong) YBUserInfoModel *userInfooModel;

@property (nonatomic, assign) NSNumber * reservationstate;

@property (nonatomic, copy) NSString * reservationcreatetime;

@property (nonatomic, strong) YBSubjectMoel *subjectModel;

@property (nonatomic, assign) BOOL  is_shuttle;

@property (nonatomic, copy) NSString * shuttleaddress;

@property (nonatomic, copy) NSString * courseprocessdesc;

@property (nonatomic, copy) NSString * classdatetimedesc;

@property (nonatomic, strong) YBTrainfieldlinfoModel *trainfieldlinfoModel;

 - (instancetype)initWithDictionary:(id)dictionary;
@end
