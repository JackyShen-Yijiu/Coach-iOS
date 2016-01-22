//
//  JGBaseViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/22.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGBaseViewController.h"

@interface JGBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation JGBaseViewController

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"self.myNavController.viewControllers.count:%d",self.myNavController.viewControllers.count);
    
    if (self.myNavController.viewControllers.count==2) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear self.myNavController.viewControllers.count:%d",self.myNavController.viewControllers.count);

    self.myNavController.interactivePopGestureRecognizer.delegate = self;

}
@end
