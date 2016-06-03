//
//  AppDelegate.m
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityLogger.h"
#import "MobClick.h"
#import "HMNagationController.h"
#import "CourseViewController.h"
#import "TeacherCenterController.h"
#import "APService.h"
#import "LoginViewController.h"
#import "EaseSDKHelper.h"
#import "ConversationListController.h"
#import "ProjectGuideView.h"
#import "UIDevice+JEsystemVersion.h"
#import "ScheduleViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import "AppDelegate+YJPush.h"
#import "YBStudentHomeController.h"
#import "JZMyController.h"

@interface AppDelegate ()<LoginViewControllerDelegate,IChatManagerDelegate>
{
    BOOL isReceiveMessage;
}
@property(nonatomic,strong)HMNagationController * navController;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) NSString *nameStr;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
    if (([UIDevice jeSystemVersion] > 7.99)&&
        ([UIDevice jeSystemVersion] < 9.001)) {
        
        //IOS8 需要 设置
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    LoginViewController * loginViewC = [[LoginViewController alloc] init];
    loginViewC.delegate = self;
    self.navController = [[HMNagationController alloc] initWithRootViewController:loginViewC];
    self.window.rootViewController =  self.navController;
    [self.window makeKeyAndVisible];
    
    [ProjectGuideView showViewWithDelegate:nil];

    if ([UserInfoModel isLogin]) {
        [self loginViewControllerdidLoginSucess:nil];
    }
    if([self isReciveFromHunaxin:launchOptions]){
        [self.navController jumpToMessageList];
    }
  
    return YES;
    
}

#pragma mark 配置百度地图
- (void)configBaiduMap {
    
    // 配置百度地图
    _mapManager = [BMKMapManager new];
    BOOL mapManagerStatus = [_mapManager start:baiduMapAppkey generalDelegate:nil];
    if (mapManagerStatus) {
        NSLog(@"mapManager OK");
        _locationService = [BMKLocationService new];
        [_locationService startUserLocationService];
    }else {
        NSLog(@"mapManager failed！");
    }
}

- (void)loginViewControllerdidLoginSucess:(LoginViewController *)controller
{
    
//    // 旧数据转换 (如果您的sdk是由2.1.2版本升级过来的，需要家这句话)
//    [[EaseMob sharedInstance].chatManager importDataToNewDatabase];
//    //获取数据库中数据
//    [[EaseMob sharedInstance].chatManager loadDataFromDatabase];

//    [[EaseMob sharedInstance].chatManager setApnsNickname:[UserInfoModel defaultUserInfo].name];

    NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    NSLog(@"loginViewControllerdidLoginSucess 获取聊天会话列表conversations:%@",conversations);
    
    [self.navController.navigationBar setHidden:NO];
    
    [self.navController pushViewController:[self getMainTabBar] animated:NO];
    
}

- (UITabBarController *)getMainTabBar
{
    // 预约
    UIImage * nCourse = [UIImage imageNamed:@"YBTabbarprogramme"];
    UIImage * hCourse = [UIImage imageNamed:@"YBTabbarprogramme_fill"];
    
    // 日程
    UIImage * tCourse = [UIImage imageNamed:@"YBTabbarstudent"];
    UIImage * HtCourse = [UIImage imageNamed:@"YBTabbarstudent_fill"];
    
    // 消息2
    UIImage * nMess = [UIImage imageNamed:@"YBTabbarmessage"];
    UIImage * HMess = [UIImage imageNamed:@"YBTabbarmessage_fill"];
    
    // 我
    UIImage * nUser = [UIImage imageNamed:@"YBTabbarmine"];
    UIImage * hUser = [UIImage imageNamed:@"YBTabbarmine_fill"];
    
    // 日程
    ScheduleViewController * ScheduleVc = [[ScheduleViewController alloc] init];
    
    // 学员
    YBStudentHomeController *studentVc = [[YBStudentHomeController alloc] init];

    // 消息
    ConversationListController * courList = [[ConversationListController alloc] init];
    
    // 我
//    TeacherCenterController * userCentertro = [[TeacherCenterController alloc] init];
    JZMyController * userCentertro = [[JZMyController alloc] init];
    
    return [self getTabWithTitleArray:@[@"日程",@"学员",@"消息",@"我的"] nimagesArray:@[nCourse,tCourse,nMess,nUser] himages:@[hCourse,HtCourse,HMess,hUser] andControllers:@[ScheduleVc,studentVc,courList,userCentertro]];
    
}

