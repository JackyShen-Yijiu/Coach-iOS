//
//  AppDelegate.h
//  HeiMao_B
//
//  Created by kequ on 15/10/24.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapKit/BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)UITabBarController * tabController;
@property (atomic, strong) BMKMapManager *mapManager;

@end

