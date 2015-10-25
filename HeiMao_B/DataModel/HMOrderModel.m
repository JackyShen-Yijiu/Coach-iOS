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
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMOrderModel *  model = [[HMOrderModel alloc] init];

    model.orderId = [dic objectStringForKey:@"_id"];
    model.orderCreateTime = [dic objectStringForKey:@"reservationcreatetime"];
    model.orderBeginTime = [dic objectStringForKey:@"begintime"];
    model.orderEndTime = [dic objectStringForKey:@"endtime"];
    model.orderPikerAddres = [dic objectStringForKey:@"shuttleaddress"];
    model.isPickerUp = [[dic objectForKey:@"is_shuttle"] boolValue];
    model.orderStatue = [[dic objectForKey:@"reservationstate"] integerValue];
    model.userInfo = [HMStudentModel converJsonDicToModel:[dic objectInfoForKey:@"userid"]];
    model.classType = [HMClassModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
    
    return model;
}
@end
