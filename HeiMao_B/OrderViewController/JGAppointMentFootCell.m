//
//  JGAppointMentFootCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGAppointMentFootCell.h"
#import "ToolHeader.h"
#import "HMCourseModel.h"
#import "PortraitView.h"

@interface JGAppointMentFootCell ()

@end

@implementation JGAppointMentFootCell

- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] initWithFrame:self.bounds];
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = RGB_Color(31, 124, 235).CGColor;
    }
    return _selectedAppView;
}

- (PortraitView *)potraitView
{
    if (_potraitView==nil) {
        _potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _potraitView.layer.cornerRadius = 1.f;
        _potraitView.layer.shouldRasterize = YES;
        _potraitView.backgroundColor = [UIColor clearColor];
    }
    return _potraitView;
}

- (UILabel *)mainTitle
{
    if (_mainTitle==nil) {
        _mainTitle = [[UILabel alloc] init];
        _mainTitle.textAlignment = NSTextAlignmentLeft;
        _mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
        _mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
        _mainTitle.backgroundColor = [UIColor clearColor];
        _mainTitle.numberOfLines = 1;
    }
    return _mainTitle;
}

- (UILabel *)subTitle
{
    if (_subTitle==nil) {
        _subTitle = [[UILabel alloc] init];
        _subTitle.textAlignment = NSTextAlignmentLeft;
        _subTitle.font = [UIFont systemFontOfSize:13.f];
        _subTitle.textColor = [UIColor lightGrayColor];
        _subTitle.backgroundColor = [UIColor clearColor];
        _subTitle.numberOfLines = 1;
    }
    return _subTitle;
}
- (UILabel *)countLabel
{
    if (_countLabel==nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont systemFontOfSize:13.f];
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.numberOfLines = 1;
    }
    return _countLabel;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        
        _addBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [_addBtn setImage:[UIImage imageNamed:@"JGAppointMentFootCellAddStudentImg"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"JGAppointMentFootCellAddStudentImg"] forState:UIControlStateHighlighted];

    }
    return _addBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *selImg = [[UIImageView alloc] init];
        selImg.image = [UIImage imageNamed:@"JGAppointMentFootCellSelectBg"];
        CGFloat JGAppointMentFootCellSelectBgW = 32;
        CGFloat JGAppointMentFootCellSelectBgH = 32;
        CGFloat JGAppointMentFootCellSelectBgY = 0;
        CGFloat JGAppointMentFootCellSelectBgX = self.contentView.width-JGAppointMentFootCellSelectBgW;
        selImg.frame = CGRectMake(JGAppointMentFootCellSelectBgX, JGAppointMentFootCellSelectBgY, JGAppointMentFootCellSelectBgW, JGAppointMentFootCellSelectBgH);
        [self.selectedAppView addSubview:selImg];
        [self.contentView addSubview:self.selectedAppView];
        
        [self.contentView addSubview:self.potraitView];
        
        [self.contentView addSubview:self.mainTitle];
        
        [self.contentView addSubview:self.subTitle];
        
        [self.contentView addSubview:self.countLabel];
        
        [self.contentView addSubview:self.addBtn];

        [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 60.f));
            make.left.equalTo(self.contentView.mas_right).offset(10.f);
            make.centerY.equalTo(self.contentView);
        }];
        
        [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.potraitView);
            make.left.equalTo(self.potraitView.mas_right).offset(5);
        }];
        
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainTitle.mas_bottom).offset(5);
            make.left.equalTo(self.mainTitle);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mainTitle);
            make.top.equalTo(self.subTitle.mas_bottom).offset(5.f);
        }];
       

    }
    return self;
}


- (void)setCoachTimeInfo:(HMCourseModel *)coachTimeInfo
{
    _coachTimeInfo = coachTimeInfo;
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = coachTimeInfo.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    // 姓名
    self.mainTitle.text = coachTimeInfo.studentInfo.userName;
    
    // 学习内容
    self.subTitle.text = coachTimeInfo.courseprocessdesc;
    
    // 学习内容
    self.countLabel.text = coachTimeInfo.learningcontent;
    
}

@end
