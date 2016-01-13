//
//  SystemMessageDetailCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SystemMessageDetailCell.h"

@interface SystemMessageDetailCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *detailBackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UILabel *didClickLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLineView;





@end

@implementation SystemMessageDetailCell

- (void)awakeFromNib {
    
}
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
    [self.detailBackView addSubview:self.detailLabel];
    [self.detailBackView addSubview:self.topLineView];
    [self.detailBackView addSubview:self.didClickLabel];
    [self.detailBackView addSubview:self.arrowImageView];
//    [self.detailBackView addSubview:self.bottomLineView];
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
- (void)layoutSubviews{
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@100);
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
        make.top.equalTo(self.detailBackView.mas_top).offset(50);
        make.right.equalTo(self.detailBackView.mas_right).offset(-20);
        make.width.equalTo(@400);
        make.height.equalTo(@40);
        
    }];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dataLabel.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.height.equalTo(@40);
        
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(0);
        make.right.equalTo(self.detailBackView.mas_right).offset(0);
        make.height.equalTo(@1);
       
        
    }];
    [self.didClickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLineView.mas_bottom).offset(10);
        make.left.equalTo(self.detailBackView.mas_left).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dataLabel.mas_bottom).offset(10);
        make.right.equalTo(self.detailBackView.mas_right).offset(-20);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
        
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
        _backView.backgroundColor = [UIColor greenColor];
    }
    return _backView;
}
- (UIView *)detailBackView{
    if (_detailBackView == nil) {
        _detailBackView = [[UIView alloc] init];
        _detailBackView.backgroundColor = [UIColor whiteColor];
    }
    return _detailBackView;
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"金额增加通知";
        _titleLabel.backgroundColor = [UIColor cyanColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _titleLabel;
    
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@""];
    }
    return _imgView;
}
- (UILabel *)dataLabel{
    if (_dataLabel == nil) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.text = @"2016-1-1";
        _dataLabel.textColor = [UIColor grayColor];
        _dataLabel.backgroundColor = [UIColor cyanColor];
        _dataLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dataLabel;
}
- (UILabel *)detailLabel{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"您已经完成学员签到流程,恭喜您能获得1元钱,继续加油哦!";
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.backgroundColor = [UIColor cyanColor];
        _detailLabel.numberOfLines = 0;
        _detailLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailLabel;
}
- (UIView *)topLineView{
    if (_topLineView == nil) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor grayColor];
    }
    return _topLineView;
}
- (UILabel *)didClickLabel{
    if (_didClickLabel == nil) {
        _didClickLabel = [[UILabel alloc] init];
        _didClickLabel.text = @"立即查看";
        _didClickLabel.textColor = [UIColor grayColor];
        _didClickLabel.font = [UIFont systemFontOfSize:17];
    }
    return _didClickLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@""];
    }
    return _arrowImageView;
}

- (UIView *)bottomLineView{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor grayColor];
    }
    return _bottomLineView;
}

@end
