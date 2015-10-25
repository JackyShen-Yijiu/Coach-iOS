//
//  OrderSummaryListCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "OrderSummaryListCell.h"


@interface OrderSummaryListCell()
@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * statueLabel;
@property(nonatomic,strong)UILabel * classTime;
@property(nonatomic,strong)UILabel * trainingAddressLabel;
@property(nonatomic,strong)UILabel * pickAddressLabel;

@property(nonatomic,strong)UIView * topLine;
@property(nonatomic,strong)UIView * midLine;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation OrderSummaryListCell
+ (CGFloat)cellHeight
{
    return 180;
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
    self.potraitView = [[PortraitView alloc] init];
    [self.bgView addSubview:self.potraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    [self.bgView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:14.f];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 1;
    [self.bgView addSubview:self.subTitle];
  
    self.statueLabel = [[UILabel alloc] init];
    self.statueLabel.textAlignment = NSTextAlignmentRight;
    self.statueLabel.font = [UIFont systemFontOfSize:14.f];
    self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.statueLabel.backgroundColor = [UIColor clearColor];
    self.statueLabel.numberOfLines = 1;
    [self.bgView addSubview:self.statueLabel];
    
    self.classTime = [self getOnePropertyLabel];
    [self.bgView addSubview:self.classTime];
    
    self.trainingAddressLabel = [self getOnePropertyLabel];
    [self.bgView addSubview:self.trainingAddressLabel];
    
    self.pickAddressLabel = [self getOnePropertyLabel];
    [self.bgView addSubview:self.pickAddressLabel];
    
    self.topLine = [self getOnelineView];
    [self.bgView addSubview:self.topLine];
    
    self.midLine = [self getOnelineView];
    [self.bgView addSubview:self.midLine];
    
    self.bottomLine = [self getOnelineView];
    [self.bgView addSubview:self.bottomLine];
}

#pragma mark Layout
//- (void)updateConstraints
//{
//    [super updateConstraints];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView);
//        make.left.equalTo(self.contentView);
//        make.width.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView).offset(-10);
//        
//    }];
//    
//    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.bgView);
//        make.left.equalTo(self.bgView);
//        make.width.equalTo(self.bgView);
//        make.height.equalTo(@(1));
//    }];
//    
//    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//    }];
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    CGFloat leftSpacing = 15.f;
    
    self.topLine.frame = CGRectMake(0, 0, self.width, 1);
    
    self.potraitView.frame = CGRectMake(leftSpacing, 15, 60, 60);

    [self.statueLabel sizeToFit];
    self.statueLabel.frame = CGRectMake(self.width - self.statueLabel.width - leftSpacing , 14, self.statueLabel.width, self.statueLabel.height);
    
    self.mainTitle.frame = CGRectMake(self.potraitView.right + 12,(90 - 16 - 10 - 14)/2.f,
                                      self.statueLabel.left - (self.potraitView.right + 12) - 10, 16.f);
    self.subTitle.frame = CGRectMake(self.mainTitle.left, self.mainTitle.bottom + 10,self.width - self.mainTitle.left - leftSpacing , 14.f);
    
    self.midLine.frame = CGRectMake(leftSpacing, self.potraitView.bottom + self.potraitView.top, self.width - leftSpacing * 2, 1);
    
    self.trainingAddressLabel.frame = CGRectMake(leftSpacing, self.midLine.bottom + (90 - 14 * 3 - 8 * 2)/2.f, self.width - leftSpacing * 2, 14);
    
    self.classTime.frame = CGRectOffset(self.trainingAddressLabel.frame, 0, -self.trainingAddressLabel.height - 8);
    
    self.pickAddressLabel.frame = CGRectOffset(self.trainingAddressLabel.frame, 0, self.trainingAddressLabel.height + 8);
    
    [CATransaction commit];
}

#pragma mark - Common

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = RGB_Color(0xe6, 0xe6, 0xe6);
    return view;
}

- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB_Color(0x33, 0x33, 0x33);
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        [self.contentView addSubview:_bgView];
    }
    return _bgView;
}
@end
