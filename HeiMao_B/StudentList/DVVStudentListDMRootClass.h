//
//  DVVStudentListDMRootClass.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVStudentListDMData.h"

@interface DVVStudentListDMRootClass : NSObject

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, assign) NSInteger type;

@end
