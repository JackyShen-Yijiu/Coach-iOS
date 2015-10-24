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

@interface AppDelegate ()
@property(nonatomic,strong)HMNagationController * navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [MobClick startWithAppkey:@"55a4d82f67e58eeece0038be" reportPolicy:BATCH   channelId:@"蒲公英"];
    
    AFNetworkReachabilityManager *  manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [[AFNetworkActivityLogger sharedLogger] startLogging];

    [self setDefoultNavBarStyle];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    
    return YES;
}


- (void)setDefoultNavBarStyle
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:0 blue:87/255.f alpha:1]];
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                      };
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes1];
    
}

//- (UITabBarController *)getMainTabBar
//{
//    UIImage * nExp = [UIImage imageNamed:@"tab_explore"];
//    UIImage * hExp = [UIImage imageNamed:@"tab_explore_press"];
//    UIImage * nFeed = [UIImage imageNamed:@"tab_feed"];
//    UIImage * hFeed = [UIImage imageNamed:@"tab_feed_press"];
//    
//}

- (UITabBarController *)getTabWithTitleArray:(NSArray *)item nimagesArray:(NSArray *)nImages
                                     himages:(NSArray *)himages
                              andControllers:(NSArray*)controllers
{
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.tabBar.selectedImageTintColor = [UIColor colorWithRed:0x35/255.f green:0xb3/255.f blue:0x64/255.f alpha:1];
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
