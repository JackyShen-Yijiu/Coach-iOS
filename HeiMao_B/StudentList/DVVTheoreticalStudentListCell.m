//
//  DVVTheoreticalStudentListCell.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVTheoreticalStudentListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation DVVTheoreticalStudentListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVTheoreticalStudentListCell" owner:self options:nil];
        DVVTheoreticalStudentListCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

- (void)refreshData:(DVVStudentListDMData *)dmData {
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:dmData.headportrait.originalpic] placeholderImage:[UIImage imageNamed:@"defoult_por"]];
    _nameLabel.text = dmData.name;
    
    _subjectInfoLabel.text = @"暂无科目信息";
    if (dmData.subjectprocess && dmData.subjectprocess.length) {
        _subjectInfoLabel.text = [NSString stringWithFormat:@"%@", dmData.subjectprocess];
    }
    if ([dmData.subject.subjectid integerValue] > 4) {
        _subjectInfoLabel.text = @"已领证";
    }
    
    // 暂时没有此字段，待处理
    _classHourLabel.text = @"";
    
    // 电话
    _phoneButton.tag = dmData.mobile;
    
}
- (IBAction)phoneButtonAction:(UIButton *)sender {
    if (sender.tag) {
        [self phoneCall:sender.tag];
    }
}
- (void)phoneCall:(NSInteger)phoneNumber {
    
    if (!phoneNumber) {
        return ;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[NSString stringWithFormat:@"%d", phoneNumber]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
