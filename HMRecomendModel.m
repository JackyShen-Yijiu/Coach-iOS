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
    model.recomendId = [dic objectStringForKey:@"_id"];
    
    NSDictionary* coachInfo = [dic objectInfoForKey:@"coachid"];
    model.coachName = [coachInfo objectStringForKey:@"name"];
    model.coachid = [coachInfo objectStringForKey:@"_id"];
    model.portrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];
    model.recomedContent = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commentcontent"];
    model.recomendData = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commenttime"];
    return model;
}
@end
