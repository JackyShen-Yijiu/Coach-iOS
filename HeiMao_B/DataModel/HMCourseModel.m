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
    
    model.comment = [dic objectStringForKey:@"comment"];
    model.coachcomment = [dic objectStringForKey:@"coachcomment"];
    model.cancelreason = [dic objectStringForKey:@"cancelreason"];
    
    model.officialDesc = [dic objectStringForKey:@"officialDesc"];
    
    model.courseTrainInfo = [HMTrainaddressModel converJsonDicToModel:[dic objectInfoForKey:@"trainfieldlinfo"]];

    model.subjectthree = [JGSubjectthreeModel converJsonDicToModel:[dic objectInfoForKey:@"subjectthree"]];

    model.courseprocessdesc = [dic objectStringForKey:@"courseprocessdesc"];
    
    model.coursePikerAddres = [dic objectStringForKey:@"shuttleaddress"];
    model.isPickerUp = [[dic objectForKey:@"is_shuttle"] boolValue];
    
    model.courseStatue = [[dic objectForKey:@"reservationstate"] integerValue];
    
    model.studentInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
    model.classType = [HMClassInfoModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];

    // 剩余课时
    model.leavecoursecount = [[dic objectForKey:@"leavecoursecount"] intValue];
    model.missingcoursecount = [[dic objectForKey:@"missingcoursecount"] intValue];
    // 倒车入科(学习内容)
    model.learningcontent = [dic objectStringForKey:@"learningcontent"];

    return model;
}

- (NSString *)getStatueString
{
    NSString * str = @"";
    switch (self.courseStatue) {
          
        case  KCourseStatueInvalid :
             break;
        case  KCourseStatueapplying :   // 预约中
            return @"待接受";
            break;
        case  KCourseStatueapplycancel :// 学生取消
            return @"学生取消";
            break;
        case  KCourseStatueapplyconfirm:  // 已确定
            return @"已接受";
            break;
        case  KCourseStatueapplyrefuse:      // 教练（拒绝或者取消）
            return @"已取消";
            break;
        case  KCourseStatueunconfirmfinish: //  待确认完成  (v1.1 中没有该字段)
            return @"待确认完成";
            break;
        case  KCourseStatueucomments:    // 待评论
            return @"待评价";
            break;
//        case  KCourseStatueOnCommended: // 评论成功
//            return @"评价成功";
//            break;
        case  KCourseStatuefinish: // 订单完成
            return @"订单完成";
            break;
        case  KCourseStatuesystemcancel: // 系统取消
            return @"系统取消";
            break;
        case  KCourseStatuesignin: // 已签到
            return @"已签到";
            break;
        case  KCourseStatuenosignin: // 未签到
            return @"已漏课";
            break;
        
    }
    return str;
}
@end
