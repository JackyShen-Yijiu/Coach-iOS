//
//  JZExamHeaderView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZExamHeaderView.h"

@interface JZExamHeaderView ()

///// 日期控件
//@property (nonatomic, weak) UILabel *examDataLabel;
//
///// 考试科目控件
//@property (nonatomic, strong) UILabel *subjectLabel;
//
///// 通过率 “百分比”
//@property (nonatomic, weak) UILabel *passrateCountLabel;
//
///// 通过率 文字“通过率”
//@property (nonatomic, weak) UILabel *passrateLabel;
//
///// 报考数量
//@property (nonatomic, weak) UILabel *studentCountLabel;
//
///// 通过数量--按钮
//@property (nonatomic, weak) UIButton *passCountButton;
//
///// 未通过数量--按钮
//@property (nonatomic, weak) UIButton *nopassCountButton;
//
///// 缺考学生数量
//@property (nonatomic, weak) UILabel *missExamStudentLabel;

@end

@implementation JZExamHeaderView


/// 创建examHeaderView
+ (instancetype)examHeaderViewWithTableView:(UITableView *)tableView {
    
    // 1.定义一个重用标识
    static NSString *ID = @"JZExamHeader";
    
    // 2.通过重用标识先去缓存池找找可以重用的HaderView
    JZExamHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
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
        
        self.examDataLabel.text = @"2016年10日10kjffbeuiwffefe";
        self.subjectLabel.text = @"科目二fkewnioeoiervoerovir";
        [self.passCountButton setTitle:@"通过\n51人" forState:UIControlStateNormal];
        
        self.passCountButton.titleLabel.numberOfLines = 0;
        self.passrateCountLabel.text = @"80%";
        self.studentCountLabel.text = @"报考\n100人";
//        self.nopassCountLabel.text = @"7人未通过";
        self.missExamStudentLabel.text = @"缺考\n100人";
        
        
        
        
        
    }
    return self;
}

-(void)setModelGrop:(JZExamSummaryInfoData *)modelGrop {
    _modelGrop = modelGrop;
    
    self.nopassCountLabel.text = [NSString stringWithFormat:@"%zd",_modelGrop.nopassstudent];
}




// 当点击headerView中的按钮时会调用此方法

- (void)headerBtnClick:(UIButton *)headerBtn {
    
    
    
    
    
}

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

// 当子控件即将被添加到父控件中时会调用此方法
// 子控件已经被添加到父控件中
- (void)didMoveToSuperview {
    NSLog(@"%s", __FUNCTION__);
}




@end
