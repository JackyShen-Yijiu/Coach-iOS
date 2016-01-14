//
//  InformationMessageCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "InformationMessageCell.h"


@implementation InformationMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.detailBackView];
    [self.detailBackView addSubview:self.titleLabel];
    [self.detailBackView addSubview:self.imgView];
    [self.detailBackView addSubview:self.dataLabel];
    [self.detailBackView addSubview:self.contentTitleLabel];
    [self.detailBackView addSubview:self.detailLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
        
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        
    }];
    [self.detailBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(10);
        make.left.equalTo(self.backView.mas_left).offset(0);
        make.right.equalTo(self.backView.mas_right).offset(0);
        make.bottom.equalTo(self.backView.mas_bottom).offset(0);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailBackView.mas_top).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
        
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailBackView.mas_top).offset(10);
        make.right.equalTo(self.detailBackView.mas_right).offset(-20);
        make.width.equalTo(@23);
        make.height.equalTo(@29);
        
    }];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    [self.contentTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dataLabel.mas_bottom).offset(-10);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.height.equalTo(@80);
        
    }];

    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.bottom.equalTo(self.detailBackView.mas_bottom).offset(-10);
        
    }];
    
}
#pragma mark --- Lazy 加载
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[ UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor grayColor];
        _timeLabel.text = @"昨天  10:00";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = UITextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}
- (UIView *)backView{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB_Color(31, 124, 235);
    }
    return _backView;
}
- (UIView *)detailBackView{
    if (_detailBackView == nil) {
        _detailBackView = [[UIView alloc] init];
        _detailBackView.backgroundColor = RGB_Color(255,255,255);
        [_detailBackView.layer setShadowColor:[UIColor blackColor].CGColor];
        [_detailBackView.layer setShadowOpacity:0.2f];
        [_detailBackView.layer setOpacity:1.f];
        [_detailBackView.layer setShadowOffset:CGSizeMake(0, 1.5)];
    }
    return _detailBackView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _titleLabel;
    
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"zixun"];
    }
    return _imgView;
}
- (UILabel *)contentTitleLabel{
    if (_contentTitleLabel == nil) {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.textColor = [UIColor blackColor];
        _contentTitleLabel.numberOfLines = 0;
        _contentTitleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _contentTitleLabel;
}
- (UILabel *)dataLabel{
    if (_dataLabel == nil) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.text = @"2016-1-1";
        _dataLabel.textColor = [UIColor grayColor];
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailLabel;
}

- (CGFloat)heightWithcell:(InformationMessageModel *)model
{
    NSString *str = model.descriptionString;
    return   [self getLabelWidthWithString:str];
    
}

- (CGFloat)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20.f]} context:nil];
    return bounds.size.height + 140;
}
- (void)setInformationMessageModel:(InformationMessageModel *)informationMessageModel{
    
    self.detailLabel.text = informationMessageModel.descriptionString;
    self.contentTitleLabel.text = informationMessageModel.title;
    NSString *type = informationMessageModel.newstype;
    if ([type isEqualToString:@"0"]) {
        self.titleLabel.text = @"行业资讯";
        self.imageView.image = [UIImage imageNamed:@"xixun"];
    }else{
        self.titleLabel.text = @"笑话大全";
        self.imageView.image = [UIImage imageNamed:@"gaoxiao"];
    }
}
@end
