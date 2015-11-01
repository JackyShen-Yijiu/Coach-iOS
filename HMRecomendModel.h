//
//  HMRecomendModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMPortraitInfoModel.h"

@interface HMRecomendModel : NSObject
@property(nonatomic,strong)NSString * recomendId;
@property(nonatomic,strong)NSString * coachid;
@property(nonatomic,strong)NSString * coachName;
@property(nonatomic,strong)HMPortraitInfoModel * portrait;
@property(nonatomic,strong)NSString * recomedContent;
@property(nonatomic,strong)NSString * recomendData;
+ (HMRecomendModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
