//
//  DVVLocationStatus.h
//  studentDriving
//
//  Created by 大威 on 16/1/14.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVVLocationStatus : NSObject

/**
 *  检测用户定位服务是否开启
 */
- (BOOL)checkLocationStatus;

/**
 *  提醒用户去设置中打开定位服务
 */
- (void)remindUser;
- (void)setSelectCancelButtonBlock:(dispatch_block_t)handle;
- (void)setSelectOkButtonBlock:(dispatch_block_t)handle;

@end
