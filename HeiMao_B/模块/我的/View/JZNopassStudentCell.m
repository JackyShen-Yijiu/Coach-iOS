//
//  JZNopassStudentCell.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZNopassStudentCell.h"
#import "JZExamStudentListUserid.h"
#import "YYModel.h"

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
    
    self.studentIcon = [[UIImageView alloc]init];
    self.studentName = [[UILabel alloc]init];
    self.StudentScore = [[UILabel alloc]init];
    
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
      
       
       make.left.mas_equalTo(self.contentView.mas_left).offset(16);
       make.top.mas_equalTo(self.contentView.mas_top).offset(12);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       
       
   }];
    
    [self.studentName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        
        make.left.mas_equalTo(self.studentIcon.mas_right).offset(16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(14);
        
    }];
    
    [self.StudentScore mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(14);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        
    }];
}
// 重写ExamListData属性的set方法组cell里面的子控件设置数据
-(void)setExamListData:(JZExamStudentListData *)examListData{

    _examListData = examListData;
    NSLog(@"_examListData.userid:%@",_examListData.userid);
    
    JZExamStudentListUserid *userData = [JZExamStudentListUserid yy_modelWithDictionary:_examListData.userid];
    
    NSURL *iconUrl = [NSURL URLWithString:userData.headportrait.originalpic];

    [self.studentIcon sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"defoult_por"]];

    self.StudentScore.textColor = RGB_Color(110, 110, 110);
    
    self.studentName.text = userData.name;
    self.StudentScore.font = [UIFont systemFontOfSize:12];
    if (examListData.score.length > 0) {
        
        
        self.StudentScore.text = examListData.score;
      
    }else{
          self.StudentScore.text = @"暂无成绩";
    }
    
    self.studentName.font = [UIFont systemFontOfSize:14];
    
    
}



@end
