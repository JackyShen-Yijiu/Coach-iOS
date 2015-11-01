//
//  BaseModelMethod.m
//  JewelryApp
//
//  Created by kequ on 15/5/17.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "BaseModelMethod.h"
#import "HMCourseModel.h"
#import "HMRecomendModel.h"

@implementation BaseModelMethod

+ (NSArray *)getCourseListArrayFormDicInfo:(NSArray *)array
{
  
    if (![array isKindOfClass:[NSArray class]] || !array.count) {
        return nil;
    }
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * info in array) {
        HMCourseModel * courseModel = [HMCourseModel converJsonDicToModel:info];
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];
}

+ (NSArray *)getRecomendListArrayFormDicInfo:(NSArray *)array
{
    if (![array isKindOfClass:[NSArray class]] || !array.count) {
        return nil;
    }
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary * info in array) {
        HMRecomendModel * courseModel = [HMRecomendModel converJsonDicToModel:info];
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];
}

@end
