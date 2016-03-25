//
//  NSUeserStoreTool.h
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserStoreTool : NSObject
+ (BOOL)isStoreWithKey:(NSString *)key;
//存储对象
+ (void)storeWithId:(id)storeContent WithKey:(NSString *)key;
//取出对象
+ (id)getObjectWithKey:(NSString *)key;

+ (void)removeObjectWithKey:(NSString *)key;

@end
