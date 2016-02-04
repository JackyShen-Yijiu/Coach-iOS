//
//  DVVToast.h
//  DVVDemo
//
//  Created by 大威 on 16/1/21.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVToast : UIView

@property (nonatomic, copy) NSString *toastType;

+ (void)show;
+ (void)hide;

+ (void)showFromView:(UIView *)superView;
+ (void)showFromView:(UIView *)superView OffSetY:(CGFloat)offSetY;
+ (void)hideFromView:(UIView *)superView;

+ (void)showMessage:(NSString *)message;
+ (void)showMessage:(NSString *)message view:(UIView *)superView;

@end
