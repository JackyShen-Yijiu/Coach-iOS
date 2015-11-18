//
//  NSString+CurrentTimeDay.h
//  BlackCat
//
//  Created by 董博 on 15/10/18.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CurrentTimeDay)
+ (NSString *)currentTimeDay;
+ (NSString *)currentDay;
+ (NSString *)getDayWithAddCountWithDisplay: (NSUInteger)count;
+ (NSString *)getDayWithAddCountWithData: (NSUInteger)count;
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate;
+ (NSString *)getHourLocalDateFormateUTCDate:(NSString *)utcDate ;
+ (NSString *)getLitteLocalDateFormateUTCDate:(NSString *)utcDate;
@end
