//
//  UserInfoModel.m
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "UserInfoModel.h"

#define USERINFO_IDENTIFY       @"USERINFO_IDENTIFY"

@implementation UserInfoModel (private)

#pragma mark - StoreDefaults
+ (void)storeData:(id)data forKey:(NSString *)key
{
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:data forKey:key];
    [defults synchronize];
}

+ (id)dataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * data = [defaults objectForKey:key];
    return data;
}
+ (void)removeDataForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end

@implementation UserInfoModel

+ (UserInfoModel *)defaultUserInfo
{
    static UserInfoModel * userInfoModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!userInfoModel) {
            userInfoModel = [[self alloc] init];
            userInfoModel.userID = @"5616352721ec29041a9af889";
            userInfoModel.token =  @" eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI1NjE2MzUyNzIxZWMyOTA0MWE5YWY4ODkiLCJ0aW1lc3RhbXAiOiIyMDE1LTEwLTA4VDA5OjIzOjQ4LjY5NloiLCJhdWQiOiJibGFja2NhdGUiLCJpYXQiOjE0NDQyOTYyMjh9.-iOZ5fIQjdmdHBthsCP7VQWRYYM68zWWHWWnIUxRSEg";
        }
    });
    return userInfoModel;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        if ([[self class] isLogin]) {
            [self loginViewDic:[[self class] dataForKey:USERINFO_IDENTIFY]];
        }
    }
    return self;
}

+ (BOOL)isLogin
{
    return [[self class] dataForKey:USERINFO_IDENTIFY] != nil;
}
- (void)loginOut
{
    [[self class] removeDataForKey:USERINFO_IDENTIFY];
}

- (BOOL)loginViewDic:(NSDictionary *)info
{
    self.token = [info objectForKey:@"token"];
    self.userID = [info objectForKey:@"coachid"];
    self.name =  [info objectForKey:@"name"];
    self.tel = [info objectForKey:@"mobile"];
    if (![[self class] isLogin]) {
        [[self class] storeData:info forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

@end
