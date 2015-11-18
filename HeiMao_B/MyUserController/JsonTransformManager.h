//
//  JsonTransformManager.h
//  BlackCat
//
//  Created by bestseller on 15/10/16.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonTransformManager : NSObject
+ (NSString *)dictionaryTransformJsonWith:(NSDictionary *)dictionary;
+ (NSString *)arrayTransformJsonWith:(NSArray *)array;
@end
