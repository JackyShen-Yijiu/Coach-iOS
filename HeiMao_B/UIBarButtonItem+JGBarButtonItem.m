//
//  UIBarButtonItem+JGBarButtonItem.m
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "UIBarButtonItem+JGBarButtonItem.h"

@implementation UIBarButtonItem (JGBarButtonItem)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title highTitle:(NSString *)highTitle target:(id)target action:(SEL)action isRightItem:(BOOL)isRightItem
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:highTitle forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    CGFloat itemX = 0.0;
    CGFloat itemW = [title sizeWithFont:[UIFont systemFontOfSize:14]].width;
    CGFloat itemH = 44;
    if (isRightItem==YES) {
        itemX = 10+5;
        button.titleLabel.textAlignment = NSTextAlignmentRight;
    }else{
        itemX = -10-5;
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    button.frame = CGRectMake(itemX, 8, itemW, itemH);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    CGFloat itemW = button.currentBackgroundImage.size.width;
    CGFloat itemH = button.currentBackgroundImage.size.height;
    button.frame = CGRectMake(0, 6, itemW, itemH);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIView *buview = [[UIView alloc] init];
    buview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [buview addGestureRecognizer:tap];
    buview.backgroundColor = [UIColor clearColor];
    buview.frame = CGRectMake(0, 0, itemW, itemH+10);
    [buview addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buview];
}

@end
