//
//  CourseRatingCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseRatingCell.h"
#import "CWStarRateView.h"

@implementation CourseRatingModel
@end

@interface CourseRatingCell()<CWStarRateViewDelegate>
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)CWStarRateView * rateView;
@end

@implementation CourseRatingCell

+ (CGFloat)cellHigth
{
    return 75;
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
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font =[UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.rateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(15, 0, 150, 24) numberOfStars:5];
    self.rateView.allowIncompleteStar = NO;
    self.rateView.hasAnimation = NO;
    self.rateView.scorePercent = 1.f;
    self.rateView.delegate = self;
    [self.contentView addSubview:self.rateView];
    
    self.bottonLineView = [self getOnelineView];
    [self.contentView addSubview:self.bottonLineView];
    
    [self setNeedsUpdateConstraints];
}

#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(13.f);
        make.left.equalTo(self.contentView).offset(15.f);
        make.height.equalTo(@(14.f));
        make.right.equalTo(self.contentView).offset(-13.f);
    }];
    
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8.f);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(@(150));
        make.height.equalTo(@(24.f));
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.makeLineAligent) {
        self.bottonLineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    }else{
        self.bottonLineView.frame = CGRectMake(15, self.height - 1, self.width, 1);
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}


-(void)setMakeLineAligent:(BOOL)makeLineAligent
{
    _makeLineAligent = makeLineAligent;
    [self setNeedsLayout];
}

#pragma mark -  data
- (void)setModel:(CourseRatingModel *)model
{
    _model = model;
    self.titleLabel.text = _model.title;
    self.rateView.scorePercent = _model.rating / 5.f;
}

-(void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    self.model.rating = newScorePercent * 5.0;
    NSLog(@"%f",self.model.rating);
}

#pragma mark - Common
- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

@end
