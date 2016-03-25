//
//  DVVDrivingStudentListCell.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVDrivingStudentListCell.h"

@implementation DVVDrivingStudentListCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVDrivingStudentListCell" owner:self options:nil];
        DVVDrivingStudentListCell *cell = xibArray.firstObject;
        
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
    
//    NSString * str = [NSString stringWithFormat:@"剩余%ld课时",(long)model.leavecoursecount];
//    if(model.missingcoursecount){
//        str = [str stringByAppendingFormat:@"漏%ld课时",(long)model.missingcoursecount];
//    }

    _appointmentLabel.text = @"暂无剩余课时";
    if (dmData.leavecoursecount) {
        _appointmentLabel.text = [NSString stringWithFormat:@"剩余%ld课时", (long)dmData.leavecoursecount];
    }
    _missedClassLabel.text = @"无漏课";
    if (dmData.missingcoursecount) {
        _missedClassLabel.text = [NSString stringWithFormat:@"漏%ld课时", (long)dmData.missingcoursecount];
    }
    
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
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[NSString stringWithFormat:@"%ld", (long)phoneNumber]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
