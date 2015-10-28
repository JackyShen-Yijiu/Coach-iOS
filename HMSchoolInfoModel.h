//
//  HMSchoolModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSchoolInfoModel : NSObject
@property(nonatomic,strong)NSString * schoolName;
@property(nonatomic,strong)NSString * schoolId;
+ (HMSchoolInfoModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
