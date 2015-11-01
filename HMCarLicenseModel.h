//
//  HMCarLicenseModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/31.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMCarLicenseModel : NSObject
@property(nonatomic,strong)NSString * code;
@property(nonatomic,strong)NSString * modelId;
@property(nonatomic,strong)NSString * name;

+ (HMCarLicenseModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
