//
//  EaseSDKHelper.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseSDKHelper.h"

#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSObject+EaseMob.h"

@interface EMChatImageOptions : NSObject<IChatImageOptions,EMChatManagerDelegate,EMCallManagerDelegate>

@property (assign, nonatomic) CGFloat compressionQuality;

@end

static EaseSDKHelper *helper = nil;

@implementation EaseSDKHelper

@synthesize isShowingimagePicker = _isShowingimagePicker;

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}

+(instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[EaseSDKHelper alloc] init];
    });
    
    return helper;
}

#pragma mark - app delegate notifications

// 监听系统生命周期回调，以便将需要的事件传给SDK
- (void)_setupAppDelegateNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterBackgroundNotif:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidFinishLaunching:)
                                                 name:UIApplicationDidFinishLaunchingNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActiveNotif:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActiveNotif:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillTerminateNotif:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataWillBecomeUnavailableNotif:)
                                                 name:UIApplicationProtectedDataWillBecomeUnavailable
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appProtectedDataDidBecomeAvailableNotif:)
                                                 name:UIApplicationProtectedDataDidBecomeAvailable
                                               object:nil];
}

- (void)appDidEnterBackgroundNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:notif.object];
}

- (void)appWillEnterForeground:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:notif.object];
}

- (void)appDidFinishLaunching:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidFinishLaunching:notif.object];
}

- (void)appDidBecomeActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidBecomeActive:notif.object];
}

- (void)appWillResignActiveNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillResignActive:notif.object];
}

- (void)appDidReceiveMemoryWarning:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationDidReceiveMemoryWarning:notif.object];
}

- (void)appWillTerminateNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationWillTerminate:notif.object];
}

- (void)appProtectedDataWillBecomeUnavailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataWillBecomeUnavailable:notif.object];
}

- (void)appProtectedDataDidBecomeAvailableNotif:(NSNotification*)notif
{
    [[EaseMob sharedInstance] applicationProtectedDataDidBecomeAvailable:notif.object];
}

#pragma mark - init easemob
- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
               otherConfig:(NSDictionary *)otherConfig
{

    
    //注册AppDelegate默认回调监听
    [self _setupAppDelegateNotifications];
    
    //注册easemob sdk
    [[EaseMob sharedInstance] registerSDKWithAppKey:appkey
                                       apnsCertName:apnsCertName
                                        otherConfig:otherConfig];
    
    // 注册环信监听
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];

    //启动easemob sdk
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
}

#pragma mark - EMChatManagerLoginDelegate

