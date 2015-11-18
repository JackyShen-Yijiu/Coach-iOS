//
//  LTNavigationView.m
//  Magic
//
//  Created by ytzhang on 15/11/10.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "LTNavigationView.h"

@implementation LTNavigationView

+ (LTNavigationView *)instanceBottomView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LTNavigationView" owner:nil options:nil];
    return [nibView lastObject];
}


// 如果你要加点什么东西  就重载 initWithCoder
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        //you init
    }
    return self;
}

@end
