//
//  HMSchoolModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMSchoolInfoModel.h"

@implementation HMSchoolInfoModel

+ (HMSchoolInfoModel *)converJsonDicToModel:(NSDictionary *)dic
{
    
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMSchoolInfoModel * schoolInfo = [[HMSchoolInfoModel alloc] init];
    schoolInfo.schoolId = [dic objectStringForKey:@"id"];
    schoolInfo.schoolName = [dic objectStringForKey:@"name"];
    return schoolInfo;
}

@end