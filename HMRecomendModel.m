//
//  HMRecomendModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMRecomendModel.h"

@implementation HMRecomendModel

+ (HMRecomendModel *)converJsonDicToModel:(NSDictionary *)dic
{
    HMRecomendModel * model = [[HMRecomendModel alloc] init];
    model.userName = @"李文政";
    model.portrait = [HMPortraitInfoModel converJsonDicToModel:nil];
    model.recomedContent = @"正的不错，学的快，人也聪明，态度好，有礼貌";
    model.recomendData = @"08-27 14:58";
    return model;
}
@end
