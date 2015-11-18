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
@property ( strong, nonatomic) UILabel *userPhoneNum;
@property ( strong, nonatomic) UILabel *userIdNum;
@property ( weak, nonatomic) id<UserCenterHeadViewDelegte>delegate;
- (id)initWithFrame:(CGRect)frame withUserPortrait:(NSString *)image withUserPhoneNum:(NSString *)userPhoneNum withUserIdNum:(NSString *)userIdNum;

@end
