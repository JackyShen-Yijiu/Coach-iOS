//
//  LKAddStudentNoDataView.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
/// 没有数据时候显示的大View
@interface LKAddStudentNoDataView : UIView

/// 没有数据时显示的图片
@property (nonatomic, weak) UIImageView *noDataImageView;
/// 没有数据时显示的Label
@property (nonatomic, weak) UILabel *noDataLabel;

@end
