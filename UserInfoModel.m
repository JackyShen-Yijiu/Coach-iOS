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
            [self loginViewDic:[[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData]];
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
  
    self.name =  [info objectForKey:@"name"];
    self.portrait = [[info objectInfoForKey:@"headportrait"] objectStringForKey:@"originalpic"];
    self.Gender = [info objectForKey:@"Gender"];
    self.idcardnumber = [info objectForKey:@"idcardnumber"];
    self.introduction = [info objectForKey:@"introduction"];
    self.drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    self.driveschoolinfo = [info objectForKey:@"driveschoolinfo"];
    self.trainfieldlinfo = [info objectForKey:@"trainfieldlinfo"];
    self.carmodel = [info objectForKey:@"carmodel"];
    
    self.subject = [info objectForKey:@"subject"];
    
    self.token = [info objectForKey:@"token"];
    self.userID = [info objectForKey:@"coachid"];
    self.tel = [info objectForKey:@"mobile"];
    self.md5Pass = [info objectForKey:@"md5Pass"];
    self.displaycoachid = [info objectForKey:@"displaycoachid"];
    self.invitationcode = [info objectForKey:@"invitationcode"];
    
    self.worktimedesc = [info objectForKey:@"setWorktimedesc"];
    self.subject = [info objectForKey:@"subject"];
    self.carmodel = [info  objectForKey:@"carmodel"];
    self.trainfieldlinfo = [info objectForKey:@"trainfieldlinfo"];
    self.driveschoolinfo = [info objectForKey:@"driveschoolinfo"];
    self.idcardnumber = [info objectForKey:@"idcardnumber"];
    self.drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    self.Gender = [info objectForKey:@"Gender"];
    self.introduction = [info objectForKey:@"introduction"];
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userID password:self.md5Pass];
  
    if (![[self class] isLogin]) {
        [[self class] storeData:[info JSONData] forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

#pragma makr - set
- (void)setWorktimedesc:(NSString *)worktimedesc {
    if (!worktimedesc) {
        _worktimedesc = @"";
    };
    _worktimedesc = worktimedesc;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:worktimedesc forKey:@"worktimedesc"];
    [[self class] storeData:[dic JSONData] forKey:USERINFO_IDENTIFY];
}

- (void)setCarmodel:(NSDictionary *)carmodel {
    _carmodel = carmodel;
    if (carmodel) {
        NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
        NSMutableDictionary * mdic = [dic mutableCopy];
        [mdic setValue:carmodel forKey:@"carmodel"];
        [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    }
}
- (void)setTrainfieldlinfo:(NSDictionary *)trainfieldlinfo {
    _trainfieldlinfo = trainfieldlinfo;
    if (trainfieldlinfo) {
        NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
        NSMutableDictionary * mdic = [dic mutableCopy];
        [mdic setValue:trainfieldlinfo forKey:@"trainfieldlinfo"];
        [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    }
}

- (void)setPortrait:(NSString *)portrait {

    if (!portrait)  {
        portrait = @"";
    };
    _portrait = portrait;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    NSDictionary * headdic = @{
                           @"originalpic":portrait
                           };
    [mdic setValue:headdic forKey:@"headportrait"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];

}

- (void)setSubject:(NSArray *)subject {
    _subject = subject;
    if (!subject || ![subject count]) return;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:subject forKey:@"subject"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:subject forKey:@"subject"];
}

- (void)setIntroduction:(NSString *)introduction {
    if (!introduction) {
        introduction = @"";
    };
    
    _introduction = introduction;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:introduction forKey:@"introduction"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:introduction forKey:@"introduction"];
}
- (void)setGender:(NSString *)Gender {
    if (!Gender) {
        Gender = @"";
    };
    _Gender = Gender;

    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:Gender forKey:@"Gender"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:Gender forKey:@"Gender"];
}
- (void)setDrivinglicensenumber:(NSString *)drivinglicensenumber {
    if (!drivinglicensenumber) {
        drivinglicensenumber = @"";
    };
    _drivinglicensenumber = drivinglicensenumber;

    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:drivinglicensenumber forKey:@"drivinglicensenumber"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:drivinglicensenumber forKey:@"drivinglicensenumber"];
}
- (void)setTel:(NSString *)tel {
    if (!tel) {
        tel = @"";
    };
    _tel = tel;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:tel forKey:@"mobile"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
}

- (void)setIdcardnumber:(NSString *)idcardnumber {
    
    if (!idcardnumber) {
        _idcardnumber = @"";
    };
    _idcardnumber = idcardnumber;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:idcardnumber forKey:@"idcardnumber"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:idcardnumber forKey:@"idcardnumber"];
}
- (void)setDriveschoolinfo:(NSDictionary *)driveschoolinfo {
    _driveschoolinfo = driveschoolinfo;
    if (driveschoolinfo) {
        NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
        NSMutableDictionary * mdic = [dic mutableCopy];
        [mdic setValue:driveschoolinfo forKey:@"driveschoolinfo"];
        [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//        [UserInfoModel storeData:driveschoolinfo forKey:@"driveschoolinfo"];
    }
}
- (void)setName:(NSString *)name
{

    if (!name){
        name = @"";
    };
    _name = name;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:name forKey:@"name"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
//    [UserInfoModel storeData:name forKey:@"name"];
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
