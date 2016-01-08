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
      withUserIdNum:(NSString *)userIdNum yNum:(NSString *)yNum{
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
        [self addGesture];
        
        if (image) {
            [_userPortrait sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
        _userPhoneNum.text = userPhoneNum;
        _userIdNum.text = userIdNum;
        _yNum.text = yNum;

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
    
    // 头像
    _userPortrait = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.calculateFrameWithHeight/2-60/2, 60, 60)];
    _userPortrait.backgroundColor = [UIColor cyanColor];
    _userPortrait.image = [UIImage imageNamed:@"littleImage.png"];
    [self addSubview:_userPortrait];
    
    // 电话号码
    _userPhoneNum = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, self.calculateFrameWithWide-100, 20)];
    _userPhoneNum.textColor = [UIColor blackColor];
    _userPhoneNum.font = [UIFont systemFontOfSize:16];
    [self addSubview:_userPhoneNum];
    
    // 用户ID
    _userIdNum = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, self.calculateFrameWithWide-100, 25)];
    _userIdNum.textColor = TEXTGRAYCOLOR;
    _userIdNum.font = [UIFont systemFontOfSize:13];
    [self addSubview:_userIdNum];
    
    // Y码
    _yNum = [[UILabel alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(_userIdNum.frame)-3, self.calculateFrameWithWide-100, 20)];
    _yNum.textColor = TEXTGRAYCOLOR;
    _yNum.font = [UIFont systemFontOfSize:13];
    [self addSubview:_yNum];
    
    // 箭头
    _arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-22-12, self.calculateFrameWithHeight/2-22/2, 22, 22)];
    _arrowBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    _arrowBtn.backgroundColor = [UIColor clearColor];
    _arrowBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"arrowBtnImg"]];
    [_arrowBtn addTarget:self action:@selector(arrowBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_arrowBtn];
    
}

- (void)arrowBtnDidClick
{
    if ([_delegate respondsToSelector:@selector(userCenterClick)]) {
        [_delegate userCenterClick];
    }
}

@end
