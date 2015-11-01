//
//  HMClassType.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMClassInfoModel.h"

@implementation HMClassInfoModel
+ (HMClassInfoModel *)converJsonDicToModel:(NSDictionary *)dic
{
//    HMClassInfoModel * classType = [[HMClassInfoModel alloc] init];
//    classType.classTypeName = @"科目2";
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMClassInfoModel * classType = [[HMClassInfoModel alloc] init];
    classType.classTypeName = [dic objectStringForKey:@"name"];
    classType.classTypeId = [dic objectStringForKey:@"subjectid"];
    return classType;
}
@end
