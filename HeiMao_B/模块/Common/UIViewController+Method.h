//
//  UIViewController+DivideAssett.h
//  SohuPhotoAlbum
//
//  Created by sohu on 13-4-27.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"

#define WRITEIMAGE @"WriteImage"

@interface UIViewController (Tips)
- (MBProgressHUD *)waitForMomentsWithTitle:(NSString*)str withView:(UIView *)view;
- (void)stopWaitProgressView:(MBProgressHUD *)view;
- (void)showPopAlerViewWithMes:(NSString *)message withDelegate:(id<UIAlertViewDelegate>)delegate cancelButton:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (void)showTotasViewWithMes:(NSString *)message;
- (void)showPopAlerViewWithMes:(NSString *)message;
@end

@interface UIViewController(NavTab)
- (UINavigationItem *)myNavigationItem;
- (UINavigationController *)myNavController;
- (UIButton*) createBackButton;
- (void)resetNavBar;
- (UIButton *)getBarButtonWithTitle:(NSString *)title;
- (UIBarButtonItem*)barSpaingItem;
- (void)showMessCountInTabBar:(NSInteger)mesCount;
- (void)hiddenMessCountInTabBar:(NSInteger)index;
@end


@interface UIViewController(MesList)
- (UITabBarController *)myTabBarcontroller;
- (void)jumpToMessageList;
@end


@interface UIViewController(AlertView)

@end

@interface UIViewController(Tolerance)
- (NSString *)strTolerance:(NSString *)str;
@end


@interface UIViewController(swizzling)

@end
