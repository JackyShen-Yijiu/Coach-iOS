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

- (NSString *)objectForImageStr:(NSString *)key
{
    NSString * rpath = [self objectStringForKey:key];
    if (rpath) {
        return [NSString stringWithFormat:@"%@/%@",KNETBASEURL,rpath];
    }
    return nil;
}

- (NSArray *)objectForImageArray:(NSString*)key
{
    NSArray * listArray = [self objectArrayForKey:key];
    NSMutableArray * fArray  = [NSMutableArray arrayWithCapacity:listArray.count];
    for (NSString * str in listArray) {
        if (str && [str isKindOfClass:[NSString class]] &&[str length] && ![str isEqualToString:@""]) {
            NSString * imageStr = [NSString stringWithFormat:@"%@/%@",KNETBASEURL,str];
            if (![self containsImage:imageStr Inarray:fArray]) {
                [fArray addObject:imageStr];
            }
        }
    }
    return fArray.count ? fArray : nil;
}

- (BOOL)containsImage:(NSString *)imagesStr Inarray:(NSArray *)array
{
    for (NSString * str in array) {
        if ([str isEqualToString:imagesStr]) {
            return YES;
        }
    }
    return NO;
}
@end

@implementation NSArray(StrDic)
- (NSArray*)stripImageUrlBase:(NSArray *)array
{
    NSMutableArray * fArray  = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString * str in array) {
        NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@/",KNETBASEURL]];
        NSString * fstr = [str substringFromIndex:range.length];
        if (fstr)
            [fArray addObject:fstr];
    }
    return fArray.count ? fArray : nil;
}
@end
