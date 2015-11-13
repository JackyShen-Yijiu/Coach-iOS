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

@interface AppDelegate ()
@property(nonatomic,strong)HMNagationController * navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[HMNagationController alloc] initWithRootViewController:[self getMainTabBar]];
    
    [UserInfoModel defaultUserInfo];
    
    if (![UserInfoModel isLogin]) {
        LoginViewController *login = [[LoginViewController alloc] init];
        [self.window.rootViewController presentViewController:login animated:YES completion:nil];
    }
    return YES;
    
    
}

- (UITabBarController *)getMainTabBar
{
    UIImage * nCourse = [UIImage imageNamed:@"order_normal"];
    UIImage * hCourse = [UIImage imageNamed:@"order_seleted"];
    UIImage * nUser = [UIImage imageNamed:@"user_normal"];
    UIImage * hUser = [UIImage imageNamed:@"user_seleted"];
    CourseViewController * courseContro = [[CourseViewController alloc] init];
    TeacherCenterController * userCentertro = [[TeacherCenterController alloc] init];
    return [self getTabWithTitleArray:@[@"预约",@"我的"] nimagesArray:@[nCourse,nUser] himages:@[hCourse,hUser] andControllers:@[courseContro,userCentertro]];
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
    //umeng统计
    [MobClick startWithAppkey:@"5635edcce0f55a2280003548" reportPolicy:BATCH   channelId:@"蒲公英"];
    
    //AFNet log显示
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    //环信
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                            appkey:@"easemob-demo#chatdemoui"
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    //极光推送
    [APService
     registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                         UIUserNotificationTypeSound |
                                         UIUserNotificationTypeAlert)
     categories:nil];
    
    [APService setupWithOption:launchOptions];
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
    // Required
    [APService handleRemoteNotification:userInfo];
}
@end
