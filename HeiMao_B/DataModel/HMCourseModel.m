//
//  HMOrderModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMCourseModel.h"

@implementation HMCourseModel

+ (HMCourseModel *)converJsonDicToModel:(NSDictionary *)dic
{
    
//    HMCourseModel *  model = [[HMCourseModel alloc] init];
//    model.courseProgress = @"科目二路口第二学时";
//    model.courseTime = @"2015年12月11 13:00-18:00";
//    model.courseBeginTime = @"13:00";
//    model.courseEndtime = @"18:00";
//    model.courseAddress =  @"北京沙河训练场";
//    model.coursePikerAddres = @"北京昌平区天通苑";
//    model.isPickerUp = YES;
//    model.courseStatue = [[dic objectForKey:@"reservationstate"] integerValue];
//    model.studentInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
//    model.classType = [HMClassInfoModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
//    
//    return model;
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMCourseModel *  model = [[HMCourseModel alloc] init];
    model.courseId = [dic objectStringForKey:@"_id"];
    model.courseProgress = [dic objectStringForKey:@"courseprocessdesc"];
    model.courseTime = [dic objectStringForKey:@"classdatetimedesc"];
    model.courseBeginTime = [dic objectStringForKey:@"begintime"];
    model.courseEndtime = [dic objectStringForKey:@"endtime"];
    
    model.courseTrainInfo = [HMTrainaddressModel converJsonDicToModel:[dic objectInfoForKey:@"trainfieldlinfo"]];
    
    model.coursePikerAddres = [dic objectStringForKey:@"shuttleaddress"];
    model.isPickerUp = [[dic objectForKey:@"is_shuttle"] boolValue];
    
    model.courseStatue = [[dic objectForKey:@"reservationstate"] integerValue];
    
    model.studentInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
    model.classType = [HMClassInfoModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
    
    return model;
}

- (NSString *)getStatueString
{
    NSString * str = @"";
    switch (self.courseStatue) {
            
        case KCourseStatueInvalid:
            break;
        case KCourseStatueStudentReject:
            return @"被拒绝";
            break;
        case KCourseStatueRequest:
            str = @"待接受";
            break;
        case KCourseStatueUnderWay:
            str = @"进行中";
            break;
        case KCourseStatueWatingToDone:
            str = @"确认学完";
            break;
        case KCourseStatueOnDone:
            str = @"待评论";
            break;
        case KCourseStatueCanceld:
            str = @"已取消";
            break;
        case KCourseStatueOnCommended:
            str = @"已完成";
            break;
    }
    return str;
}
@end
