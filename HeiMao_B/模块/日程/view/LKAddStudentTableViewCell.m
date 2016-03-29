//
//  AddStudentTableViewCell.m
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "LKAddStudentTableViewCell.h"
#import "Masonry.h"

@implementation LKAddStudentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *studentNameLabel = [[UILabel alloc]init];
        
        self.studentNameLabel = studentNameLabel;
        
        UILabel *studyDetilsLabel = [[UILabel alloc]init];
        self.studyDetilsLabel = studyDetilsLabel;
        
        UIImageView *studentIconView = [[UIImageView alloc]init];
        self.studentIconView = studentIconView;
        
        UIButton *callStudentButton = [[UIButton alloc]init];
        self.callStudentButton = callStudentButton;
        
        UIImageView *selectImageView = [[UIImageView alloc]init];
        
        self.selectImageView = selectImageView;
        
        [self.contentView addSubview:self.selectImageView];
        [self.contentView addSubview:self.studentIconView];
        [self.contentView addSubview:self.studyDetilsLabel];
        [self.contentView addSubview:self.callStudentButton];
        [self.contentView addSubview:self.studentNameLabel];
        

    }
    return self;


}
-(void)layoutSubviews
{
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(30);
        
       
    }];
    
    
    [self.studentIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.selectImageView).offset(16);
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(16);
        
        
    }];
    
    [self.studentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.contentView.mas_top).offset(21);
        make.left.mas_equalTo(self.studentIconView.mas_right).offset(16);
        make.height.mas_equalTo(14);
        
        
        
    }];
    
    [self.studyDetilsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.studentNameLabel.mas_bottom).offset(12);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(21);
        make.height.mas_equalTo(12);
        
        
    }];
    
    [self.callStudentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(self.contentView.mas_right).offset(24);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];

}
//-(void)setStudentModel:(Student *)studentModel
//{
////    _studentModel = studentModel;
////    /// 学员名称 -- UILabel
////    @property (nonatomic, weak) UILabel *studentNameLabel;
////    /// 学员学习详情 -- UILabel
////    @property (nonatomic, weak) UILabel *studyDetilsLabel;
////    /// 学员头像 -- UIImageView
////    @property (nonatomic, weak) UIImageView *studentIconView;
////    /// 拨打学员电话按钮 -- UIButton
////    @property (nonatomic, weak) UIButton *callStudentButton;
////    /// 选择学员的按钮 -- UIButton
////    @property (nonatomic, weak) UIImageView *selectImageView;
//    
//    _studentNameLabel.text = studentModel.studentNameLabel;
//    
//    
//    
//
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
