//
//  WMUIControlCreate.h
//  BlackCat
//
//  Created by bestseller on 15/9/28.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WMUITool : NSObject
+ (UILabel *)initWithTextColor:(UIColor *)textColor withFont:(UIFont *)textFont;

+ (UIButton *)initWithTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withTitleFont:(UIFont *)titleFont;

+ (UIImageView *)initWithImage:(UIImage *)image;
@end
