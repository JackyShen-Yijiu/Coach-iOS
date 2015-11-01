//
//  HMCarLicenseModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/31.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMCarLicenseModel.h"

@implementation HMCarLicenseModel

+ (HMCarLicenseModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMCarLicenseModel  * model = [[HMCarLicenseModel alloc] init];
    model.code = [dic objectStringForKey:@"code"];
    model.name = [dic objectStringForKey:@"name"];
    model.modelId = [dic objectStringForKey:@"modelsid"];
    return model;
}

@end
