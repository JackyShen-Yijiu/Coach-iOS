//
//  HMSchoolModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMSchoolModel.h"

@implementation HMSchoolModel

+ (HMSchoolModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMSchoolModel * classType = [[HMSchoolModel alloc] init];
    classType.schoolName = [dic objectStringForKey:@"id"];
    classType.schoolId = [dic objectStringForKey:@"name"];
    return classType;
}


@end
