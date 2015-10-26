//
//  HMStudentModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMStudentModel.h"

@implementation HMStudentModel
+ (HMStudentModel *)converJsonDicToModel:(NSDictionary *)dic
{
    
    HMStudentModel * model = [[HMStudentModel alloc] init];
    model.userName = @"王星宇";
    model.porInfo = [HMPorTraitModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
//    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
//        return nil;
//    }
//    HMStudentModel * model = [[HMStudentModel alloc] init];
//    model.userId = [dic objectStringForKey:@"_id"];
//    model.userName = [dic objectStringForKey:@"name"];
//    model.porInfo = [HMPorTraitModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
//
    return model;
}
@end
