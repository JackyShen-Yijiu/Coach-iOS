//
//  courseSummaryDayCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseSummaryDayCell.h"
#import "YBAppointMentUserCell.h"
#import "YBObjectTool.h"
#import "LKAddStudentTimeViewController.h"
#import "LKTestViewController.h"



@interface CourseSummaryDayCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UIView *coureleftTopDelive;

@property (nonatomic,strong) UIImageView *coureleftStateImgView;
// 开始时间
@property (nonatomic,strong) UILabel * coureBeginTime;
// 结束时间
@property (nonatomic,strong) UILabel * coureEndTime;
// 已约、剩余名额
@property (nonatomic,strong) UILabel * coureTopCountLabel;
// 中间预约学员
@property (nonatomic,strong) UICollectionView *coureStudentCollectionView;
// 底部分割线
@property(nonatomic,strong)UIView * bottomLine;



@end

@implementation CourseSummaryDayCell

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
    
    self.coureleftTopDelive = [[UIView alloc] init];
    self.coureleftTopDelive.backgroundColor = JZ_BlueColor;
    [self.contentView addSubview:self.coureleftTopDelive];

    self.coureleftStateImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coureleftStateImgView];

    // 开始时间
    self.coureBeginTime = [self getOnePropertyLabel];
    self.coureBeginTime.font = [UIFont systemFontOfSize:14];
    self.coureBeginTime.textColor = JZ_BlueColor;
    self.coureBeginTime.textAlignment = NSTextAlignmentCenter;
    self.coureBeginTime.text = @"开始开始";
    [self.contentView addSubview:self.coureBeginTime];

    // 结束时间
    self.coureEndTime = [self getOnePropertyLabel];
    self.coureEndTime.font = [UIFont systemFontOfSize:12];
    self.coureEndTime.textColor = JZ_BlueColor;
    self.coureEndTime.textAlignment = NSTextAlignmentCenter;
    self.coureEndTime.text = @"结束结束";
    [self.contentView addSubview:self.coureEndTime];

    // 已约、剩余名额
    self.coureTopCountLabel = [self getOnePropertyLabel];
    self.coureTopCountLabel.font = [UIFont systemFontOfSize:14];
    self.coureTopCountLabel.textColor = JZ_BlueColor;
    self.coureTopCountLabel.textAlignment = NSTextAlignmentLeft;
    self.coureTopCountLabel.text = @"已约2人     剩余名额3人";
    [self.contentView addSubview:self.coureTopCountLabel];

    // 中间预约学员
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.itemSize = CGSizeMake(coureSundentCollectionW, coureSundentCollectionH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.coureStudentCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.coureStudentCollectionView.backgroundColor = [UIColor clearColor];
    self.coureStudentCollectionView.delegate = self;
    self.coureStudentCollectionView.dataSource = self;
    [self.coureStudentCollectionView registerClass:[YBAppointMentUserCell class] forCellWithReuseIdentifier:@"YBAppointMentUserCell"];
    self.coureStudentCollectionView.scrollEnabled = NO;
    [self.contentView addSubview:self.coureStudentCollectionView];

    // 底部分割线
    self.bottomLine = [self getOnelineView];
    [self.contentView addSubview:self.bottomLine];
    
    self.coureleftTopDelive.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coureleftTopDelive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(28);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.mas_top);
    }];
    
    self.coureleftStateImgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coureleftStateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(26);
        make.centerX.mas_equalTo(self.coureleftTopDelive.mas_centerX);
    }];
    
    // 开始时间
    self.coureBeginTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coureBeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coureStudentCollectionView.mas_top).offset(5);
        make.left.mas_equalTo(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    // 结束时间
    self.coureEndTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coureEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coureBeginTime.mas_bottom);
        make.left.mas_equalTo(self.coureBeginTime.mas_left);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    // 已约、剩余名额
    self.coureTopCountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.coureTopCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.left.mas_equalTo(self.coureleftTopDelive.mas_right).offset(36);
    }];
    
    self.coureStudentCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    
}

