//
//  JZExamHeaderView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZExamHeaderView.h"
#import "JZPassStudentListController.h"
@interface JZExamHeaderView ()

@property (nonatomic, assign) NSInteger Buttontag;

@end

@implementation JZExamHeaderView


/// 创建examHeaderView
+ (instancetype)examHeaderViewWithTableView:(UITableView *)tableView withTag:(NSInteger)tag {
    
    // 1.定义一个重用标识
    static NSString *ID = @"JZExamHeader";
    
    // 2.通过重用标识先去缓存池找找可以重用的HaderView
    JZExamHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    
 
    
    // 3.如果缓存池中没有可重用的haderView时,手动创建headerView,并绑定重用标识
    if (headerView == nil) {
        headerView = [[JZExamHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
    
}


// 重写init初始化方法,让headerView创建出来就有它用来显示内容的所有子控件
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        self = [[NSBundle mainBundle]loadNibNamed:@"JZExamHeaderView" owner:self options:nil].lastObject;
        
        self.passCountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        self.passCountButton.titleLabel.numberOfLines = 0;
      
        self.studentCountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        self.studentCountButton.titleLabel.numberOfLines = 0;
        
        self.missExamStudentButton.titleLabel.numberOfLines = 0;
        
        self.missExamStudentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        
        if (YBIphone6Plus) {
            
            [self.examDataLabel setFont:[UIFont systemFontOfSize:14 * JZRatio_1_1_5]];

            [self.subjectLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
  
            [self.passCountButton.titleLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
            
            [self.passrateCountLabel setFont:[UIFont systemFontOfSize:14 * JZRatio_1_1_5]];

            [self.studentCountButton.titleLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
  
            [self.passCountButton.titleLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
            
            [self.missExamStudentButton.titleLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
            [self.passrateCountLabel setFont:[UIFont systemFontOfSize:14 * JZRatio_1_1_5]];
            
            [self.nopassCountLabel setFont:[UIFont systemFontOfSize:14 * JZRatio_1_1_5]];

            [self.passTitle setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];
 
        }
      
        
  
    }
    return self;
}

-(void)setModelGrop:(JZExamSummaryInfoData *)modelGrop {
    _modelGrop = modelGrop;
    
//    NSString *dateYear = [_modelGrop.examdate substringWithRange:NSMakeRange(0, 4)];
    //日期
//    if (_modelGrop.examdate.length == 9) {
//        
//        NSString *dateMonth = [_modelGrop.examdate substringWithRange:NSMakeRange(5, 1)];
//        NSString *dateDay = [_modelGrop.examdate substringWithRange:NSMakeRange(7, 2)];
//        self.examDataLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",dateYear,dateMonth,dateDay];
//    }else {
//        
//        NSString *dateMonth = [_modelGrop.examdate substringWithRange:NSMakeRange(5, 2)];
//        NSString *dateDay = [_modelGrop.examdate substringWithRange:NSMakeRange(8, 2)];
//        self.examDataLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",dateYear,dateMonth,dateDay];
//        
//    }
    
    self.examDataLabel.text = [self getYearLocalDateFormateUTCDate:_modelGrop.examdate];

    //科目
    if ([_modelGrop.subject isEqualToString:@"1"]) {
        
         self.subjectLabel.text = @"科目一考试";
        
    }else if ([_modelGrop.subject isEqualToString:@"2"]) {
        self.subjectLabel.text = @"科目二考试";

        
    }else if ([_modelGrop.subject isEqualToString:@"3"]) {
        self.subjectLabel.text = @"科目三考试";
    }else if ([_modelGrop.subject isEqualToString:@"4"]) {
        self.subjectLabel.text = @"科目四考试";
    }
    
    //报考
    [self.studentCountButton setTitle:[NSString stringWithFormat:@"报考\n%zd人",_modelGrop.studentcount] forState:UIControlStateNormal];
    //缺考
    [self.missExamStudentButton setTitle:[NSString stringWithFormat:@"缺考\n%zd人",_modelGrop.missexamstudent] forState:UIControlStateNormal];
    
    if (_modelGrop.passstudent == 0) {
        
        self.passCountButton.userInteractionEnabled = NO;
        [self.passCountButton setTitleColor:RGB_Color(202, 202, 202) forState:UIControlStateNormal];
    }
    
    //通过
    [self.passCountButton setTitle:[NSString stringWithFormat:@"通过\n%zd人",_modelGrop.passstudent] forState:UIControlStateNormal];
    //未通过
    self.nopassCountLabel.text = [NSString stringWithFormat:@"%zd人未通过",_modelGrop.nopassstudent];
    //通过率
    self.passrateCountLabel.text = [NSString stringWithFormat:@"%zd%%",_modelGrop.passrate];
    
    self.nopassView.backgroundColor = RGB_Color(242, 242, 242);
    

    
    // 判断当前组是否打开或关闭,对头上的图片是否旋转做判断
    // 如果是打开了,让按钮图片旋转
    if (self.modelGrop.openGroup == YES) {
        
        // 让按钮中的小图片旋转正的90度
        self.nopassDownImg.transform = CGAffineTransformMakeRotation(M_PI);
        
    } else {
        // 关闭让图片再还原
        self.nopassDownImg.transform = CGAffineTransformMakeRotation(0);
        
    }

    
    
}


// 布局"设置"子控件
- (void)layoutSubviews {

    [super layoutSubviews];
}
- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}


@end
