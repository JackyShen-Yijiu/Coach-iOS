//
//  UIViewController+DivideAssett.m
//  SohuPhotoAlbum
//
//  Created by sohu on 13-4-27.
//  Copyright (c) 2013年 Qu. All rights reserved.
//

#import "UIViewController+Method.h"
#import <Accelerate/Accelerate.h>
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "ToastAlertView.h"

@implementation UIViewController(Tips)
- (MBProgressHUD *)waitForMomentsWithTitle:(NSString*)str withView:(UIView *)view
{
    if (!view) {
        view = [[[UIApplication sharedApplication] delegate] window];
    }
    MBProgressHUD * progressView = [[MBProgressHUD alloc] initWithView:view];
    progressView.animationType = MBProgressHUDAnimationZoomOut;
    progressView.labelText = str;
    [view addSubview:progressView];
    [progressView show:YES];
    return progressView;
}
-(void)stopWaitProgressView:(MBProgressHUD *)view
{
    if (view){
        [view removeFromSuperview];
    }
    else{
        for (UIView * view in self.view.subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
        for (UIView * view in [[[UIApplication sharedApplication] delegate] window].subviews) {
            if ([view isKindOfClass:[MBProgressHUD class]]) {
                [view removeFromSuperview];
            }
        }
    }
        
}

- (void)showPopAlerViewWithMes:(NSString *)message withDelegate:(id<UIAlertViewDelegate>)delegate cancelButton:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIAlertView * popA = [[UIAlertView alloc] initWithTitle:nil message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles, nil];
    [popA show];
}

- (void)showTotasViewWithMes:(NSString *)message
{
    if(!message || ![message isKindOfClass:[NSString class]] || ![message length]) return;
    if (self.tabBarController) {
        if([self.myNavController topViewController] != self.tabBarController) return;
    }else{
        if([self.myNavController topViewController] != self) return;
    }

    ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:message];
    [alertView show];
}

- (void)showPopAlerViewWithMes:(NSString *)message
{
    [self showPopAlerViewWithMes:message withDelegate:nil cancelButton:@"确定" otherButtonTitles:nil];
}

@end

@implementation UIViewController(NavTab)

- (UINavigationItem *)myNavigationItem
{
    if (self.tabBarController) {
        return self.tabBarController.navigationItem;
    }
    return self.navigationItem;
}

- (UINavigationController *)myNavController
{
    if (self.tabBarController) {
        return self.tabBarController.navigationController;
    }
    return self.navigationController;
}

- (void)resetNavBar
{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    
    [[[self myNavController] navigationBar] setBarTintColor:[UIColor colorWithRed:0 green:172/255.f blue:87/255.f alpha:1]];
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                      };
    
    [[[self myNavController] navigationBar]  setTitleTextAttributes:textAttributes1];
}


- (UIButton *)getBarButtonWithTitle:(NSString *)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 60, 34);
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [[button titleLabel] setFont:[UIFont systemFontOfSize:15.f]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (UIBarButtonItem*)barSpaingItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       
                                       target:nil action:nil];
    negativeSpacer.width = -12;
    return negativeSpacer;
}


- (UIButton *)myLeftButton
{
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 60, 34);
    backButton.tag = 200;
    return backButton;
}


- (void)navigationBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
