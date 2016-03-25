//
//  HMClassType.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMClassInfoModel : NSObject
@property(nonatomic,strong)NSString * classTypeName;
@property(nonatomic,strong)NSString * classTypeId;
+ (HMClassInfoModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
