//
//  UIBarButtonItem+JGBarButtonItem.h
//  studentDriving
//
//  Created by yyx on 15/12/31.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JGBarButtonItem)

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title highTitle:(NSString *)highTitle target:(id)target action:(SEL)action isRightItem:(BOOL)isRightItem;
@end
