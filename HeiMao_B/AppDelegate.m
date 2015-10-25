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
#import "OrderViewController.h"
#import "UserCenterController.h"


@interface AppDelegate ()
@property(nonatomic,strong)HMNagationController * navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [MobClick startWithAppkey:@"55a4d82f67e58eeece0038be" reportPolicy:BATCH   channelId:@"蒲公英"];
    
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[HMNagationController alloc] initWithRootViewController:[self getMainTabBar]];
    

    return YES;
}

- (UITabBarController *)getMainTabBar
{
    UIImage * nOrder = [UIImage imageNamed:@"order_normal"];
    UIImage * hOrder = [UIImage imageNamed:@"order_seleted"];
    UIImage * nUser = [UIImage imageNamed:@"user_normal"];
    UIImage * hUser = [UIImage imageNamed:@"user_seleted"];
    OrderViewController * orderContro = [[OrderViewController alloc] init];
    UserCenterController * userCentertro = [[UserCenterController alloc] init];
    return [self getTabWithTitleArray:@[@"预约",@"我的"] nimagesArray:@[nOrder,nUser] himages:@[hOrder,hUser] andControllers:@[orderContro,userCentertro]];
}

- (UITabBarController *)getTabWithTitleArray:(NSArray *)item nimagesArray:(NSArray *)nImages
                                     himages:(NSArray *)himages
                              andControllers:(NSArray*)controllers
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0x28/255.f green:0x79/255.f blue:0xf3/255.f alpha:1];
    for (int i =0; i < controllers.count;i++) {
        UIViewController * controller = [controllers objectAtIndex:i];
        UIImage * nimage = [nImages[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage * himage = [himages[i] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem * tabItem = [[UITabBarItem alloc] initWithTitle:item[i] image:nimage selectedImage:himage];
        tabItem.tag = i;
        controller.tabBarItem = tabItem;
    }
    [tabBarController setViewControllers:controllers];
    [tabBarController setHidesBottomBarWhenPushed:YES];
    return tabBarController;
}

@end
