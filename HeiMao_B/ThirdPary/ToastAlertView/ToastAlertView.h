//
//  ToastAlertView.h
//  JewelryApp
//
//  Created by kequ on 15/5/3.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToastAlertView : UIView

{
    UIImageView *_alertboxImageView;
    UILabel *_title;
    __weak UIViewController * _controller;
}

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title controller:(id)viewcontroller;
- (void)show;

@end
