//
//  NSUeserStoreTool.m
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "NSUserStoreTool.h"

@implementation NSUserStoreTool


+ (BOOL)isStoreWithKey:(NSString *)key {
    
    id content = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (content != nil) {
        return YES;
    }
    return NO;
}

//存储对象
+ (void)storeWithId:(id)storeContent WithKey:(NSString *)key {
    
    [[NSUserDefaults standardUserDefaults] setObject:storeContent forKey:key];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)getObjectWithKey:(NSString *)key {
//    NSLog(@"key");
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeObjectWithKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


@end
