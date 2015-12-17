//
//  CourseRatingUserInfoCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseRatingUserInfoCell.h"
#import "PortraitView.h"

@interface CourseRatingUserInfoCell()
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
//@property(nonatomic,strong)UIView * bottomView;
@end

@implementation CourseRatingUserInfoCell

+ (CGFloat)cellHeigth
{
    return 90.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.contentView.backgroundColor  = RGB_Color(247, 249, 251);
    self.potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.potraitView.layer.cornerRadius = 1.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.potraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    [self.contentView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:14.f];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    [self.contentView addSubview:self.subTitle];
}


- (void)updateConstraints
{
    [super updateConstraints];
    
    CGFloat leftOffsetSpacing = 15.f;
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(leftOffsetSpacing);
        make.top.equalTo(self.contentView).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(60.f, 60.f));
    }];
 

    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.potraitView.mas_right).offset(12.f);
        make.height.equalTo(@(16.f));
        make.top.equalTo(@((90 - 16 - 10 - 14)/2.f));
        make.right.equalTo(self.contentView).offset(-leftOffsetSpacing);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(self.mainTitle);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(10.f);
        make.height.equalTo(@(16.f));
    }];
    
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(-2);
//        make.right.equalTo(self.contentView).offset(2);
//        make.bottom.equalTo(self.contentView);
//        make.height.equalTo(@(10));
//    }];
}


//- (UIView *)bottomView
//{
//    if (!_bottomView) {
//        _bottomView = [[UIView alloc] init];
//        _bottomView.backgroundColor = RGB_Color(247, 249, 251);
//        _bottomView.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
//        _bottomView.layer.borderWidth = 1;
//        [self.contentView addSubview:_bottomView];
//    }
//    return _bottomView;
//}

#pragma mark - Data
- (void)setModel:(HMStudentModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    _model = model;
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    NSString * imageStr = _model.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.mainTitle.text = _model.userName;
    self.subTitle.text = [NSString stringWithFormat:@"ID %@",_model.disPlayId];
    [self setNeedsUpdateConstraints];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}
@end
