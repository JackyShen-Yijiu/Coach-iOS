//
//  JGUserModel.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/17.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "UserInfoModel.h"

@interface JGUserModel : NSObject

@property (nonatomic,copy)NSString *address;

@property (nonatomic,strong)NSArray *addresslist;

@property (nonatomic,strong)NSDictionary *applyclasstypeinfo;

@property (nonatomic,strong)NSDictionary *applycoachinfo;

@property (nonatomic,strong)NSDictionary *applyschoolinfo;

@property (nonatomic,copy)NSString *applystate;

@property (nonatomic,copy)NSString *carmodel;

@property (nonatomic,copy)NSString *createtime;

@property (nonatomic,copy)NSString *displaymobile;

@property (nonatomic,copy)NSString *displayuserid;

@property (nonatomic,copy)NSString *email;

@property (nonatomic,copy)NSString *gender;

@property (nonatomic,strong)NSDictionary *headportrait;

@property (nonatomic,copy)NSString *invitationcode;

@property (nonatomic,copy)NSString *is_lock;

@property (nonatomic,copy)NSString *logintime;

@property (nonatomic,copy)NSString *mobile;

@property (nonatomic,copy)NSString *name;

@property (nonatomic,copy)NSString *nickname;

@property (nonatomic,strong)NSDictionary *subject;

@property (nonatomic,strong)NSDictionary *subjectthree;

@property (nonatomic,strong)NSDictionary *subjecttwo;

@property (nonatomic,copy)NSString *telephone;

@property (nonatomic,copy)NSString *token;

@property (nonatomic,copy)NSString *userid;

@property (nonatomic,strong)NSArray *vipserverlist;

@property (nonatomic,copy)NSString *msg;

@property (nonatomic,copy)NSString *type;

//********* 用户头像相关信息 ********//
@property (nonatomic,copy)NSString *originalpic;
@property (nonatomic,copy)NSString *thumbnailpic;
@property (nonatomic,copy)NSString *width;
@property (nonatomic,copy)NSString *height;

/*
 {
 data =     {
 
     address = "Hhhh ";

     addresslist =         (
     "\U5171\U5546\U56fd\U662f\U628a v \U662f\U4e0d\U662f v \U8bf4",
     "Hhhh "
     );
     applyclasstypeinfo =         {
      id = 5637298bf179283c4b17f23a;
      name = "B\U7ea7\U73ed";
      price = 12000;
     };
     applycoachinfo =         {
      id = 563358f19987927a1610f301;
      name = Mike;
     };
     applyschoolinfo =         {
      id = 563355df1e650d480a28522b;
      name = "Jacky\U9a7e\U6821";
     };
     applystate = 2;
     carmodel =         {
      code = C1;
      modelsid = 1;
      name = "\U5c0f\U578b\U6c7d\U8f66\U624b\U52a8\U6321";
     };
     createtime = "2015-12-30T10:20:43.958Z";
     displaymobile = "137****2375";
     displayuserid = 100180;
     email = "";
     gender = "\U7537";
     headportrait =         {
      height = "";
      originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/20160103/143046-5683d051c6c1974262101685.png";
      thumbnailpic = "";
      width = "";
     };
     invitationcode = 1180;
     "is_lock" = 0;
     logintime = "2016-01-17T07:49:42.156Z";
     mobile = 13720022375;
     name = "\U5854\U5854\U5854";
     nickname = "\U793e\U4f1a\U611f\U5230\U60a3\U5f97";
     subject =         {
      name = "\U79d1\U76ee\U4e8c";
      subjectid = 2;
     };
     subjectthree =         {
      finishcourse = 0;
      missingcourse = 0;
      progress = "\U672a\U5f00\U59cb";
      reservation = 0;
      totalcourse = 16;
     };
     subjecttwo =         {
      finishcourse = 0;
      missingcourse = 0;
      progress = "\U672a\U5f00\U59cb";
      reservation = 10;
      totalcourse = 24;
     };
     telephone = 13720022375;
     token = "";
     userid = 5683d051c6c1974262101685;
     vipserverlist =         (
         {
         "_id" = 563b4520075113ec38f286f2;
         id = 1;
         name = "\U63a5\U9001";
         },
         {
         "_id" = 563b4527994b335032480542;
         id = 2;
         name = "\U5348\U9910";
         },
         {
         "_id" = 563b452a3c5ed25c350ac04a;
         id = 3;
         name = "\U5ba4\U5185\U7ec3\U8f66";
         }
     );
     };
     msg = "";
     type = 1;
 }
*/

@end
