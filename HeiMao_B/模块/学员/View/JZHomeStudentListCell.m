//
//  JZHomeStudentListCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZHomeStudentListCell.h"

@interface JZHomeStudentListCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *studyConLabel;

@property (nonatomic, strong) UILabel *classTimeLable;

@property (nonatomic, strong) UIButton *messageButton;

@property (nonatomic, strong) UIButton *phoneButton;

@property (nonatomic, strong) UIView *lineView;


@end

@implementation JZHomeStudentListCell

- (void)awakeFromNib {
   
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.studyConLabel];
        [self.contentView addSubview:self.classTimeLable];
        [self.contentView addSubview:self.messageButton];
        [self.contentView addSubview:self.phoneButton];
        [self.contentView addSubview:self.lineView];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(25);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.height.mas_equalTo(@48);
        make.width.mas_equalTo(@48);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(16);
        make.height.mas_equalTo(@14);
        make.width.mas_equalTo(@80);
        
    }];
    [self.classTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.studyConLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.height.mas_equalTo(@12);
        
        
    }];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(@64);
         make.width.mas_equalTo(@32);
        
        
    }];
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(self.phoneButton.mas_left).offset(0);
        make.height.mas_equalTo(@32);
        make.width.mas_equalTo(@32);
        
        
    }];
    [self.studyConLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.messageButton.mas_left).offset(0);
        make.height.mas_equalTo(@12);
        
        
    }];


    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(@0.5);
        
    }];
    




}
#pragma makk ----- Action
- (void)didClickStudentListCell:(UIButton *)btn{
    if (_studentListMessageAndCall) {
        
        _studentListMessageAndCall(btn.tag);
    }
}

#pragma mark --- Lazy 加载
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.image = [UIImage imageNamed:@"JZCoursenull_student"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = JZ_FONTCOLOR_DRAK;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"田娜";
    }
    return _nameLabel;
}
- (UILabel *)studyConLabel{
    if (_studyConLabel == nil) {
        _studyConLabel = [[UILabel alloc] init];
        _studyConLabel.textColor = JZ_FONTCOLOR_LIGHT;
        _studyConLabel.font = [UIFont systemFontOfSize:12];
        _studyConLabel.text = @"科目二第11课时 变更车道";
    }
    return _studyConLabel;
}
- (UILabel *)classTimeLable{
    if (_classTimeLable == nil) {
        _classTimeLable = [[UILabel alloc] init];
        _classTimeLable.textColor = JZ_FONTCOLOR_LIGHT;
        _classTimeLable.font = [UIFont systemFontOfSize:12];
        _classTimeLable.text = @"剩余17课时 已漏2课时";
    }
    return _classTimeLable;
}
- (UIButton *)messageButton{
    if (_messageButton == nil) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageButton setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
        [_messageButton addTarget:self action:@selector(didClickStudentListCell:) forControlEvents:UIControlEventTouchUpInside];
        [_messageButton setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
//        _messageButton.backgroundColor = [UIColor cyanColor];
        _messageButton.tag = 500;
    }
    return _messageButton;
}
- (UIButton *)phoneButton{
    if (_phoneButton == nil) {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneButton setImage:[UIImage imageNamed:@"JZCoursephone"] forState:UIControlStateNormal];
        [_phoneButton addTarget:self action:@selector(didClickStudentListCell:) forControlEvents:UIControlEventTouchUpInside];
        [_phoneButton setImageEdgeInsets:UIEdgeInsetsMake(24, 8, 24, 8)];
        _phoneButton.tag = 501;
//        _phoneButton.backgroundColor = [UIColor grayColor];
    }
    return _phoneButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
#pragma mark --- 数据
- (void)setListModel:(JZResultModel *)listModel{
     [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:listModel.headportrait.originalpic ]
                           placeholderImage:[UIImage imageNamed:@"JZCoursenull_student"]];
    self.nameLabel.text = listModel.name;
    self.studyConLabel.text = listModel.courseinfo.progress;
    // 剩余17课时,已漏课2课时
    
    // 剩余课时
    NSInteger surplusClassTnteger = listModel.courseinfo.totalcourse - listModel.courseinfo.finishcourse;
    NSString *surplusClass = [NSString stringWithFormat:@"剩余%lu课时",surplusClassTnteger];
    
    // 漏课课时
    NSString *missClass = [NSString stringWithFormat:@"%lu",listModel.courseinfo.missingcourse];
    
    self.classTimeLable.text = [NSString stringWithFormat:@"%@ %@",surplusClass,missClass];
    
   
}
@end
