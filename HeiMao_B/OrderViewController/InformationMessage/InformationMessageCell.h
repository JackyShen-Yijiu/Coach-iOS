//
//  InformationMessageCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationMessageModel.h"

@interface InformationMessageCell : UITableViewCell
@property (nonatomic, strong) InformationMessageModel *informationMessageModel;

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *detailBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *contentTitleLabel;
@property (nonatomic, strong) UILabel *detailLabel;


- (CGFloat)heightWithcell:(InformationMessageModel *)tableView;

@end
