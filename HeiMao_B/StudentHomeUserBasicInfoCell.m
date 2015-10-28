//
//  StudentHomeCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentHomeUserBasicInfoCell.h"
#import "PortraitView.h"

@interface StudentHomeUserBasicInfoCell()
@property(nonatomic,strong)PortraitView * porTraitView;
@property(nonatomic,strong)UILabel * userName;
@end

@implementation StudentHomeUserBasicInfoCell
+ (CGFloat)cellHeigth
{
    return 240.f;
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
    self.porTraitView = [[PortraitView alloc] init];
    [self.contentView addSubview:self.porTraitView];
    
}

- (void)updateConstraints
{
    [self.porTraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
    }];
    [super updateConstraints];
}

- (void)setBgImageUrlStr:(NSString *)bgImageUrlStr
{
    _bgImageUrlStr = bgImageUrlStr;
    UIImage * defaultImage = [UIImage imageNamed:@"temp"];
    if(_bgImageUrlStr)
        [self.porTraitView.imageView sd_setImageWithURL:[NSURL URLWithString:_bgImageUrlStr] placeholderImage:defaultImage];
}

@end
