//
//  LoginViewController.h
//  BlackCat
//
//  Created by 董博 on 15/9/3.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>
- (void)loginViewControllerdidLoginSucess:(LoginViewController *)controller;
@end
@interface LoginViewController : UIViewController
@property(nonatomic,weak)id<LoginViewControllerDelegate>delegate;
@end
