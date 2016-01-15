//
//  StudentSignInStatusView.h
//  HeiMao_B
//
//  Created by 大威 on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentSignInStatusView : UIView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *okButton;

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                      message:(NSString *)message;

@end
