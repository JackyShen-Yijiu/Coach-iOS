//
//  YBUserInfoModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBUserInfoModel.h"
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
 mobile = 139110516852;
 },
 
 */




@implementation YBUserInfoModel

+ (YBUserInfoModel *)converJsonDicToModel:(NSDictionary *)dic{
    
if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
    return nil;
}
    YBUserInfoModel *model = [[YBUserInfoModel alloc] init];
    model._id = [dic objectForKey:@"_id"];
    model.name = [dic objectForKey:@"name"];
    model.mobile = [dic objectForKey:@"mobile"];
    NSArray *keyArry = [dic allKeys];
    if (!keyArry || ![keyArry isKindOfClass:[NSArray class]] ||!keyArry.count) {
        return nil;
    }
    for (NSString *keystr in keyArry) {
        if ([keystr isEqualToString:@"headportrait"]) {
            NSDictionary *dictionary = [dic objectForKey:@"headportrait"];
            model.height = [dictionary objectForKey:@"height"];
            model.width = [dictionary objectForKey:@"width"];
            model.thumbnailpic = [dictionary objectForKey:@"thumbnailpic"];
            model.originalpic = [dictionary objectForKey:@"originalpic"];
            
        }
    }

    return model;
    
}
@end
