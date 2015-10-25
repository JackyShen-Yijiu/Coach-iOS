//
//  HMStudentModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMSchoolModel.h"
#import "HMClassModel.h"
#import "HMPorTraitModel.h"

@interface HMStudentModel : NSObject
@property(nonatomic,strong)NSString * userId;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)HMPorTraitModel * porInfo;
//@property(nonatomic,strong)HMSchoolModel * schoolInfo;
//@property(nonatomic,strong)HMClassModel * classInfo;

+ (HMStudentModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