#pragma mark - Data
- (void)setModel:(YBCourseData *)model
{
    _model = model;
    
    self.coureBeginTime.text = [NSString getHourLocalDateFormateUTCDate:_model.coursebegintime];
    
    self.coureEndTime.text = [NSString getHourLocalDateFormateUTCDate:_model.courseendtime];
    
    int compareDataNum = [YBObjectTool compareHMSDateWithSelectDateStr:[NSString getLocalDateFormateUTCDate:_model.coursebegintime]];
    
    NSLog(@"compareDataNum:%d",compareDataNum);
    
    NSInteger leftStr;
    NSInteger rightStr;
    
    if (compareDataNum==0) {// 当前
        self.coureleftStateImgView.image = [UIImage imageNamed:@"JZCoursenode_now"];
        // 已约、剩余名额
        leftStr = _model.selectedstudentcount;
        rightStr = _model.coursestudentcount - _model.selectedstudentcount;
        self.coureTopCountLabel.text = [NSString stringWithFormat:@"已约%ld     剩余名额%ld",(long)leftStr,(long)rightStr];
        self.coureTopCountLabel.textColor = JZ_BlueColor;
        
        self.contentView.backgroundColor = RGB_Color(255, 255, 255);
        self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0, 2);
        self.contentView.layer.shadowOpacity = 0.036;
        self.contentView.layer.shadowRadius = 2;
        
    }else if (compareDataNum==1){// 大于当前日期
        self.coureleftStateImgView.image = [UIImage imageNamed:@"JZCoursenode_future"];
        // 已约、剩余名额
        leftStr = _model.selectedstudentcount;
        rightStr = _model.coursestudentcount - _model.selectedstudentcount;
        self.coureTopCountLabel.text = [NSString stringWithFormat:@"已约%ld     剩余名额%ld",(long)leftStr,(long)rightStr];
        self.coureTopCountLabel.textColor = [UIColor lightGrayColor];

        self.contentView.backgroundColor = RGB_Color(255, 255, 255);
        self.contentView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
        self.contentView.layer.shadowOpacity = 0;
        self.contentView.layer.shadowRadius = 0;
        
    }else if (compareDataNum==-1){// 小于当前日期
        self.coureleftStateImgView.image = [UIImage imageNamed:@"JZCoursenode_past"];
        
        self.contentView.backgroundColor = RGB_Color(243, 243, 246);
        self.contentView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
        self.contentView.layer.shadowOpacity = 0;
        self.contentView.layer.shadowRadius = 0;
        
        // 已学、漏课
        leftStr = _model.signinstudentcount;
        rightStr = _model.coursestudentcount - _model.signinstudentcount;
        self.coureTopCountLabel.text = [NSString stringWithFormat:@"已学%ld     漏课%ld",(long)leftStr,(long)rightStr];
        self.coureTopCountLabel.textColor = [UIColor lightGrayColor];

    }
    
    // 中间预约学员
    CGFloat height = _model.appointMentViewH;
    NSLog(@"中间预约学员height:%f",height);
    [self.coureStudentCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coureTopCountLabel.mas_bottom).offset(12);
        make.height.mas_equalTo(height);
        make.left.mas_equalTo(self.coureTopCountLabel.mas_left);
        make.right.mas_equalTo(self).offset(-10);
    }];

    [self.bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@(HM_LINE_HEIGHT));
        make.left.equalTo(self.coureTopCountLabel.mas_left);
        make.top.mas_equalTo(self.coureStudentCollectionView.mas_bottom).offset(12);
    }];
    
    [self.coureleftTopDelive mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(28);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.bottomLine.mas_bottom);
    }];
    
    self.coureBeginTime.backgroundColor = self.contentView.backgroundColor;
    self.coureEndTime.backgroundColor = self.contentView.backgroundColor;
    
    [self.coureStudentCollectionView reloadData];
    
}

#pragma mark - Common
- (UIView *)getOnelineView
{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = HM_LINE_COLOR;
    return view;
}

- (UILabel *)getOnePropertyLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.text = @"getOnePropertyLabel";
    label.font = [UIFont systemFontOfSize:16.f];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

+ (CGFloat)cellHeightWithModel:(YBCourseData *)model
{
    
    CourseSummaryDayCell *cell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CourseSummaryDayCell"];
    
    cell.model = model;
    
    [cell layoutIfNeeded];
    
    return cell.coureTopCountLabel.height + cell.coureStudentCollectionView.height + 12 * 3 + 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"_model.coursestudentcount:%ld",(long)_model.coursestudentcount);
    NSLog(@"_model.coursereservationdetial:%@",_model.coursereservationdetial);
    
    return _model.coursestudentcount;// 2
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"YBAppointMentUserCell";
    YBAppointMentUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.userInteractionEnabled = YES;
    cell.iconImageView.image = [UIImage imageNamed:@""];
    
    if (_model.coursereservationdetial && _model.coursereservationdetial.count>indexPath.row) {
        
        NSDictionary *dict = _model.coursereservationdetial[indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dict[@"userid"][@"headportrait"][@"originalpic"]]] placeholderImage:[UIImage imageNamed:@"JZCoursenull_student"]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"userid"][@"name"]];
        
    }else{
        
        // 1:大于当前日期 -1:小于当前时间 0:等于当前时间
        int compareDataNum = [YBObjectTool compareHMSDateWithSelectDateStr:[NSString getLocalDateFormateUTCDate:_model.coursebegintime]];
        NSLog(@"cellForItemAtIndexPath compareDataNum:%d",compareDataNum);
        
        if (compareDataNum==0) {
            cell.iconImageView.image = [UIImage imageNamed:@"JZCourseadd_student"];
        }else if (compareDataNum==-1){
            cell.iconImageView.image = [UIImage imageNamed:@"JZCoursenull_student"];
            cell.userInteractionEnabled = NO;
        }else if (compareDataNum==1){
            cell.iconImageView.image = [UIImage imageNamed:@"JZCourseadd_student"];
            cell.userInteractionEnabled = YES;
        }
        
        
    }
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
//    NSString *timeStr = self.model.coursebegintime;
////
////    NSString *timeText = [timeStr substringWithRange:NSMakeRange(11, 5)];
//    NSLog(@"%@",timeStr);

    //    NSLog(@"%s",__func__);
    
    LKAddStudentTimeViewController *addStuVC = [[LKAddStudentTimeViewController alloc] init];
    

    NSLog(@"self.model.coursebegintime:%@",self.model.coursebegintime);
    NSLog(@"self.model.courseendtime:%@",self.model.courseendtime);
    
    addStuVC.starTimeText = self.model.coursebegintime;
    addStuVC.finishTimeText = self.model.courseendtime;
    
    addStuVC.coachidStr = self.model.coachid;
    
//    LKTestViewController *addStuVC = [[LKTestViewController alloc]init];
    [self.parentViewController.navigationController pushViewController:addStuVC animated:YES];
    
    

  
}

@end
