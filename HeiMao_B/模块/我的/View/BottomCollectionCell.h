//
//  BottomCollectionCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomCollectionCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isNoShowLabel;

@property (nonatomic,strong) UILabel *badegLabel;

@end
