//
//  YBTrainfieldlinfoModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBTrainfieldlinfoModel.h"

@implementation YBTrainfieldlinfoModel
/*
 "trainfieldlinfo":
 {
 "name": "海淀练场",
 "id": "561636cc21ec29041a9af88e"
 }
 
 */

+ (YBTrainfieldlinfoModel *)converJsonDicToModel:(NSDictionary *)dic{
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    
    YBTrainfieldlinfoModel *model = [[YBTrainfieldlinfoModel alloc] init];
    model.ID = [dic objectForKey:@"id"];
    model.name = [dic objectForKey:@"name"];
    return model;
}

@end
