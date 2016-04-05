//
//  MyHeaderView.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^signatureImageViewGasBlock)(); // 编辑设置

@interface MyHeaderView : UIView
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *topImgView;

@property (nonatomic, strong) UIImageView *bottomImgView;

//@property (nonatomic, strong) UILabel *nameLable;



@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *schoolLabel;

@property (nonatomic, strong) UILabel *yLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, copy) signatureImageViewGasBlock signtureImageGas;
- (id)initWithFrame:(CGRect)frame
   withUserPortrait:(NSString *)image
   withUserPhoneNum:(NSString *)schoolName
           withYNum:(NSString *)yNum;
@end
