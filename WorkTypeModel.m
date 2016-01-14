//
//  WorkTypeModel.m
//  HeiMao_B
//
//  Created by kequ on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "WorkTypeModel.h"

@implementation WorkTypeModel

+ (NSString *)converTypeToString:(KCourseWorkType)type
{
    switch (type) {
        case KCourseWorkTypeAttached:
            return @"挂靠教练";
            break;
        case KCourseWorkTypeDirect:
            return @"直营教练";
            break;
        default:
            break;
    }
    return @"";
}

+ (KCourseWorkType)converStringToType:(NSString *)type
{
    if ([type isEqualToString:@"挂靠教练"]) {
        return KCourseWorkTypeAttached;
    }
    
    if ([type isEqualToString:@"直营教练"]) {
        return KCourseWorkTypeDirect;
    }
    return -1;
}
@end