- (UITabBarController *)getTabWithTitleArray:(NSArray *)item nimagesArray:(NSArray *)nImages
                                     himages:(NSArray *)himages
                              andControllers:(NSArray*)controllers
{
    self.tabController = [[UITabBarController alloc] init];
    
    self.tabController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0x28/255.f green:0x79/255.f blue:0xf3/255.f alpha:1];
    
    for (int i =0; i < controllers.count;i++) {
        
        UIViewController * controller = [controllers objectAtIndex:i];
        UIImage * nimage = [nImages[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * himage = [himages[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem * tabItem = [[UITabBarItem alloc] initWithTitle:item[i] image:nimage selectedImage:himage];
        tabItem.tag = i;
        controller.tabBarItem = tabItem;
        
    }
    
    [self.tabController setViewControllers:controllers];
    
    [self.tabController setHidesBottomBarWhenPushed:YES];
    
    return self.tabController;
}

#pragma mark - 系统配置
- (void)sysConfigWithApplication:(UIApplication *)application LaunchOptions:(NSDictionary *)launchOptions
{
    // 百度地图
    [self configBaiduMap];
    
    //umeng统计
    [MobClick startWithAppkey:umengAppkey reportPolicy:BATCH   channelId:nil];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:easeMobAPPkey
                                       apnsCertName:easeMobPushName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    // 注册环信
    [self registerEaseMobNotification];
    
    //极光推送
    [APService
     registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                         UIUserNotificationTypeSound |
                                         UIUserNotificationTypeAlert)
     categories:nil];
    
    [APService setupWithOption:launchOptions];
    
    if ([UserInfoModel defaultUserInfo].userID) {
        NSString *coachID = [NSString stringWithFormat:@"%@",[UserInfoModel defaultUserInfo].driveschoolinfo[@"id"]];
        NSSet *set = [NSSet setWithObjects:JPushTag,coachID, nil];
        [APService setTags:set alias:[UserInfoModel defaultUserInfo].userID callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    }
    
}


#pragma mark - registerEaseMobNotification
- (void)registerEaseMobNotification{
    [self unRegisterEaseMobNotification];
    // 将self 添加到SDK回调中，以便本类可以收到SDK回调
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)unRegisterEaseMobNotification{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    NSLog(@"TagsAlias回调:%@", callbackString);
}

#pragma mark - Nofitication
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [APService registerDeviceToken:deviceToken];
    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMainChatMessage" object:self];
}
// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}
// 申请处理时间
- (void)applicationWillTerminate:(UIApplication *)application
{
    [[EaseMob sharedInstance] applicationWillTerminate:application];
}

//接受通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"%s userInfo:%@",__func__,userInfo);


    if ([self isReciveFromHunaxin:userInfo]) {
        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
        [self handleJPushNotification:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    //    ?????????????????????????????????????????   zyt   在前台是直接跳转到消息列表 ???????   以及同上的区别
    
    
    
#warning 当App在后台接受到消息推送,点击消息提醒,调用此方法
#warning 当App在前台接受到消息推送,调用此方法

    NSLog(@"%s userInfo:%@",__func__,userInfo);
    /*
     // 自定义消息
     {
     "_j_msgid" = 4122902527;
     aps =     {
         alert = "\U6d4b\U8bd5\U6559\U7ec3\U7aef\U63a8\U9001";
         badge = 1;
         sound = default;
     };
     type = 1;
     }
     // 接受到后台消息
     
     {
         "_j_msgid" = 1488777374;
         aps =     {
             alert = babababbaba;
             badge = 1;
             sound = default;
         };
         data = {
                reservationid = 11111
                userid = 554154544
         }
         type = "dasdsa"
     
     }
     
     */
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    if ([self isReciveFromHunaxin:userInfo]) {
        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
        [self handleJPushNotification:userInfo];
    }
}

- (BOOL)isReciveFromHunaxin:(NSDictionary *)dic
{
    return  [dic objectStringForKey:@"f"] &&
    [dic objectStringForKey:@"m"] &&
    [dic objectStringForKey:@"t"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)didReceiveMessage:(EMMessage *)message
{
    
    NSLog(@"didReceiveMessage message.messageBodies:%@",message.messageBodies);
    
    if (([UIApplication sharedApplication].applicationState == UIApplicationStateActive)&&([[NSUserDefaults standardUserDefaults] boolForKey:@"isInChatVc"])) {
        return;
    }
    
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    notification.alertBody = [NSString stringWithFormat:@"%@",@"你有一条新消息,快点击查看吧"];
    notification.alertAction = NSLocalizedString(@"确定", @"确定");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
        
    });
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount;
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"接收到环信推送通知UILocalNotification = %@",notification);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveMainChatMessage" object:self];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
