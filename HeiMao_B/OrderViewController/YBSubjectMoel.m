//
//  YBSubjectMoel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBSubjectMoel.h"

@implementation YBSubjectMoel
/*
 "subject":
 
 {
 "subjectid": 2,
 "name": "科目二"
 },
 */

+ (YBSubjectMoel *)converJsonDicToModel:(NSDictionary *)dic{
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
 
    YBSubjectMoel *model = [[YBSubjectMoel alloc] init];
    model.subjectid = [dic objectForKey:@"subjectid"];
    model.name = [dic objectForKey:@"name"];
    return model;
}
@end
