//
//  ButtonSelectedCell.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/17.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "ButtonSelectedCell.h"
#import "buttonSelectedModel.h"
#import "ToolHeader.h"
@interface ButtonSelectedCell ()
@property (strong, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIButton *selectedButton;
@property (strong, nonatomic) buttonSelectedModel *model;
@end
@implementation ButtonSelectedCell
- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
    }
    return _contentLabel;
}
- (UIView *)backGroundView {
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kSystemWide , 44)];
    }
    return _backGroundView;
}
- (UIButton *)selectedButton {
    if (_selectedButton == nil) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"JZCoursechoose"] forState:UIControlStateNormal];
        [_selectedButton setImage:[UIImage imageNamed:@"JZCoursesure"] forState:UIControlStateSelected];
    }
    return _selectedButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
    
}
- (void)setUpUI {
    [self.contentView addSubview:self.backGroundView];
    
    [self.backGroundView addSubview:self.contentLabel];

    
    [self.backGroundView addSubview:self.selectedButton];
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backGroundView.mas_left).offset(15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
    }];
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backGroundView.mas_right).offset(-15);
        make.centerY.mas_equalTo(self.backGroundView.mas_centerY);
        make.width.mas_equalTo(@15);
        make.height.mas_equalTo(@15);
    }];
}
- (void)receiveDataWithModel:(buttonSelectedModel *)model {
    self.model = model;
    self.contentLabel.text = nil;
    self.contentLabel.text = model.name;
    
    self.selectedButton.selected = NO;
    self.selectedButton.selected = model.is_selected;
}

@end
