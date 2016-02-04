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
#import "UITabBar+RedHot.h"
#import <objc/runtime.h>
#import "MobClick.h"

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
    
    [[[self myNavController] navigationBar] setBarTintColor:RGB_Color(31, 124, 235)];
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16.f],
                                      NSForegroundColorAttributeName: [UIColor whiteColor]
                                      };    
    [[[self myNavController] navigationBar]  setTitleTextAttributes:textAttributes1];
    
}


- (UIButton *)getBarButtonWithTitle:(NSString *)title
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
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

-(UIButton*) createBackButton
{
    
    CGRect backframe= CGRectMake(0, 0, 40, 30);
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = backframe;
    
    [backButton setImage:[UIImage imageNamed:@"icon_back_page"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_page"] forState:UIControlStateHighlighted];    
    //定制自己的风格的  UIBarButtonItem
//    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return backButton;
    
}

- (void)navigationBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMessCountInTabBar:(NSInteger)mesCount
{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appdelegate.tabController tabBar] showBadgeOnItemIndex:2 withMessageCount:mesCount];
}

- (void)hiddenMessCountInTabBar
{
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[appdelegate.tabController tabBar] hideBadgeOnItemIndex:2];
}
@end

@implementation UIViewController(MesList)

- (UITabBarController *)myTabBarcontroller
{
    NSArray * controllers = [self.myNavController viewControllers];
    if (controllers.count >= 2) {
        UITabBarController * tabBarController = [controllers objectAtIndex:1];
        if ([tabBarController isKindOfClass:[UITabBarController class]]) {
            return tabBarController;
        }
    }
    return nil;

}
- (void)jumpToMessageList
{
    NSArray * controllers = [self.myNavController viewControllers];
    if (controllers.count >= 2) {
        UITabBarController * tabBarController = [controllers objectAtIndex:1];
        if ([tabBarController isKindOfClass:[UITabBarController class]]) {
            [tabBarController setSelectedIndex:2];
        }
    }
}
@end

@implementation UIViewController(AlertView)
@end

@implementation UIViewController(Tolerance)

- (NSString *)strTolerance:(NSString *)str
{
    if (![str isKindOfClass:[NSString class]] || !str.length) {
        return @"";
    }
    return str;
}

@end


@implementation UIViewController (swizzling)

+(void)load
{
    [super load];
    
    // 通过class_getInstanceMethod函数从当前对象中的methodlist中获取method结构体，如果是类方法就使用class_getClassMethod(<#__unsafe_unretained Class cls#>, <#SEL name#>)
    
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    
    // 使用class_addMethod函数对method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败
    // 而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果。
    // 在这里通过class_addMethod的验证，如果self实现了这个方法，class_addMethod函数将会返回No,我们就可以对其进行交换了；
    if (!class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        
        method_exchangeImplementations(fromMethod, toMethod);
        
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"页面出现viewWillAppear:%@",self.class);
    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@",self.class]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"页面消失viewWillAppear:%@",self.class);
    [MobClick endLogPageView:[NSString stringWithFormat:@"%@",self.class]];

}

- (void)swizzlingViewDidLoad
{
    
    NSString *str = [NSString stringWithFormat:@"%@",self.class];
    if (![str containsString:@"UI"]) {// 剔除系统UI控制器
        NSLog(@"YJG统计打点:%@",self.class);
   
    }
    [self swizzlingViewDidLoad];
}



@end