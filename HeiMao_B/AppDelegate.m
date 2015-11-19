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

@interface AppDelegate ()<LoginViewControllerDelegate>
@property(nonatomic,strong)HMNagationController * navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    LoginViewController * loginViewC = [[LoginViewController alloc] init];
    loginViewC.delegate = self;
    self.navController = [[HMNagationController alloc] initWithRootViewController:loginViewC];
    self.window.rootViewController =  self.navController;
    [self.window makeKeyAndVisible];
    if ([UserInfoModel isLogin]) {
        [self loginViewControllerdidLoginSucess:nil];
    }
    if([self isReciveFromHunaxin:launchOptions]){
        [self.navController jumpToMessageList];
    }
    [self sysConfigWithApplication:application LaunchOptions:launchOptions];

    return YES;

}

- (void)loginViewControllerdidLoginSucess:(LoginViewController *)controller
{
    [self.navController.navigationBar setHidden:NO];
    [self.navController pushViewController:[self getMainTabBar] animated:NO];
}

- (UITabBarController *)getMainTabBar
{
    UIImage * nCourse = [UIImage imageNamed:@"order_normal"];
    UIImage * hCourse = [UIImage imageNamed:@"order_seleted"];
    UIImage * nMess = [UIImage imageNamed:@"im_normal"];
    UIImage * HMess = [UIImage imageNamed:@"im_seleted"];
    UIImage * nUser = [UIImage imageNamed:@"user_normal"];
    UIImage * hUser = [UIImage imageNamed:@"user_seleted"];
    
    CourseViewController * courseContro = [[CourseViewController alloc] init];
    ConversationListController * courList = [[ConversationListController alloc] init];
    TeacherCenterController * userCentertro = [[TeacherCenterController alloc] init];
    return [self getTabWithTitleArray:@[@"预约",@"消息",@"我的"] nimagesArray:@[nCourse,nMess,nUser] himages:@[hCourse,HMess,hUser] andControllers:@[courseContro,courList,userCentertro]];
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
    if ([self isReciveFromHunaxin:userInfo]) {
        [self.navController jumpToMessageList];
    }else{
        [APService handleRemoteNotification:userInfo];
    }
}

- (BOOL)isReciveFromHunaxin:(NSDictionary *)dic
{
    return  [dic objectStringForKey:@"f"] &&
            [dic objectStringForKey:@"m"] &&
            [dic objectStringForKey:@"t"];
}

@end
