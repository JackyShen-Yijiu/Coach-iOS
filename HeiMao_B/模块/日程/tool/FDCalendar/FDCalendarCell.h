//
//  FDCalendarCell.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/26.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDCalendarCell : UICollectionViewCell

- (UIView *)selectView;
- (UILabel *)dayLabel;
- (UILabel *)chineseDayLabel;
- (UILabel *)pointView;
- (UILabel *)restLabel;
- (UIView *)lineView;

@end
