//
//  UITabBar+RedHot.m
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "UITabBar+RedHot.h"
#define TabbarItemNums  3

@implementation UITabBar (RedHot)


- (void)showBadgeOnItemIndex:(NSInteger)index withMessageCount:(NSInteger)count
{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UILabel *badgeView = [[UILabel alloc]init];
    badgeView.textColor = [UIColor whiteColor];
    badgeView.text = [NSString stringWithFormat:@"%lu",count];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 5;//圆形
    badgeView.layer.masksToBounds = YES;
    badgeView.textAlignment = NSTextAlignmentCenter;
    badgeView.font = [UIFont systemFontOfSize:8];
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width) - 3;
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);//圆形大小为10
    [self addSubview:badgeView];
    [badgeView sizeToFit];
    badgeView.width += 4;
    if (badgeView.width > 24) {
        badgeView.width = 24;
    }
    badgeView.frame = CGRectMake(x, y, badgeView.width, 10);//圆形大小为10

}

- (void)removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

- (void)hideBadgeOnItemIndex:(NSInteger)index
{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

@end
