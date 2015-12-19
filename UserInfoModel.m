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
  
    _name =  [info objectForKey:@"name"];
    _portrait = [[info objectInfoForKey:@"headportrait"] objectStringForKey:@"originalpic"];
    _Gender = [info objectForKey:@"Gender"];
    _idcardnumber = [info objectForKey:@"idcardnumber"];
    _introduction = [info objectForKey:@"introduction"];
    _drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    _driveschoolinfo = [info objectForKey:@"driveschoolinfo"];
    _trainfieldlinfo = [info objectForKey:@"trainfieldlinfo"];
    _carmodel = [info objectForKey:@"carmodel"];
    
    _subject = [info objectForKey:@"subject"];
    _setClassMode = [[info objectForKey:@"serverclass"] boolValue];
    
    _token = [info objectForKey:@"token"];
    _userID = [info objectForKey:@"coachid"];
    _tel = [info objectForKey:@"mobile"];
    _md5Pass = [info objectForKey:@"md5Pass"];
    _displaycoachid = [info objectForKey:@"displaycoachid"];
    _invitationcode = [info objectForKey:@"invitationcode"];
    
    _worktimedesc = [info objectForKey:@"worktimedesc"];
    _beginTime = [[info objectInfoForKey:@"worktimespace"] objectStringForKey:@"begintimeint"];
    _endTime = [[info objectInfoForKey:@"worktimespace"] objectStringForKey:@"endtimeint"];
    
    _subject = [info objectForKey:@"subject"];
    _carmodel = [info  objectForKey:@"carmodel"];
    _trainfieldlinfo = [info objectForKey:@"trainfieldlinfo"];
    _driveschoolinfo = [info objectForKey:@"driveschoolinfo"];
    _idcardnumber = [info objectForKey:@"idcardnumber"];
    _drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    _Gender = [info objectForKey:@"Gender"];
    _introduction = [info objectForKey:@"introduction"];
    _workweek = [info objectArrayForKey:@"workweek"];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userID password:self.md5Pass];
  
    if (![[self class] isLogin]) {
        [[self class] storeData:[info JSONData] forKey:USERINFO_IDENTIFY];
    }
    return YES;
}

#pragma makr - set
- (void)setWorktimedesc:(NSString *)worktimedesc {
    if (!worktimedesc) {
        worktimedesc = @"";
    };
    _worktimedesc = worktimedesc;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:worktimedesc forKey:@"worktimedesc"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
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

- (void)setBeginTime:(NSString *)beginTime
{
    if (!beginTime) {
        beginTime =  @"";
    }
    _beginTime = beginTime;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    NSMutableDictionary * workTime = [[dic objectInfoForKey:@"worktimespace"] mutableCopy];
    if (!workTime) {
        workTime = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    [workTime setValue:beginTime forKey:@"begintimeint"];
    [mdic setValue:workTime forKey:@"worktimespace"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
}

- (void)setEndTime:(NSString *)endTime
{
    if (!endTime) {
        endTime = @"";
    }
    _endTime = endTime;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    NSMutableDictionary * workTime = [[dic objectInfoForKey:@"worktimespace"] mutableCopy];
    if (!workTime) {
        workTime = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    [workTime setValue:endTime forKey:@"begintimeint"];
    [mdic setValue:workTime forKey:@"worktimespace"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
}

- (void)setSetClassMode:(BOOL)setClassMode
{
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:@(setClassMode) forKey:@"serverclass"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
}

- (void)setWorkweek:(NSArray *)workweek
{
    if (workweek) {
        _workweek = workweek;
        NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
        NSMutableDictionary * mdic = [dic mutableCopy];
        [mdic setValue:workweek forKey:@"workweek"];
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
    
    if (!subject) {
        subject = @[];
    };
    _subject = subject;
    
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:subject forKey:@"subject"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
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
