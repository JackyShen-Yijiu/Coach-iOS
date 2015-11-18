//
//  WMUIControlCreate.m
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "WMUITool.h"

@implementation WMUITool
+ (UILabel *)initWithTextColor:(UIColor *)textColor withFont:(UIFont *)textFont {
    UILabel *wmLabel = [[UILabel alloc] init];
    wmLabel.text = @"";
    wmLabel.font = textFont;
    wmLabel.textColor = textColor;
    return wmLabel;
}

+ (UIButton *)initWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withTitleFont:(UIFont *)titleFont {
    UIButton *wmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wmBtn.titleLabel.font  = titleFont;
    [wmBtn setTitle:title forState:UIControlStateNormal];
    [wmBtn setTitleColor:titleColor forState:UIControlStateNormal];
    return wmBtn;
}
+ (UIImageView *)initWithImage:(UIImage *)image {
    UIImageView *wmImageView = [[UIImageView alloc] init];
    if (!image) {
        wmImageView.image = image;
    }
    return wmImageView;
}

@end
