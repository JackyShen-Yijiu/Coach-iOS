//
//  HMClassType.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMClassModel.h"

@implementation HMClassModel
+ (HMClassModel *)converJsonDicToModel:(NSDictionary *)dic
{
    HMClassModel * classType = [[HMClassModel alloc] init];
    classType.classTypeName = @"科目2";
//    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
//        return nil;
//    }
//    HMClassModel * classType = [[HMClassModel alloc] init];
//    classType.classTypeName = [dic objectStringForKey:@"name"];
//    classType.classTypeId = [dic objectStringForKey:@"subjectid"];
    
    return classType;
}
@end
