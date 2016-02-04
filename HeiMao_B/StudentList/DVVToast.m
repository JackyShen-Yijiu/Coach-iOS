//
//  DVVToast.m
//  DVVDemo
//
//  Created by 大威 on 16/1/21.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVToast.h"

#define DVV_MESSAGE_DEFAULT_HEIGHT 40
#define DVV_MESSAGE_FONT [UIFont systemFontOfSize:14]
#define DVV_MESSAGE_TOP_MARGIN 10
#define DVV_MESSAGE_LEFT_MARGIN 12
#define DVV_MESSAGE_CORNER_RADIUS 7

#define DVV_ANIMATE_DURATION 0.2
#define DVV_LOADING_SIDE_WIDTH 70
#define DVV_LOADING_CORNER_RADIUS 10

#define DVV_TOAST_TYPE_LOADING @"dvv_type_loading"
#define DVV_TOAST_TYPE_MESSAGE @"dvv_type_message"

@implementation DVVToast

+ (void)show {
    [self showFromView:[UIApplication sharedApplication].keyWindow];
}
+ (void)hide {
    [self hideFromView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showFromView:(UIView *)superView {
    
    [self showFromView:superView OffSetY:0];
}
+ (void)showFromView:(UIView *)superView OffSetY:(CGFloat)offSetY {
    
    // 如果已经存在则不再添加
    for (UIView *itemView in superView.subviews) {
        if ([itemView isKindOfClass:[DVVToast class]] &&
            [((DVVToast *)itemView).toastType isEqualToString:DVV_TOAST_TYPE_LOADING]) {
            return ;
        }
    }
    DVVToast *toastView = [DVVToast new];
    toastView.toastType = DVV_TOAST_TYPE_LOADING;
    toastView.frame = CGRectMake(0, 0, DVV_LOADING_SIDE_WIDTH, DVV_LOADING_SIDE_WIDTH);
    [toastView.layer setMasksToBounds:YES];
    [toastView.layer setCornerRadius:DVV_LOADING_CORNER_RADIUS];
    toastView.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f + offSetY);
    toastView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    UIActivityIndicatorView *activityView = [UIActivityIndicatorView new];
    activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityView.center = CGPointMake(DVV_LOADING_SIDE_WIDTH / 2.f, DVV_LOADING_SIDE_WIDTH / 2.f);
    
    [toastView addSubview:activityView];
    [activityView startAnimating];
    toastView.alpha = 0;
    [superView addSubview:toastView];
    [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
        toastView.alpha = 1;
    }];
}
+ (void)hideFromView:(UIView *)superView {
    
    for (UIView *itemView in superView.subviews) {
        
        if ([itemView isKindOfClass:[DVVToast class]] && [((DVVToast *)itemView).toastType isEqualToString:DVV_TOAST_TYPE_LOADING]) {
            
            [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
                itemView.alpha = 0;
            } completion:^(BOOL finished) {
                [itemView removeFromSuperview];
                
                return ;
            }];
        }
    }
}

+ (void)showMessage:(NSString *)message {
    
    [self showMessage:message view:[UIApplication sharedApplication].keyWindow];
}
+ (void)showMessage:(NSString *)message view:(UIView *)superView {
    
    DVVToast *messageView = [DVVToast new];
    messageView.toastType = DVV_TOAST_TYPE_MESSAGE;
    messageView.clipsToBounds = YES;
    [messageView.layer setMasksToBounds:YES];
    [messageView.layer setCornerRadius:DVV_MESSAGE_CORNER_RADIUS];
    messageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    
    CGFloat testWidth = [self autoWidthWithString:message font:DVV_MESSAGE_FONT];
    CGFloat messageViewMaxWidth = superView.bounds.size.width - DVV_MESSAGE_LEFT_MARGIN * 2;
    CGFloat labelMaxWidth = messageViewMaxWidth - DVV_MESSAGE_LEFT_MARGIN * 2;
    
    UILabel *label = [UILabel new];
    label.font = DVV_MESSAGE_FONT;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.text = message;

    if (testWidth <= messageViewMaxWidth - DVV_MESSAGE_LEFT_MARGIN * 2) {
        messageView.frame = CGRectMake(0, 0, testWidth + DVV_MESSAGE_LEFT_MARGIN * 2, DVV_MESSAGE_DEFAULT_HEIGHT);
        label.frame = CGRectMake(0, 0, testWidth, DVV_MESSAGE_DEFAULT_HEIGHT);
    }else {
        CGFloat testHeight = [self autoHeightWithString:message width:labelMaxWidth Font:DVV_MESSAGE_FONT];
        messageView.frame = CGRectMake(0, 0, messageViewMaxWidth, testHeight + DVV_MESSAGE_TOP_MARGIN * 2);
        label.frame = CGRectMake(0, 0, labelMaxWidth, testHeight);
    }
    messageView.center = CGPointMake(superView.bounds.size.width / 2.f, superView.bounds.size.height / 2.f);
    label.center = CGPointMake(messageView.bounds.size.width / 2.f, messageView.bounds.size.height / 2.f);
    
    [messageView addSubview:label];
    messageView.alpha = 0;
    [superView addSubview:messageView];
    [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
        messageView.alpha = 1;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:DVV_ANIMATE_DURATION animations:^{
            messageView.alpha = 0;
        } completion:^(BOOL finished) {
            [messageView removeFromSuperview];
        }];
    });
}

+ (CGFloat)autoHeightWithString:(NSString *)string width:(CGFloat)width Font:(UIFont *)font {
    
    CGSize boundRectSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.height;
    return newFloat;
}

+ (CGFloat)autoWidthWithString:(NSString *)string font:(UIFont *)font {
    
    CGSize boundRectSize = CGSizeMake(MAXFLOAT, font.lineHeight);
    NSDictionary *fontDict = @{ NSFontAttributeName: font };
    CGFloat newFloat = [string boundingRectWithSize:boundRectSize
                                            options: NSStringDrawingUsesLineFragmentOrigin
                        | NSStringDrawingUsesFontLeading
                                         attributes:fontDict context:nil].size.width;
    return newFloat;
}

@end
