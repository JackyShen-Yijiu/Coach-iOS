//
//  JsonTransformManager.m
//  BlackCat
//
//  Created by bestseller on 15/10/16.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JsonTransformManager.h"

@implementation JsonTransformManager
+ (NSString *)dictionaryTransformJsonWith:(NSDictionary *)dictionary {
    
    if (dictionary == nil) {
        return nil;
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSAssert(error, @"DictionaryTransformError");
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSString *)arrayTransformJsonWith:(NSArray *)array {
    
    if (array == nil) {
        return nil;
    }
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSAssert(error, @"ArrayTransformError");
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
    
}
@end
