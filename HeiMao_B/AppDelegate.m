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

@interface AppDelegate ()<LoginViewControllerDelegate>
@property(nonatomic,strong)HMNagationController * navController;
@property (nonatomic, strong) BMKLocationService *locationService;
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
    BOOL mapManagerStatus = [_mapManager start:@"AsrX0h3VNsqQOkYPXXrslrY8" generalDelegate:nil];
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
    
    [[EaseMob sharedInstance].chatManager removeAllConversationsWithDeleteMessages:YES append2Chat:NO];
    
    [self.navController.navigationBar setHidden:NO];
    
    [self.navController pushViewController:[self getMainTabBar] animated:NO];
    
}

- (UITabBarController *)getMainTabBar
{
    // 预约
    UIImage * nCourse = [UIImage imageNamed:@"order_normal"];
    UIImage * hCourse = [UIImage imageNamed:@"order_seleted"];
    
    // 日程
    UIImage * tCourse = [UIImage imageNamed:@"iconfont-riliricheng"];
    UIImage * HtCourse = [UIImage imageNamed:@"iconfont-rilirichengblue"];
    
    // 消息2
    UIImage * nMess = [UIImage imageNamed:@"im_normal"];
    UIImage * HMess = [UIImage imageNamed:@"im_seleted"];
    
    // 我
    UIImage * nUser = [UIImage imageNamed:@"user_normal"];
    UIImage * hUser = [UIImage imageNamed:@"user_seleted"];
    
    // 约车
    CourseViewController * courseContro = [[CourseViewController alloc] init];

    // 日程
    ScheduleViewController * ScheduleVc = [[ScheduleViewController alloc] init];
    
    // 消息
    ConversationListController * courList = [[ConversationListController alloc] init];
    
    // 我
    TeacherCenterController * userCentertro = [[TeacherCenterController alloc] init];
    
    return [self getTabWithTitleArray:@[@"约车",@"日程",@"消息",@"我的"] nimagesArray:@[nCourse,tCourse,nMess,nUser] himages:@[hCourse,HtCourse,HMess,hUser] andControllers:@[courseContro,ScheduleVc,courList,userCentertro]];
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
    [MobClick startWithAppkey:@"564dc12967e58ee280001457" reportPolicy:BATCH   channelId:nil];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    NSString *apnsCertName = nil;
    //#if DEBUG
    //    apnsCertName = @"modoujiaxiaoPushDev";
    //#else
    //    apnsCertName = @"modoujiaxiaoPushDis";
    //#endif
    
    
    NSString *EaseAppkey = nil;
    #if DEBUG
        EaseAppkey = @"black-cat#yibuxuecheprod";
    #else
        EaseAppkey = @"black-cat#yibuxuechetest";
    #endif
    
    
    apnsCertName = @"dis_apns";
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"black-cat#yibuxuecheprod"
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
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
    
#warning 当App在后台接受到消息推送,点击消息提醒,调用此方法
#warning 当App在前台接受到消息推送,调用此方法

    NSLog(@"%s userInfo:%@",__func__,userInfo);
    /*
     // 自定义消息
     {
       "_j_msgid" = 1488777374;
       aps =     {
          alert = babababbaba;
          badge = 1;
          sound = default;
       };
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

@end
