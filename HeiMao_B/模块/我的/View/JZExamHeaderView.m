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
        
      
        
  
    }
    return self;
}

-(void)setModelGrop:(JZExamSummaryInfoData *)modelGrop {
    _modelGrop = modelGrop;
    
    NSString *dateYear = [_modelGrop.examdate substringWithRange:NSMakeRange(0, 4)];
    //日期
    if (_modelGrop.examdate.length == 9) {
        
        NSString *dateMonth = [_modelGrop.examdate substringWithRange:NSMakeRange(5, 1)];
        NSString *dateDay = [_modelGrop.examdate substringWithRange:NSMakeRange(7, 2)];
        self.examDataLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",dateYear,dateMonth,dateDay];
    }else {
        
        NSString *dateMonth = [_modelGrop.examdate substringWithRange:NSMakeRange(5, 2)];
        NSString *dateDay = [_modelGrop.examdate substringWithRange:NSMakeRange(8, 2)];
        self.examDataLabel.text = [NSString stringWithFormat:@"%@年%@月%@日",dateYear,dateMonth,dateDay];
        
    }

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

//@property (nonatomic, strong) NSString *examDate;
//
//@property (nonatomic, strong) NSString *subjectID;
//-(void)toPassStudent {
//    
//    
//    JZPassStudentListController *VC = [[JZPassStudentListController alloc]init];
//    
//    
//    
//    
//    
//}



// 布局"设置"子控件
- (void)layoutSubviews {

    [super layoutSubviews];
}

//测试不用的代码
-(void)test {
    
    
    //
    //    /// 通过率 “百分比”
    //    @property (nonatomic, weak) UILabel *passrateCountLabel;
    //
    //    /// 通过率 文字“通过率”
    //    @property (nonatomic, weak) UILabel *passrateLabel;
    //
    //    /// 报考数量
    //    @property (nonatomic, weak) UILabel *studentCountLabel;
    //
    //    /// 通过数量--按钮
    //    @property (nonatomic, weak) UIButton *passCountButton;
    //
    //    /// 未通过数量--按钮
    //    @property (nonatomic, weak) UIButton *nopassCountButton;
    //
    //    /// 缺考学生数量
    //    @property (nonatomic, weak) UILabel *missExamStudentLabel;
    //        UILabel *examDataLabel = [[UILabel alloc]init];
    //        examDataLabel.textColor = JZ_FONTCOLOR_DRAK;
    //        [self.contentView addSubview:examDataLabel];
    //        self.examDataLabel = examDataLabel;
    //
    //
    //        UILabel *subjectLabel = [[UILabel alloc]init];
    //        subjectLabel.textColor = JZ_FONTCOLOR_LIGHT;
    //        [self.contentView addSubview:subjectLabel];
    //        self.subjectLabel = subjectLabel;
    //
    //        UILabel *passrateCountLabel = [[UILabel alloc]init];
    //        passrateCountLabel.textColor = RGB_Color(230, 46, 72);
    //        [self.contentView addSubview:passrateCountLabel];
    //        self.passrateLabel = passrateCountLabel;
    //
    //        UILabel *passrateLabel = [[UILabel alloc]init];
    //        passrateLabel.textColor = JZ_FONTCOLOR_LIGHT;
    //        [self.contentView addSubview:passrateLabel];
    //        self.passrateLabel = passrateLabel;
    //
    //
    //        UILabel *studentCountLabel = [[UILabel alloc]init];
    //        studentCountLabel.textColor = JZ_FONTCOLOR_LIGHT;
    //        [self.contentView addSubview:studentCountLabel];
    //        self.studentCountLabel = studentCountLabel;
    //
    //        UIButton *passCountButton = [[UIButton alloc]init];
    //        [passCountButton setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
    //        [self.contentView addSubview:passCountButton];
    //        self.passCountButton = passCountButton;
    //
    //        UIButton *nopassCountButton = [[UIButton alloc]init];
    //        [nopassCountButton setTitleColor:JZ_FONTCOLOR_DRAK forState:UIControlStateNormal];
    ////        nopassCountButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        //按钮内部内边距
    //        nopassCountButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    //        nopassCountButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    //        nopassCountButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //        [nopassCountButton setImage:[UIImage imageNamed:@"JZCoursemore_dwon"] forState:UIControlStateNormal];
    //        //让按钮中的图片居中显示
    //        nopassCountButton.imageView.contentMode = UIViewContentModeCenter;
    //        //设置按钮内图片超出边界不剪切
    //        nopassCountButton.imageView.clipsToBounds = NO;
    //        //给按钮添加一个点击事件
    //        [nopassCountButton addTarget:self action:@selector(headerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.contentView addSubview:nopassCountButton];
    //        self.nopassCountButton = nopassCountButton;
    //
    //
    //        UILabel *missExamStudentLabel = [[UILabel alloc]init];
    //        missExamStudentLabel.textColor = JZ_FONTCOLOR_LIGHT;
    //        [self.contentView addSubview:missExamStudentLabel];
    //        self.missExamStudentLabel = missExamStudentLabel;
    //
    
    //    /// 日期控件
    //    @property (nonatomic, weak) UILabel *examDataLabel;
//    [self.examDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.contentView.top).offset(16);
//        make.left.mas_equalTo(self.contentView.left).offset(16);
//        make.height.mas_equalTo(14);
//    }];
//    
//    //    /// 考试的科目控件
//    //    @property (nonatomic, weak) UILabel *subjectLabel;
//    [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.examDataLabel.top).offset(8);
//        make.left.mas_equalTo(self.contentView.left).offset(8);
//        
//        
//    }];
    //

}

@end
