//
//  CourseDetailViewCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/31.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseDetailViewCell.h"

@implementation CourseDetailViewCell

- (CourseDetailView *)detailView
{
    if (!_detailView) {
        _detailView = [[CourseDetailView alloc] initWithFrame:CGRectMake(0, 0, self.width, [CourseDetailView cellHeightWithModel:self.model])];
        [self.contentView addSubview:_detailView];
    }
    return _detailView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.detailView.frame = CGRectMake(0, 0, self.contentView.width, [CourseDetailView cellHeightWithModel:self.model]);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}
@end
