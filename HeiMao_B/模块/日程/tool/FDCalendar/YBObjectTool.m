//
//  YBObjectTool.m
//  studentDriving
//
//  Created by JiangangYang on 16/2/22.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBObjectTool.h"

static NSDateFormatter *sharedDateFormatter;

@implementation YBObjectTool

+ (NSDateFormatter *)sharedDateFormatter
{
    if (sharedDateFormatter==nil) {
        sharedDateFormatter = [[NSDateFormatter alloc] init];
    }
    return sharedDateFormatter;
}

/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm-dd hh:mm:ss
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareDateWithSelectDate:(NSDate *)selectDate
{
    NSDateFormatter *fomatter = [self sharedDateFormatter];
    
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [NSDate date];
    NSString *curentDateStr = [fomatter stringFromDate:currentDate];
    currentDate = [fomatter dateFromString:curentDateStr];
    
    NSString *selectDateStr = [fomatter stringFromDate:selectDate];
    selectDate = [fomatter dateFromString:selectDateStr];
    
    int result = [selectDate compare:currentDate];
    NSLog(@"result:%d",result);
    if(result == NSOrderedDescending)
    {
        return 1;
    }
    else if(result == NSOrderedAscending)
    {
        return -1;
    }
    return 0;
}


/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareMonthDateWithSelectDate:(NSDate *)selectDate
{
    NSDateFormatter *fomatter = [self sharedDateFormatter];
    
    [fomatter setDateFormat:@"yyyy-MM"];
    NSDate *currentDate = [NSDate date];
    NSString *curentDateStr = [fomatter stringFromDate:currentDate];
    currentDate = [fomatter dateFromString:curentDateStr];
    
    NSString *selectDateStr = [fomatter stringFromDate:selectDate];
    selectDate = [fomatter dateFromString:selectDateStr];
    
    int result = [selectDate compare:currentDate];
    NSLog(@"result:%d",result);
    if(result == NSOrderedDescending)
    {
        return 1;
    }
    else if(result == NSOrderedAscending)
    {
        return -1;
    }
    return 0;
}



/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm-dd hh:mm:ss
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareDateWithSelectDateStr:(NSString *)selectDate
{
    NSDateFormatter *fomatter = [self sharedDateFormatter];
    
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *currentDate = [NSDate date];
    NSString *curentDateStr = [fomatter stringFromDate:currentDate];
    currentDate = [fomatter dateFromString:curentDateStr];
    
    NSDate *date=[fomatter dateFromString:selectDate];

    int result = [date compare:currentDate];
    NSLog(@"result:%d",result);
    if(result == NSOrderedDescending)
    {
        return 1;
    }
    else if(result == NSOrderedAscending)
    {
        return -1;
    }
    return 0;
}

/**
 *  判断传入的日期和当前日期比较
 *  @parma selectDate:选择的日期 yyyy-mm-dd hh:mm:ss
 *  @return 1:大于当前日期 -1:小于当前时间 0:等于当前时间
 */
+(int)compareHMSDateWithBegintime:(NSString *)begintime endtime:(NSString *)endtime
{
    NSDateFormatter *fomatter = [self sharedDateFormatter];
    [fomatter setDateFormat:@"hh"];
    NSDate *currentDate = [NSDate date];
    NSString *curentDateStr = [fomatter stringFromDate:currentDate];
    
    NSLog(@"compareHMSDateWithBegintime curentDateStr:%@ begintime:%@ endtime:%@",curentDateStr,begintime,endtime);
    
    if ([curentDateStr integerValue]>=[begintime integerValue]&& [curentDateStr integerValue]<=[endtime integerValue]) {
        return 0;
    }else if ([endtime integerValue] < [curentDateStr integerValue]){
        return -1;
    }else if ([begintime integerValue] > [curentDateStr integerValue]){
        return 1;
    }
    
    return 0;
    
}


@end
