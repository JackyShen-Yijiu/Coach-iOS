//
//  JZNopassStudentCell.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZNopassStudentCell.h"

@implementation JZNopassStudentCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initUI{
    
    [self.contentView addSubview:self.studentIcon];
    [self.contentView addSubview:self.studentName];
    [self.contentView addSubview:self.StudentScore];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.studentIcon.layer.cornerRadius = 18;
    
    self.studentIcon.layer.masksToBounds = YES;

    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
   [self.studentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
      
       
       make.left.mas_equalTo(self.contentView.left).offset(16);
       make.top.mas_equalTo(self.contentView.top).offset(12);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       
       
   }];
    
    [self.studentName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.studentIcon.left).offset(16);
        make.centerY.mas_equalTo(self.contentView.centerY);
        make.height.mas_equalTo(14);
        
    }];
    
    [self.StudentScore mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.contentView.right).offset(16);
        make.height.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView.centerY);
        
    }];
}
// 重写ExamListData属性的set方法组cell里面的子控件设置数据
-(void)setExamListData:(JZExamStudentListData *)examListData{

    _examListData = examListData;
    
    NSURL *iconUrl = [NSURL URLWithString:examListData.userid.headportrait.originalpic];

    [self.studentIcon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"defoult_por"]];

    self.studentName.text = examListData.userid.name;
    self.StudentScore.text = examListData.score;
    

}



@end
