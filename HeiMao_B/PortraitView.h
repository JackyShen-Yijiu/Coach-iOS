//
//  PortraitImageView.h
//  POIDemonConroller
//
//  Created by quke on 14-4-22.
//  Copyright (c) 2014年 quke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KPortraitViewContentModel) {
    KPortraitViewContentModelScaleToFill,               //放到填充，超出屏幕的会被截取 （默认）
    KPortraitViewContentModelScaleAndCenterToFill       //居中显示，图片超过屏幕时候压缩显示
};

@interface PortraitView : UIView

@property(strong,nonatomic)UIImageView * imageView;
@property(nonatomic,assign)KPortraitViewContentModel porContentModel;

- (void)setBackgroundImage:(UIImage *)image;

@end
