//
//  UserCenterHeadView.h
//  BlackCat
//
//  Created by bestseller on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserCenterHeadViewDelegte <NSObject>

- (void)userCenterClick;

@end
@interface UserCenterHeadView : UIView
@property ( strong, nonatomic) UIImageView *userPortrait;
@property ( strong, nonatomic) UILabel *userPhoneNum;// 姓名
@property ( strong, nonatomic) UILabel *userIdNum;// 电话
@property ( strong, nonatomic) UILabel *yNum;// Y码
@property ( strong, nonatomic) UIButton *arrowBtn;

@property ( weak, nonatomic) id<UserCenterHeadViewDelegte>delegate;
- (id)initWithFrame:(CGRect)frame withUserPortrait:(NSString *)image withUserPhoneNum:(NSString *)userPhoneNum withUserIdNum:(NSString *)userIdNum yNum:(NSString *)yNum;

@end
