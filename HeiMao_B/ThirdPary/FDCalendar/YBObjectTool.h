//
//  YBObjectTool.h
//  studentDriving
//
//  Created by JiangangYang on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBObjectTool : NSObject
/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm-dd hh:mm:ss
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareDateWithSelectDate:(NSDate *)selectDate;

/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareMonthDateWithSelectDate:(NSDate *)selectDate;


/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm-dd hh:mm:ss
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareDateWithSelectDateStr:(NSString *)selectDate;

@end
