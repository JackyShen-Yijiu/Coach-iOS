//
//  StudentHomeUserInfoCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "StudentHomeUserCourseInfoCell.h"

@interface StudentHomeUserCourseInfoCell()

@end

@implementation StudentHomeUserCourseInfoCell

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


@end
