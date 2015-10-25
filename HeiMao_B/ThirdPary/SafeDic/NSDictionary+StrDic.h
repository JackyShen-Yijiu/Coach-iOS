//
//  NSDictionary+StrDic.h
//  JewelryApp
//
//  Created by kequ on 15/5/16.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (StrDic)
- (NSString *)objectStringForKey:(NSString *)key;
- (NSArray *)objectArrayForKey:(NSString *)key;
- (NSDictionary *)objectInfoForKey:(NSString *)key;
@end

