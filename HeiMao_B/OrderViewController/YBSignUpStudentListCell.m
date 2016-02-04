//
//  YBSignUpStudentListCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBSignUpStudentListCell.h"


@interface YBSignUpStudentListCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UIView *lineBottiom;
@end

@implementation YBSignUpStudentListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.iconImgView];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.phoneButton];
    [self.bgView addSubview:self.lineBottiom];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
    }];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.left.mas_equalTo(self.bgView.mas_left).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(25);
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(20);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(16);
    }];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(20);
        make.right.mas_equalTo(self.bgView.mas_right).offset(-20);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
    }];
    [self.lineBottiom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.bgView.mas_right).offset(0);
        make.left.mas_equalTo(self.bgView.mas_left).offset(0);
        make.height.mas_equalTo(1);
    }];


}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIImageView *)iconImgView{
    if (_iconImgView == nil) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor cyanColor];
        
    }
    return _iconImgView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"王馨于";
        _nameLabel.textColor = [UIColor blackColor];
        
    }
    return _nameLabel;
    
}
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"科目二路考训练";
        _contentLabel.textColor = [UIColor blackColor];
    }
    
    return _contentLabel;
}
-(UIButton *)phoneButton{
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setBackgroundImage:[UIImage imageNamed:@"call_icon"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(didCallPhone:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneButton;
}
-(UIView *)lineBottiom{
    if (_lineBottiom == nil) {
        _lineBottiom = [[UIView alloc]init];
        _lineBottiom.backgroundColor = RGB_Color(230, 230, 230);
    }
    return _lineBottiom;
}
- (void)didCallPhone:(UIButton*)btn{
    if (_callStudent) {
        _callStudent(btn);
    }
    
}
- (void)setSignUpStudentModel:(YBSignUpStuentListModel *)signUpStudentModel{
    self.nameLabel.text = signUpStudentModel.userInfooModel.name;
    self.contentLabel.text = signUpStudentModel.courseprocessdesc;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:signUpStudentModel.userInfooModel.originalpic] placeholderImage:nil];
}
@end
