//
//  JZCompletionConfirmationCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCompletionConfirmationCell.h"

#import "RatingBar.h"

@interface JZCompletionConfirmationCell ()
@property (nonatomic ,strong) UIView *bgTopView; // 背景
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *bgBottomView; // 背景

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgContentView; // 背景
@property (nonatomic, strong) UILabel *tittleContentLabel;
@property (nonatomic, strong) UIButton *contentButton;

@property (nonatomic, strong) UIView *bgRateView; // 背景
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) RatingBar *ratingBar;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *commitButton;




@end

@implementation JZCompletionConfirmationCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    // 顶部视图
    [self.contentView addSubview:self.bgTopView];
    [self.bgTopView addSubview:self.iconImageView];
    [self.bgTopView addSubview:self.nameLabel];
    [self.bgTopView addSubview:self.timeLabel];
    [self.bgTopView addSubview:self.arrowImageView];
    
    
    // 底部视图
    [self.contentView addSubview:self.bgBottomView];
    [self.bgBottomView addSubview:self.bgContentView];
    [self.bgBottomView addSubview:self.lineView];
    
    // 教学内容视图
    [self.bgContentView addSubview:self.tittleContentLabel];
    [self.bgContentView addSubview:self.contentButton];
    
    // 评分视图
    [self.bgContentView addSubview:self.bgRateView];
    [self.bgRateView addSubview:self.rateLabel];
    [self.bgRateView addSubview:self.ratingBar];
    [self.bgRateView addSubview:self.contentTextView];
    [self.bgRateView addSubview:self.commitButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 顶部视图
    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@80); // 80
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(16);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@48);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(21);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(16);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@14);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@12);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-16);
        make.width.mas_equalTo(@8);
        make.height.mas_equalTo(@14);
    }];
    // 底部视图
    
    [self.bgBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@200); // 200
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgBottomView.mas_top).offset(0.5);
        make.left.mas_equalTo(self.bgBottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgBottomView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];

    
     // 教学内容视图
    [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgBottomView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@80);
    }];
    [self.tittleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgContentView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgContentView.mas_left).offset(16);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@32);
    }];
    [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tittleContentLabel.mas_bottom).offset(18);
        make.left.mas_equalTo(self.tittleContentLabel.mas_left);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@32);
    }];

    // 评分视图
    [self.bgRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgContentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@200);
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgRateView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@16);
    }];
    [self.ratingBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgRateView.mas_top).offset(0);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.width.mas_equalTo(@92);
        make.height.mas_equalTo(@16);
    }];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ratingBar.mas_bottom).offset(16);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.height.mas_equalTo(@100);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextView.mas_bottom).offset(16);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.height.mas_equalTo(@32);
    }];




    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}
// 顶部视图
- (UIView *)bgTopView{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        _bgTopView.backgroundColor = [UIColor whiteColor];
    }
    return _bgTopView;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"周家";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"08:00-09:00";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _timeLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"more_right"];
        
    }
    return _arrowImageView;
}

// 底部视图
- (UIView *)bgBottomView{
    if (_bgBottomView == nil) {
        _bgBottomView = [[UIView alloc] init];
        _bgBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bgBottomView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (UIView *)bgContentView{
    if (_bgContentView == nil) {
        _bgContentView = [[UIView alloc] init];
        _bgContentView.backgroundColor = [UIColor whiteColor];
    }
    return _bgContentView;
}

- (UILabel *)tittleContentLabel{
    if (_tittleContentLabel == nil) {
        _tittleContentLabel = [[UILabel alloc] init];
        _tittleContentLabel.text = @"教学内容(必选)";
        _tittleContentLabel.font = [UIFont systemFontOfSize:12];
        _tittleContentLabel.textColor = RGB_Color(230, 46, 72);
    }
    return _tittleContentLabel;
}
- (UIButton *)contentButton{
    if (_contentButton == nil) {
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.backgroundColor = [UIColor cyanColor];
        
    }
    return _contentButton;
}

- (UIView *)bgRateView{
    if (_bgRateView == nil) {
        _bgRateView = [[UIView alloc] init];
        _bgRateView.backgroundColor = [UIColor whiteColor];
    }
    return _bgRateView;
}

- (UILabel *)rateLabel{
    if (_rateLabel == nil) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.text = @"评分";
        _rateLabel.font = [UIFont systemFontOfSize:16];
        _rateLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _rateLabel;
}

- (RatingBar *)ratingBar{
    if (_ratingBar == nil) {
        _ratingBar = [[RatingBar alloc] init];
    }
    return _ratingBar;
}
- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [UIColor cyanColor];
    }
    return _contentTextView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = JZ_BlueColor;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        _commitButton.layer.masksToBounds = YES;
        _commitButton.layer.cornerRadius = 5;
    }
    return _commitButton;
}
@end
