//
//  HMPorTraitModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMPorTraitModel : NSObject
@property(nonatomic,strong)NSString * thumbnailpic;
@property(nonatomic,strong)NSString * originalpic;
+ (HMPorTraitModel *)converJsonDicToModel:(NSDictionary *)dic;
@end