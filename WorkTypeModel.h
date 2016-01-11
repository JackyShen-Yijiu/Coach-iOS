//
//  WorkTypeModel.h
//  HeiMao_B
//
//  Created by kequ on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *v1.1.0
 *注册后填写信息加入工作性质：挂靠教练/直营教练
 */


typedef NS_ENUM(NSInteger,KCourseWorkType) {
    KCourseWorkTypeAttached,    //挂靠教练
    KCourseWorkTypeDirect,      //直营教练
    KCourseWorkTypeCount
};

@interface WorkTypeModel : NSObject

@property(nonatomic,strong)NSString * name;
@property(nonatomic,assign)KCourseWorkType  type;

+ (NSString *)converTypeToString:(KCourseWorkType)type;
+ (KCourseWorkType)converStringToType:(NSString *)type;
@end
