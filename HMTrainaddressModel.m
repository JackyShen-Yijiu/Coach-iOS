//
//  HMTrainaddressModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/31.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMTrainaddressModel.h"

@implementation HMTrainaddressModel
+ (HMTrainaddressModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMTrainaddressModel * model = [[HMTrainaddressModel alloc] init];
    model.address = [dic objectStringForKey:@"name"];
    model.trainId = [dic objectStringForKey:@"id"];
    return model;
}
@end
