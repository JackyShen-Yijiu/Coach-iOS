//
//  StudentSignInDataModel.h
//  HeiMao_B
//
//  Created by 大威 on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface StudentSignInDataModel : NSObject

@property (nonatomic, copy) NSString *studentId;
@property (nonatomic, copy) NSString *studentName;
@property (nonatomic, copy) NSString *reservationId;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *locationAddress;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *coachName;
@property (nonatomic, copy) NSString *courseProcessDesc;

@end
