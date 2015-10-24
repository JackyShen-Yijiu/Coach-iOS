//
//  NetWorkEntiry.h
//  JewelryApp
//
//  Created by kequ on 15/5/12.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define KNETBASEURL          @"http://120.25.209.9/f3"


@interface NetWorkEntiry : NSObject

/**
 *  @param success  用户名
 *  @param failure  用户密码
 */

+ (void)loginWithUserName:(NSString *)userName password:(NSString *)password
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)mofifyPassWord:(NSString *)pasWord
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
