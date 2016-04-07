//
//  JZNoDataShowBGView.h
//  HeiMao_B
//
//  Created by ytzhang on 16/4/7.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZNoDataShowBGView : UIView

// 要显示的图片
@property (nonatomic, strong) NSString *imgStr;

// 要显示的文字
@property (nonatomic, strong) NSString *titleStr;

// 文字大小
@property (nonatomic, assign) CGFloat fontSize;

// 文字颜色
@property (nonatomic, strong) UIColor *titleColor;


@end
