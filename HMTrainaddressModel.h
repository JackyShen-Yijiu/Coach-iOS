//
//  HMTrainaddressModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/31.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTrainaddressModel : NSObject
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * trainId;
+ (HMTrainaddressModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
