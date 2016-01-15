//
//  PersonlizeModel.m
//  HeiMao_B
//
//  Created by 胡东苑 on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "PersonlizeModel.h"

@implementation PersonlizeModel

+ (PersonlizeModel *)converJsonDicToModel:(NSDictionary *)dic
{

    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    
    PersonlizeModel * pm = [[PersonlizeModel alloc] init];
    pm._id =        [dic objectStringForKey:@"_id"];
    pm.tagname =    [dic objectStringForKey:@"tagname"];
    pm.tagtype =    [NSString stringWithFormat:@"%@",dic[@"tagtype"]];
    pm.is_audit =   [NSString stringWithFormat:@"%@",dic[@"is_audit"]];
    pm.is_choose =  [NSString stringWithFormat:@"%@",dic[@"is_choose"]];
    return pm;
}

@end
