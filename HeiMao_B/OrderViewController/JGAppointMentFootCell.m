//
//  JGAppointMentFootCell.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGAppointMentFootCell.h"
#import "ToolHeader.h"
#import "YBSignUpStuentListModel.h"
#import "PortraitView.h"

@interface JGAppointMentFootCell ()

@property(nonatomic,strong)PortraitView * potraitView;

@property(nonatomic,strong)UILabel * mainTitle;

@property(nonatomic,strong)UILabel * subTitle;

@property(nonatomic,strong)UILabel * countLabel;

@property (strong, nonatomic) UIView *selectedAppView;

@end

@implementation JGAppointMentFootCell

- (UIView *)selectedAppView {
    if (_selectedAppView == nil) {
        _selectedAppView = [[UIView alloc] init];
        UIImageView *selImg = [[UIImageView alloc] init];
        selImg.image = [UIImage imageNamed:@"JGAppointMentFootCellSelectBg"];
        CGFloat JGAppointMentFootCellSelectBgW = 32;
        CGFloat JGAppointMentFootCellSelectBgH = 32;
        CGFloat JGAppointMentFootCellSelectBgY = 0;
        CGFloat JGAppointMentFootCellSelectBgX = self.contentView.width-JGAppointMentFootCellSelectBgW;
        selImg.frame = CGRectMake(JGAppointMentFootCellSelectBgX, JGAppointMentFootCellSelectBgY, JGAppointMentFootCellSelectBgW, JGAppointMentFootCellSelectBgH);
        [_selectedAppView addSubview:selImg];
        _selectedAppView.layer.borderWidth = 1;
        _selectedAppView.layer.borderColor = RGB_Color(31, 124, 235).CGColor;
    }
    return _selectedAppView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];

    if (self) {
       
        self.selectedBackgroundView = self.selectedAppView;
        
        _potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _potraitView.layer.cornerRadius = 1.f;
        _potraitView.layer.shouldRasterize = YES;
        _potraitView.backgroundColor = [UIColor whiteColor];
        
        _mainTitle = [[UILabel alloc] init];
        _mainTitle.textAlignment = NSTextAlignmentLeft;
        _mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
        _mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
        _mainTitle.backgroundColor = [UIColor clearColor];
        _mainTitle.numberOfLines = 1;
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.textAlignment = NSTextAlignmentLeft;
        _subTitle.font = [UIFont systemFontOfSize:13.f];
        _subTitle.textColor = [UIColor lightGrayColor];
        _subTitle.backgroundColor = [UIColor clearColor];
        _subTitle.numberOfLines = 1;
       
        _countLabel = [[UILabel alloc] init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont systemFontOfSize:13.f];
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.numberOfLines = 1;
        
        [self.contentView addSubview:_potraitView];
        
        [self.contentView addSubview:_mainTitle];
        
        [self.contentView addSubview:_subTitle];
        
        [self.contentView addSubview:_countLabel];
        
        [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(7);
            make.top.mas_equalTo(@0).offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 60.f));
        }];
        
        [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.potraitView.mas_top).offset(5);
            make.left.equalTo(self.potraitView.mas_right).offset(5);
        }];
        
        [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainTitle.mas_bottom);
            make.left.equalTo(self.mainTitle);
        }];
        
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitle.mas_bottom).offset(5.f);
            make.left.equalTo(self.mainTitle);
        }];
       
    }
    return self;
}


- (void)setCoachTimeInfo:(YBSignUpStuentListModel *)coachTimeInfo
{
    _coachTimeInfo = coachTimeInfo;
    
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = [NSString stringWithFormat:@"%@",_coachTimeInfo.userInfooModel.originalpic];
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    // 姓名
    NSLog(@"_coachTimeInfo.userInfooModel.name:%@",_coachTimeInfo.userInfooModel.name);
    self.mainTitle.text = [NSString stringWithFormat:@"%@",_coachTimeInfo.userInfooModel.name];
    
    // 学习内容
    NSLog(@"_coachTimeInfo.userInfooModel.subjecttwo.progress:%@",_coachTimeInfo.userInfooModel.subjecttwo[@"progress"]);
    
    self.subTitle.text = [NSString stringWithFormat:@"%@",_coachTimeInfo.userInfooModel.subjecttwo[@"progress"]];
    
    // 学习内容
    NSLog(@"_coachTimeInfo.courseprocessdesc:%@",_coachTimeInfo.courseprocessdesc);
    self.countLabel.text = [NSString stringWithFormat:@"%@",_coachTimeInfo.courseprocessdesc];
    
}

@end
