//
//  HMRecomendModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMRecomendModel.h"

@implementation HMRecomendModel

+ (HMRecomendModel *)converJsonDicToModel:(NSDictionary *)dic
{
    HMRecomendModel * model = [[HMRecomendModel alloc] init];
    model.recomendId = [dic objectStringForKey:@"_id"];
    
    NSDictionary* coachInfo = [dic objectInfoForKey:@"coachid"];
    model.coachName = [coachInfo objectStringForKey:@"name"];
    model.coachid = [coachInfo objectStringForKey:@"_id"];
    model.portrait = [HMPortraitInfoModel converJsonDicToModel:[coachInfo objectInfoForKey:@"headportrait"]];
    model.recomedContent = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commentcontent"];

    NSString * timeStr = [[dic objectInfoForKey:@"coachcomment"] objectStringForKey:@"commenttime"];
    timeStr = [[self class ] dateFromISO8601String:timeStr];
    model.recomendData = timeStr;
    return model;
}


+ (NSString *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    NSDate * date =  [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

@end
