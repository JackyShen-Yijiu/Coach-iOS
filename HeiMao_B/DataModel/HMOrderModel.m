//
//  HMOrderModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMOrderModel.h"

@implementation HMOrderModel

+ (HMOrderModel *)converJsonDicToModel:(NSDictionary *)dic
{
    
    HMOrderModel *  model = [[HMOrderModel alloc] init];
    model.orderProgress = @"科目二路口第二学时";
    model.orderTime = @"2015年12月11 13:00-18:00";
    model.orderBeginTime = @"13:00";
    model.orderEndtime = @"18:00";
    model.orderAddress =  @"北京沙河训练场";
    model.orderPikerAddres = @"北京昌平区天通苑";
    model.isPickerUp = YES;
    model.orderStatue = [[dic objectForKey:@"reservationstate"] integerValue];
    model.userInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
    model.classType = [HMClassModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
    
    return model;

    
//    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
//        return nil;
//    }
//    HMOrderModel *  model = [[HMOrderModel alloc] init];
//
//    model.orderId = [dic objectStringForKey:@"_id"];
//    model.orderCreateTime = [dic objectStringForKey:@"reservationcreatetime"];
//    model.orderBeginTime = [dic objectStringForKey:@"begintime"];
//    model.orderEndTime = [dic objectStringForKey:@"endtime"];
//    model.orderPikerAddres = [dic objectStringForKey:@"shuttleaddress"];
//    model.isPickerUp = [[dic objectForKey:@"is_shuttle"] boolValue];
//    model.orderStatue = [[dic objectForKey:@"reservationstate"] integerValue];
//    model.userInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
//    model.classType = [HMClassModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
//    
//    return model;
}

- (NSString *)getStatueString
{
    NSString * str = @"";
    switch (self.orderStatue) {
            
        case KOrderStatueInvalid:
            break;
        case KOrderStatueRequest:
            str = @"等待确认";
            break;
        case KOrderStatueUnderWay:
            str = @"进行中";
            break;
        case KOrderStatueWatingToDone:
            str = @"学完待确认";
            break;
        case KOrderStatueOnDone:
            str = @"待评论";
            break;
        case KOrderStatueCanceld:
            str = @"取消";
            break;
        case KOrderStatueOnCommended:
            str = @"完成";
            break;
    }
    return str;
}
@end
