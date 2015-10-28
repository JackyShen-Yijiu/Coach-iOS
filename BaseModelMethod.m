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
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0;i < 20;i++) {
        HMCourseModel * courseModel = [HMCourseModel converJsonDicToModel:nil];
        courseModel.courseStatue = i % 7;
        if (courseModel) {
            [oArray addObject:courseModel];
        }
    }
    return [oArray copy];

//    if (![array isKindOfClass:[NSArray class]] || !array.count) {
//        return nil;
//    }
//    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary * info in array) {
//        HMcourseModel * courseModel = [HMcourseModel converJsonDicToModel:info];
//        if (courseModel) {
//            [oArray addObject:courseModel];
//        }
//    }
//    return [oArray copy];
}

+ (NSArray *)getRecomendListArrayFormDicInfo:(NSArray *)array
{
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0;i < 20;i++) {
        HMRecomendModel * recomendModel = [HMRecomendModel converJsonDicToModel:nil];
        if (recomendModel) {
            [oArray addObject:recomendModel];
        }
    }
    return [oArray copy];
}

@end
