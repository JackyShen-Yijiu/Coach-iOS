//
//  EditorUseBottomCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/26.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "EditorUseBottomCell.h"

@interface EditorUseBottomCell ()


@end

@implementation EditorUseBottomCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews{
    [self.iconImgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.mas_top).offset(14);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
        if (YBIphone6Plus) {
            
            make.width.mas_equalTo(16 * JZRatio_1_1_5);
            make.height.mas_equalTo(16* JZRatio_1_1_5);
        }else {
            
            make.width.mas_equalTo(@16);
            make.height.mas_equalTo(@16);
        }
        

    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.left.mas_equalTo(self.iconImgeView.mas_right).offset(16);
        make.height.mas_equalTo(@14);
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
   [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (UIImageView *)iconImgeView{
    if (_iconImgeView == nil) {
        _iconImgeView = [[UIImageView alloc] init];
        _iconImgeView.backgroundColor = [UIColor clearColor];
        
    }
    return _iconImgeView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"更换头像";
        if (YBIphone6Plus) {
            
            _titleLabel.font = [UIFont systemFontOfSize:14*JZRatio_1_1_5];

        }else {
            _titleLabel.font = [UIFont systemFontOfSize:14];

        }
        _titleLabel.textColor  = JZ_FONTCOLOR_DRAK;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"更换头像";
        _detailLabel.textAlignment = NSTextAlignmentRight;
        if (YBIphone6Plus) {
            
            _detailLabel.font = [UIFont systemFontOfSize:12 * JZRatio_1_1_5];
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
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
@end
