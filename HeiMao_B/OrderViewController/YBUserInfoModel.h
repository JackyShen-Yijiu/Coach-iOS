//
//  YBUserInfoModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBUserInfoModel : NSObject
/*
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

 */
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *thumbnailpic;
@property (nonatomic, strong) NSString *originalpic;
@property (nonatomic, strong) NSString *name;

+ (YBUserInfoModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
