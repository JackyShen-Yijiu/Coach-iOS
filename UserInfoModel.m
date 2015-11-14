//
//  UserInfoModel.m
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "UserInfoModel.h"
#import "EaseMob.h"

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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginoutSuccess" object:nil];
}

- (BOOL)loginViewDic:(NSDictionary *)info
{
    self.token = [info objectForKey:@"token"];
    self.userID = [info objectForKey:@"coachid"];
    self.name =  [info objectForKey:@"name"];
    self.tel = [info objectForKey:@"mobile"];
    self.md5Pass = [info objectForKey:@"md5Pass"];
    EMError *error = nil;
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:@"123456" password:@"123456" error:&error];
    if (!error && loginInfo) {
        NSLog(@"登陆成功 %@",loginInfo);
    }
    if (![[self class] isLogin]) {
        [[self class] storeData:info forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

@end
