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
    [UserInfoModel removeDataForKey:@"name"];
    [UserInfoModel removeDataForKey:@"idcardnumber"];
    [UserInfoModel removeDataForKey:@"telephone"];
    [UserInfoModel removeDataForKey:@"drivinglicensenumber"];
    [UserInfoModel removeDataForKey:@"Gender"];
    [UserInfoModel removeDataForKey:@"introduction"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kLoginoutSuccess" object:nil];
}

- (BOOL)loginViewDic:(NSDictionary *)info
{
    self.token = [info objectForKey:@"token"];
    self.userID = [info objectForKey:@"coachid"];
    if (![[self class] isLogin]) {
        self.name =  [info objectForKey:@"name"];
        self.portrait = [[info objectInfoForKey:@"headportrait"] objectStringForKey:@"originalpic"];
        self.Gender = [info objectForKey:@"Gender"];
        self.idcardnumber = [info objectForKey:@"idcardnumber"];
        self.introduction = [info objectForKey:@"introduction"];
        self.drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];

    }
    self.tel = [info objectForKey:@"mobile"];
    self.md5Pass = [info objectForKey:@"md5Pass"];
    self.displaycoachid = [info objectForKey:@"displaycoachid"];
   
    self.invitationcode = [info objectForKey:@"invitationcode"];
    EMError *error = nil;
    NSDictionary *loginInfo = [[EaseMob sharedInstance].chatManager loginWithUsername:self.userID password:self.md5Pass error:&error];
    if (!error && loginInfo) {
        NSLog(@"登陆成功 %@",loginInfo);
    }
    if (![[self class] isLogin]) {
        [[self class] storeData:info forKey:USERINFO_IDENTIFY];
    }
    return YES;
}
- (void)setPortrait:(NSString *)portrait {
    [UserInfoModel storeData:portrait forKey:@"portrait"];
}
- (NSString *)portrait {
    NSString *string = [UserInfoModel dataForKey:@"portrait"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setName:(NSString *)name {
    [UserInfoModel storeData:name forKey:@"name"];
}
- (NSString *)name {
    NSString *string = [UserInfoModel dataForKey:@"name"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setIdcardnumber:(NSString *)idcardnumber {
    [UserInfoModel storeData:idcardnumber forKey:@"idcardnumber"];
}
- (NSString *)idcardnumber {
    NSString *string = [UserInfoModel dataForKey:@"idcardnumber"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setTel:(NSString *)tel {
    [UserInfoModel storeData:tel forKey:@"telephone"];
}
- (NSString *)tel {
    NSString *string = [UserInfoModel dataForKey:@"telephone"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setDrivinglicensenumber:(NSString *)drivinglicensenumber {
    [UserInfoModel storeData:drivinglicensenumber forKey:@"drivinglicensenumber"];
}
- (NSString *)drivinglicensenumber {
    NSString *string = [UserInfoModel dataForKey:@"drivinglicensenumber"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setGender:(NSString *)Gender {
    [UserInfoModel storeData:Gender forKey:@"Gender"];
}
- (NSString *)Gender {
    NSString *string = [UserInfoModel dataForKey:@"Gender"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (void)setIntroduction:(NSString *)introduction {
    [UserInfoModel storeData:introduction forKey:@"introduction"];
}
- (NSString *)introduction {
    NSString *string = [UserInfoModel dataForKey:@"introduction"];
    if (string == nil || string.length == 0) {
        string = @"";
    }
    return string;
}
- (NSDictionary *)messageExt
{
    if (![[self class] isLogin]) {
        return nil;
    }
    return  @{
              @"userId":[[UserInfoModel defaultUserInfo] userID],
              @"nickName":[[UserInfoModel defaultUserInfo] name],
              @"headUrl":[[UserInfoModel defaultUserInfo] portrait],
              @"userType":@"2"
              };
}

@end
