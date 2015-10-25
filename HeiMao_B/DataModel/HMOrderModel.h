//
//  HMOrderModel.h
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelDefine.h"
#import "HMStudentModel.h"
#import "HMClassModel.h"
#import "ModelDefine.h"
#import "BaseModelMethod.h"

@interface HMOrderModel : NSObject

@property(nonatomic,strong)NSString * orderId;
@property(nonatomic,strong)NSString * orderCreateTime;
@property(nonatomic,strong)NSString * orderBeginTime;
@property(nonatomic,strong)NSString * orderEndTime;
@property(nonatomic,strong)NSString * orderAddress;     //训练场地
@property(nonatomic,strong)NSString * orderPikerAddres; //接送地址
@property(nonatomic,assign)KOrderStatue orderStatue;
@property(nonatomic,assign)BOOL isPickerUp;
@property(nonatomic,strong)HMClassModel * classType;
@property(nonatomic,strong)HMStudentModel * userInfo;

+ (HMOrderModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
