//
//  UserCenterHeadView.m
//  BlackCat
//
//  Created by bestseller on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "UserCenterHeadView.h"
#import "UIView+CalculateUIView.h"

#define TEXTGRAYCOLOR [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1]

@interface UserCenterHeadView ()
@end
@implementation UserCenterHeadView

- (id)initWithFrame:(CGRect)frame
   withUserPortrait:(NSString *)image
   withUserPhoneNum:(NSString *)userPhoneNum
      withUserIdNum:(NSString *)userIdNum {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
        [self addGesture];
        
        if (image) {
            [_userPortrait sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
        _userPhoneNum.text = userPhoneNum;
        _userIdNum.text = userIdNum;
        

    }
    return self;
}
- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap:)];
    [self addGestureRecognizer:tap];
}
- (void)clickTap:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(userCenterClick)]) {
        [_delegate userCenterClick];
    }
}
- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    _userPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.calculateFrameWithHeight/2-60/2, 60, 60)];
    _userPortrait.backgroundColor = [UIColor cyanColor];
    _userPortrait.image = [UIImage imageNamed:@"littleImage.png"];
    [self addSubview:_userPortrait];
    
    _userPhoneNum = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, self.calculateFrameWithWide-100, 30)];
    _userPhoneNum.textColor = [UIColor blackColor];
    _userPhoneNum.font = [UIFont systemFontOfSize:16];
    [self addSubview:_userPhoneNum];
    
    _userIdNum = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, self.calculateFrameWithWide-100, 30)];
    _userIdNum.textColor = TEXTGRAYCOLOR;
    _userIdNum.font = [UIFont systemFontOfSize:13];
    [self addSubview:_userIdNum];
    
}


@end
