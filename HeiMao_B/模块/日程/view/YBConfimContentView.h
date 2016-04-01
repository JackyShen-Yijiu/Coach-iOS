//
//  YBConfimContentView.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBConfimContentView : UIView
@property (nonatomic,strong) UIViewController *parentViewController;
- (CGFloat)confimContentView:(NSArray *)dataArray;
@end
