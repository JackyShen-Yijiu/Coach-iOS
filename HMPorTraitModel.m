//
//  HMPorTraitModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMPorTraitModel.h"

@implementation HMPorTraitModel
+ (HMPorTraitModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMPorTraitModel * model = [[HMPorTraitModel alloc] init];
    model.thumbnailpic = [dic objectStringForKey:@"thumbnailpic"];
    model.originalpic = [dic objectStringForKey:@"originalpic"];
    return model;
}
@end
