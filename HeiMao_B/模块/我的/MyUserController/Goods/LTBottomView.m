//
//  LTBottomView.m
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "LTBottomView.h"

@implementation LTBottomView

+ (LTBottomView *)instanceBottomView
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LTBottomView" owner:nil options:nil];
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
