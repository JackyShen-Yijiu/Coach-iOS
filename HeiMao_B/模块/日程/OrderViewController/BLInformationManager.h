//
//  BLInformationManager.h
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLInformationManager : NSObject

// 预约的时间
@property (copy, nonatomic) NSMutableArray *appointmentData;

// 预约的学员 数组中是模型
@property (copy, nonatomic) NSMutableArray *appointmentUserData;

+ (BLInformationManager *)sharedInstance;
@end
