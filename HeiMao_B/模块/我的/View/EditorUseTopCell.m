//
//  EditorUseTopCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/26.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "EditorUseTopCell.h"

@interface EditorUseTopCell ()


@end

@implementation EditorUseTopCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle =  UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.iconImgeView];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.arrowImageView];
}
- (void)layoutSubviews{
    [self.iconImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);

        if (YBIphone6Plus) {
            
            make.width.mas_equalTo(48* JZRatio_1_1_5);
            make.height.mas_equalTo(48 * JZRatio_1_1_5);

        }else {
            make.width.mas_equalTo(@48);
            make.height.mas_equalTo(@48);

        }
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        
        if (YBIphone6Plus) {
            
            make.width.mas_equalTo(8 * JZRatio_1_1_5);
            make.height.mas_equalTo(14 * JZRatio_1_1_5);
            
        }else {
            
            make.width.mas_equalTo(@8);
            make.height.mas_equalTo(@14);
        }

    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.arrowImageView.mas_left).offset(-8);
        make.height.mas_equalTo(@12);
    }];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)iconImgeView{
    if (_iconImgeView == nil) {
        _iconImgeView = [[UIImageView alloc] init];
        _iconImgeView.image = [UIImage imageNamed:@"littleImage"];
        _iconImgeView.backgroundColor = [UIColor clearColor];
        _iconImgeView.layer.masksToBounds = YES;
        
        if (YBIphone6Plus) {
            _iconImgeView.layer.cornerRadius = 24 *JZRatio_1_1_5;

        }else {
            
            _iconImgeView.layer.cornerRadius = 24;

        }
        
    }
    return _iconImgeView;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"更换头像";
        _detailLabel.textAlignment = NSTextAlignmentRight;
        if (YBIphone6Plus) {
            
            _detailLabel.font = [UIFont systemFontOfSize:12 *JZRatio_1_1_5];

        }else {
            _detailLabel.font = [UIFont systemFontOfSize:12];

        }
        
        _detailLabel.textColor  = JZ_FONTCOLOR_LIGHT;
    }
    return _detailLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.backgroundColor = [UIColor clearColor];
        _arrowImageView.image = [UIImage imageNamed:@"more_right"];
        
    }
    return _arrowImageView;
}

@end
