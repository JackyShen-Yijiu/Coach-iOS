//
//  StudentListCell.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentListCell.h"
#import "ToolHeader.h"
#import "PortraitView.h"

@interface StudentListCell ()
@property(nonatomic,strong)PortraitView * porTraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * progressDes;
@property(nonatomic,strong)UIView * bottomLine;

@end

@implementation StudentListCell
+ (CGFloat)cellHeigth
{
    return 40.f;
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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.porTraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 240)];
    self.porTraitView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.porTraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:12];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    [self.contentView addSubview:self.subTitle];
    
    self.progressDes = [[UILabel alloc] init];
    self.progressDes.backgroundColor = [UIColor clearColor];
    self.progressDes.textAlignment = NSTextAlignmentRight;
    self.progressDes.font = [UIFont systemFontOfSize:12];
    self.progressDes.textColor = RGB_Color(0x99, 0x99, 0x99);
    [self.contentView addSubview:self.progressDes];

    self.bottomLine = [self getOnelineView];
    [self.contentView addSubview:self.bottomLine];
    [self updateConstraints];
}

- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

- (void)updateConstraints
{
    [self.porTraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(15);
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
        make.top.equalTo(self).offset(15);
    }];
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.porTraitView.mas_right).offset(12.f);
        make.height.equalTo(@(16.f));
        make.width.lessThanOrEqualTo(@(100));
        make.top.equalTo(@((80 - 16 - 10 - 14)/2.f));
    }];
    
    [self.progressDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15.f);
        make.left.equalTo(self.mainTitle);
        make.centerY.equalTo(self.mainTitle);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(@200);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(10.f);
        make.height.equalTo(@(16.f));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.width.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-HM_LINE_HEIGHT);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    [super updateConstraints];
}
- (void)setStuModel:(HMStudentModel *)stuModel
{
    _stuModel = stuModel;
    UIImage * defaultImage = [UIImage imageNamed:@"littleImage"];
    self.porTraitView.imageView.image = defaultImage;
    NSString * imageStr = _stuModel.porInfo.originalpic;
    if(imageStr)
        [self.porTraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];

    self.mainTitle.text = _stuModel.userName;
    self.subTitle.text = _stuModel.courseSchedule;
    
    NSString * str = [NSString stringWithFormat:@"预约剩余%ld课时",(long)stuModel.leavecoursecount];
    if(stuModel.missingcoursecount){
        str = [str stringByAppendingFormat:@"漏%ld科时",(long)stuModel.missingcoursecount];
    }
    self.progressDes.text = str;
}

@end