// 自动登录开始回调
-(void)willAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
//    UIAlertView *alertView = nil;
    if (error) {
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.beginAutoLogin", @"Start automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //将旧版的coredata数据导入新的数据库
        EMError *error = [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
        if (!error) {
            error = [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
        }
        [[EaseMob sharedInstance].chatManager setApnsNickname:[UserInfoModel defaultUserInfo].name];

    }
    
//    [alertView show];
}

// 自动登录结束回调
-(void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error
{
//    UIAlertView *alertView = nil;
    if (error) {
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.errorAutoLogin", @"Automatic logon failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        
        //发送自动登陆状态通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
    else{
        //获取群组列表
        [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsList];
        
//        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"login.endAutoLogin", @"End automatic login...") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    }
    
//    [alertView show];
}

#pragma make - login easemob

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
{
    
}

#pragma mark - send message

+ (EMMessage *)sendTextMessage:(NSString *)text
                            to:(NSString *)toUser
                   messageType:(EMMessageType)messageType
             requireEncryption:(BOOL)requireEncryption
                    messageExt:(NSDictionary *)messageExt

{
    // 表情映射。
    NSString *willSendText = [EaseConvertToCommonEmoticonsHelper convertToCommonEmoticons:text];
    EMChatText *textChat = [[EMChatText alloc] initWithText:willSendText];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:textChat];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:toUser bodies:[NSArray arrayWithObject:body]];
    message.requireEncryption = requireEncryption;
    message.messageType = messageType;
    message.ext = messageExt;
    EMMessage *retMessage = [[EaseMob sharedInstance].chatManager asyncSendMessage:message
                                                                          progress:nil];
    
    return retMessage;
}

+ (EMMessage *)sendLocationMessageWithLatitude:(double)latitude
                                     longitude:(double)longitude
                                       address:(NSString *)address
                                            to:(NSString *)to
                                   messageType:(EMMessageType)messageType
                             requireEncryption:(BOOL)requireEncryption
                                    messageExt:(NSDictionary *)messageExt
{
    EMChatLocation *chatLocation = [[EMChatLocation alloc] initWithLatitude:latitude longitude:longitude address:address];
    EMLocationMessageBody *body = [[EMLocationMessageBody alloc] initWithChatObject:chatLocation];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:to bodies:[NSArray arrayWithObject:body]];
    message.requireEncryption = requireEncryption;
    message.messageType = messageType;
    message.ext = messageExt;
    EMMessage *retMessage = [[EaseMob sharedInstance].chatManager asyncSendMessage:message
                                                                          progress:nil];
    
    return retMessage;
}

+ (EMMessage *)sendImageMessageWithImage:(UIImage *)image
                                      to:(NSString *)to
                             messageType:(EMMessageType)messageType
                       requireEncryption:(BOOL)requireEncryption
                              messageExt:(NSDictionary *)messageExt
                                progress:(id<IEMChatProgressDelegate>)progress
{
    return [self sendImageMessageWithImage:image to:to messageType:messageType requireEncryption:requireEncryption messageExt:messageExt quality:0.6 progress:progress];
}

+ (EMMessage *)sendImageMessageWithImage:(UIImage *)image
                                      to:(NSString *)to
                             messageType:(EMMessageType)messageType
                       requireEncryption:(BOOL)requireEncryption
                              messageExt:(NSDictionary *)messageExt
                                 quality:(float)quality
                                progress:(id<IEMChatProgressDelegate>)progress
{
    id<IChatImageOptions> options = [[EMChatImageOptions alloc] init];
    [options setCompressionQuality:quality];
    
    EMChatImage *chatImage = [[EMChatImage alloc] initWithUIImage:image displayName:@"image.jpg"];
    [chatImage setImageOptions:options];
    EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithImage:chatImage thumbnailImage:nil];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:to bodies:[NSArray arrayWithObject:body]];
    message.requireEncryption = requireEncryption;
    message.messageType = messageType;
    message.ext = messageExt;
    EMMessage *retMessage = [[EaseMob sharedInstance].chatManager asyncSendMessage:message
                                                                          progress:progress];
    
    return retMessage;
}

+ (EMMessage *)sendVoiceMessageWithLocalPath:(NSString *)localPath
                                    duration:(NSInteger)duration
                                          to:(NSString *)to
                                 messageType:(EMMessageType)messageType
                           requireEncryption:(BOOL)requireEncryption
                                  messageExt:(NSDictionary *)messageExt
                                    progress:(id<IEMChatProgressDelegate>)progress
{
    EMChatVoice *chatVoice = [[EMChatVoice alloc] initWithFile:localPath displayName:@"audio"];
    chatVoice.duration = duration;
    EMVoiceMessageBody *body = [[EMVoiceMessageBody alloc] initWithChatObject:chatVoice];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:to bodies:[NSArray arrayWithObject:body]];
    message.requireEncryption = requireEncryption;
    message.messageType = messageType;
    message.ext = messageExt;
    EMMessage *retMessage = [[EaseMob sharedInstance].chatManager asyncSendMessage:message
                                                                          progress:progress];
    return retMessage;
}

+ (EMMessage *)sendVideoMessageWithURL:(NSURL *)url
                                    to:(NSString *)to
                           messageType:(EMMessageType)messageType
                     requireEncryption:(BOOL)requireEncryption
                            messageExt:(NSDictionary *)messageExt
                              progress:(id<IEMChatProgressDelegate>)progress
{
    EMChatVideo *chatVideo = [[EMChatVideo alloc] initWithFile:[url relativePath] displayName:@"video.mp4"];
    EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithChatObject:chatVideo];
    EMMessage *message = [[EMMessage alloc] initWithReceiver:to bodies:[NSArray arrayWithObject:body]];
    message.requireEncryption = requireEncryption;
    message.messageType = messageType;
    message.ext = messageExt;
    EMMessage *retMessage = [[EaseMob sharedInstance].chatManager asyncSendMessage:message
                                                                          progress:progress];
    
    return retMessage;
}

@end
