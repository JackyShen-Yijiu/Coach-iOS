//
//  JGvalidationView.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGvalidationView.h"

@implementation JGvalidationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB_Color(31, 124, 235);
        self.alpha = 0.5;
        
        UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
        alphaView.backgroundColor = [UIColor clearColor];
        [self addSubview:alphaView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.width-10, self.height-40)];
        label.text = @"您提交的资料尚未通过审核，\n暂时还不能开展业务";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        
    }
    return self;
}


@end
