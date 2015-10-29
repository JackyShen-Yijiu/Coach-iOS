//
//  UITabBar+RedHot.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (RedHot)
- (void)showBadgeOnItemIndex:(NSInteger)index withMessageCount:(NSInteger)count;
- (void)hideBadgeOnItemIndex:(NSInteger)index;
@end
