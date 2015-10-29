//
//  PicListCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CoursePicListCell.h"

@interface CoursePicListCell ()
@property(nonatomic,strong)UIView * bottomView;
@end
@implementation CoursePicListCell

+ (CGFloat)cellHight:(NSInteger)listCount
{
    CGFloat height = [PickListView pickListViewHeigthWithPickerCount:listCount];
    return height += 10.f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    [self updateConstraints];
    return self;
}

- (PickListView *)pickListView
{
    if (!_pickListView) {
        _pickListView  = [[PickListView alloc] init];
        [self.contentView addSubview:_pickListView];
    }
    return _pickListView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB_Color(247, 249, 251);
        _bottomView.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
        _bottomView.layer.borderWidth = 1;
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)updateConstraints
{
    [super updateConstraints];
    [self.pickListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(-2);
        make.right.equalTo(self.contentView).offset(2);
        make.top.equalTo(self.pickListView.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
