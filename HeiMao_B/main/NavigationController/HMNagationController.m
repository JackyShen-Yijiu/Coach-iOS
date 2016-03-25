//
//  BMJWNagationController.m
//  JewelryApp
//
//  Created by kequ on 15/6/7.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "HMNagationController.h"

@interface HMNagationController()<UINavigationControllerDelegate>
@property(nonatomic,assign)BOOL isAnimaiton;
@end

@implementation HMNagationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self;
        self.isAnimaiton = NO;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    if(self.isAnimaiton){
        return;
    }
    @try {
        [super pushViewController:viewController animated:animated];
        [viewController.navigationItem setHidesBackButton:YES];
        if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 2)
            
        {
            viewController.navigationItem.leftBarButtonItems = @[[self barSpaingItem],[self createBackButton]];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    @try {
        UIViewController * controller = [super popViewControllerAnimated:animated];
        [controller.navigationItem setHidesBackButton:YES];
        return controller;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

- (BOOL)isAnimaiton
{
    return _isAnimaiton;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if(self.isAnimaiton){
        return nil;
    }
    return [super popToRootViewControllerAnimated:animated];
}

-(void)popself
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SELFBACK" object:nil];
    [self popViewControllerAnimated:YES];
}

-(UIBarButtonItem*) createBackButton
{
    
    CGRect backframe= CGRectMake(0, 0, 40, 30);
    
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = backframe;

    [backButton setImage:[UIImage imageNamed:@"icon_back_page"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"icon_back_page"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
}

#pragma mark - 
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(animated)
        self.isAnimaiton = YES;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.isAnimaiton = NO;
}

@end
