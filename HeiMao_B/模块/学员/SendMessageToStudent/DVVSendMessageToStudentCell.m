//
//  DVVSendMessageToStudentCell.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVSendMessageToStudentCell.h"

@implementation DVVSendMessageToStudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"DVVSendMessageToStudentCell" owner:self options:nil];
        DVVSendMessageToStudentCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
        
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"sendmsg_normal_icon"] forState:UIControlStateNormal];
        [_selectButton setBackgroundImage:[UIImage imageNamed:@"sendmsg_selected_icon"] forState:UIControlStateSelected];
        _selectButton.selected = YES;
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
    NSString *string = [NSString stringWithFormat:@"%d", dmData.mobile];
    if (string && string.length) {
        _selectButton.hidden = NO;
        _markLabel.hidden = YES;
    }else {
        _selectButton.hidden = YES;
        _markLabel.hidden = NO;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
