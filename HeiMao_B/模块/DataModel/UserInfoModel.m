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
    /*
     {
     Gender = "\U7537";
     Seniority = 0;
     address = "\U6d77\U6dc0\U533a\U4e2d\U5173\U6751";
     carmodel =     {
     code = C1;
     modelsid = 1; 1 直营教练 0 挂靠教练
     name = "\U624b\U52a8\U6321\U6c7d\U8f66";
     };
     cartype = "";
     coachid = 564227ec1eb4017436ade69c;
     coachnumber = 5455454848456645;
     coachtype = 1;
     commentcount = 10;
     createtime = "2015-11-10T17:21:04.368Z";
     displaycoachid = 100061;
     driveschoolinfo =     {
     id = 56c71dc8de346bda5466f8ef;
     name = "\U4e00\U6b65\U9a7e\U6821 \U592a\U539f\U5206\U6821";
     };
     drivinglicensenumber = 130503196404010719vsv;
     email = "";
     fcode = "";
     headportrait =     {
     height = "";
     originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/564227ec1eb4017436ade69c1455614511222";
     thumbnailpic = "";
     width = "";
     };
     idcardnumber = "56565656525845****";
     introduction = "\U5982\U679c\U5728\U5b66\U8f66\U8fc7\U7a0b\U4e2d\U9047\U5230\U4e86\U4e00\U4e2a\U57f9\U8bad\U7ecf\U9a8c\U4e30\U5bcc\U4e14\U6027\U683c\U723d\U6717\U7684\U6559\U7ec3\Uff0c\U90a3\U4e48\U4f60 \U5c06\U5ea6\U8fc7\U4e00\U4e2a\U6109\U5feb\U7684\U5b66\U8f66\U8fc7\U7a0b\U3002\U8010\U5fc3\U7684\U6559\U5b66\U6001\U5ea6\Uff0c\U72ec\U7279\U7684\U6559\U5b66\U7406\U5ff5\U6765\U8fce\U63a5\U6bcf\U4e00\U4f4d\U5b66\U5458\U3002   \U54c8\U54c8";
     invitationcode = 1061;
     "is_lock" = 0;
     "is_shuttle" = 0;
     "is_validation" = 1;
     leavebegintime = 1469155140;
     leaveendtime = 1477104000;
     logintime = "2016-03-25T11:52:56.697Z";
     md5Pass = e10adc3949ba59abbe56e057f20f883e;
     mobile = 18444444001;
     name = "\U5218\U5947\U82b3";
     passrate = 99;
     platenumber = "<null>";
     serverclass = 8;
     shuttlemsg = "\U6682\U4e0d\U63d0\U4f9b\U63a5\U9001\U670d\U52a1";
     starlevel = 5;
     studentcoount = 10;
     subject =     (
     {
     "_id" = 56d949f20402bf7762d86af5;
     name = "\U79d1\U76ee\U4e8c";
     subjectid = 2;
     },
     {
     "_id" = 56d949f20402bf7762d86af4;
     name = "\U79d1\U76ee\U4e09";
     subjectid = 3;
     }
     );
     tagslist =     (
     {
     "_id" = 56a0d121a835f788669cb3db;
     color = "#ffb814";
     tagname = "\U4e94\U661f\U7ea7\U6559\U7ec3";
     tagtype = 0;
     },
     {
     "_id" = 569e34ba77e15ea1406264ad;
     color = "#ef56b9";
     tagname = "\U5f88\U597d";
     tagtype = 1;
     },
     {
     "_id" = 569eddcb77e15ea1406264b7;
     color = "#20d1bc";
     tagname = "\U4f60\U5c31";
     tagtype = 1;
     },
     {
     "_id" = 56a096c5b23b45e15310833b;
     color = "#20d1bc";
     tagname = "\U80e1\U5929";
     tagtype = 1;
     },
     {
     "_id" = 56a0d09cbb44dfc956b95822;
     color = "#45cbfb";
     tagname = "\U660e\U5e74";
     tagtype = 1;
     },
     {
     "_id" = 56a0e00df1bd513a58ffc23a;
     color = "#ef56b9";
     tagname = "\U62b9\U54af";
     tagtype = 1;
     },
     {
     "_id" = 56a0e02bf1bd513a58ffc23b;
     color = "#d755f2";
     tagname = "\U4e86\U89e3";
     tagtype = 1;
     }
     );
     token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI1NjQyMjdlYzFlYjQwMTc0MzZhZGU2OWMiLCJ0aW1lc3RhbXAiOiIyMDE2LTAzLTI1VDExOjUyOjU2LjY5N1oiLCJhdWQiOiJibGFja2NhdGUiLCJpYXQiOjE0NTg5MDY3NzZ9.fjkjrUQ3e6ahq-_dDbZdeG-9ZuTiD95i0W4DbeBflNQ";
     trainfieldlinfo =     {
     id = 561636cc21ec29041a9af88e;
     name = "\U4e00\U6b65\U9a7e\U6821\U7b2c\U4e00\U8bad\U7ec3\U573a";
     };
     usersetting =     {
     classremind = 1;
     newmessagereminder = 1;
     reservationreminder = 1;
     };
     validationstate = 3;
     worktimedesc = "\U5468\U4e00\U5468\U4e8c\U5468\U4e09\U5468\U56db\U5468\U4e94\U5468\U516d 0:00--23:00";
     worktimespace =     {
     begintimeint = 0;
     endtimeint = 23;
     };
     workweek =     (
     1,
     2,
     3,
     4,
     5,
     6
     );
     }

     */
    NSLog(@"%@",info);
    _name =  [info objectForKey:@"name"];
    _portrait = [[info objectInfoForKey:@"headportrait"] objectStringForKey:@"originalpic"];
    _Gender = [info objectForKey:@"Gender"];
    _idcardnumber = [info objectForKey:@"idcardnumber"];
    _introduction = [info objectForKey:@"introduction"];
    _drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    _driveschoolinfo = [info objectForKey:@"driveschoolinfo"];
    _schoolId = [[info objectForKey:@"driveschoolinfo"] objectForKey:@"id"];
    _trainfieldlinfo = [info objectForKey:@"trainfieldlinfo"];
    _carmodel = [info objectForKey:@"carmodel"];
    
    _subject = [info objectForKey:@"subject"];
    _setClassMode = [[info objectForKey:@"serverclass"] boolValue];

    _token = [info objectForKey:@"token"];
    _userID = [info objectForKey:@"coachid"];
    _coachNumber = [info objectForKey:@"coachnumber"];
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
    _idcardnumber = [info objectForKey:@"idcardnumber"];
    _drivinglicensenumber = [info objectForKey:@"drivinglicensenumber"];
    _Gender = [info objectForKey:@"Gender"];
    _introduction = [info objectForKey:@"introduction"];
    _workweek = [info objectArrayForKey:@"workweek"];
    
    _coachtype = [[info objectForKey:@"coachtype"] integerValue];

    _leavebegintime = [info objectForKey:@"leavebegintime"];
    _leaveendtime = [info objectForKey:@"leaveendtime"];

    _is_validation = [[info objectForKey:@"is_validation"] boolValue];
    
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
    [workTime setValue:endTime forKey:@"endtimeint"];
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
- (void)setIs_validation:(BOOL)is_validation
{
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:@(is_validation) forKey:@"is_validation"];
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
- (void)setCoachtype:(NSInteger)coachtype {
    
    _coachtype = coachtype;
    
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:@(coachtype) forKey:@"coachtype"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    
}
- (void)setFcode:(NSInteger)fcode
{
    _fcode = fcode;
    
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:@(fcode) forKey:@"ynumber"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    
}

- (void)setSeniority:(NSInteger)Seniority
{
    _Seniority = Seniority;
    
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    [mdic setValue:@(Seniority) forKey:@"Seniority"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    
}
- (void)setSchoolId:(NSString *)schoolId
{
    if (!schoolId) {
        schoolId = @"";
    }
    _schoolId = schoolId;
    NSDictionary * dic = [[[self class] dataForKey:USERINFO_IDENTIFY] objectFromJSONData];
    NSMutableDictionary * mdic = [dic mutableCopy];
    NSMutableDictionary * sInfo = [[mdic objectForKey:@"driveschoolinfo"] mutableCopy];
    [sInfo setValue:_schoolId forKey:@"id"];
    [mdic setValue:sInfo forKey:@"driveschoolinfo"];
    [[self class] storeData:[mdic JSONData] forKey:USERINFO_IDENTIFY];
    
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
