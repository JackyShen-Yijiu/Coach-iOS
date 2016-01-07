//
//  NSDictionary+StrDic.m
//  JewelryApp
//
//  Created by kequ on 15/5/16.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "NSDictionary+StrDic.h"
#import "NetWorkEntiry.h"

@implementation NSDictionary (StrDic)
- (NSString *)objectStringForKey:(NSString *)key
{
    NSString * value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSString class]] && value.length) {
        return value;
    }
    return nil;
}

- (NSArray *)objectArrayForKey:(NSString *)key
{
    NSArray * value = [self objectForKey:key];
    if (value && [value isKindOfClass:[NSArray class]] && value.count) {
        return value;
    }
    return nil;
}

- (NSDictionary *)objectInfoForKey:(NSString *)key
{
    NSDictionary * dic = [self objectForKey:key];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        return dic;
    }
    return nil;
}


@end
