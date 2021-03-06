//
//  courseDetailCell.m
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseDetailView.h"
#import "HMButton.h"
#import "NSUserStoreTool.h"

@interface CourseDetailView()
@property(nonatomic,strong)HMButton * studentBgView;
@property(nonatomic,strong)PortraitView * potraitView;
@property(nonatomic,strong)UILabel * mainTitle;
@property(nonatomic,strong)UILabel * subTitle;
@property(nonatomic,strong)UILabel * statueLabel;

@property(nonatomic,strong)UILabel * courseProgressTtile;
@property(nonatomic,strong)UILabel * courseProgressInfo;

@property(nonatomic,strong)UILabel * courseInfoTitle;
@property(nonatomic,strong)UILabel * courseTimeLabel;
@property(nonatomic,strong)UILabel * courseAddressLabel;
@property(nonatomic,strong)UILabel * pickAddressLabel;

@property(nonatomic,strong)UIView * midLine;
@property(nonatomic,strong)HMButton * leftButton;
@property(nonatomic,strong)HMButton * rightButton;


@property(nonatomic,strong)UILabel * commentTtile;
@property(nonatomic,strong)UILabel * commentInfo;

@end


@implementation CourseDetailView
+ (CGFloat)cellHeightWithModel:(HMCourseModel *)model
{
    CGFloat heigth =  90 //头像
            + 16 + 14 + 10 + 14 //学习进度
            + 18
            + 14 + 10
            + 14 + 10
            + 14 + 10
            + 14
            + 15 + 45 + 20; //Button;
    if (!model.coursePikerAddres) {
        heigth-=24;
    }
    return heigth;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{

    self.backgroundColor = [UIColor clearColor];
    self.potraitView = [[PortraitView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.potraitView.layer.cornerRadius = 1.f;
    self.potraitView.layer.shouldRasterize = YES;
    self.potraitView.backgroundColor = [UIColor redColor];
    [self.studentBgView addSubview:self.potraitView];
    
    self.mainTitle = [[UILabel alloc] init];
    self.mainTitle.textAlignment = NSTextAlignmentLeft;
    self.mainTitle.font = [UIFont boldSystemFontOfSize:16.f];
    self.mainTitle.textColor = RGB_Color(0x33, 0x33, 0x33);
    self.mainTitle.backgroundColor = [UIColor clearColor];
    self.mainTitle.numberOfLines = 1;
    [self.studentBgView addSubview:self.mainTitle];
    
    
    self.subTitle = [[UILabel alloc] init];
    self.subTitle.textAlignment = NSTextAlignmentLeft;
    self.subTitle.font = [UIFont systemFontOfSize:14.f];
    self.subTitle.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.subTitle.backgroundColor = [UIColor clearColor];
    self.subTitle.numberOfLines = 2;
    [self.studentBgView addSubview:self.subTitle];
    
    self.statueLabel = [[UILabel alloc] init];
    self.statueLabel.textAlignment = NSTextAlignmentRight;
    self.statueLabel.font = [UIFont systemFontOfSize:14.f];
    self.statueLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.statueLabel.backgroundColor = [UIColor clearColor];
    self.statueLabel.numberOfLines = 1;
    [self.studentBgView addSubview:self.statueLabel];
    
    
    self.courseProgressTtile = [self getOnePropertyLabel];
    self.courseProgressTtile.font = [UIFont boldSystemFontOfSize:14.f];
    [self addSubview:self.courseProgressTtile];
    self.courseProgressInfo = [self getOnePropertyLabel];
    [self addSubview:self.courseProgressInfo];
    self.courseProgressInfo.numberOfLines = 0;
    
    self.commentTtile = [self getOnePropertyLabel];
    self.commentTtile.font = [UIFont boldSystemFontOfSize:14.f];
    [self addSubview:self.commentTtile];
    self.commentInfo = [self getOnePropertyLabel];
    self.commentInfo.numberOfLines = 0;
    [self addSubview:self.commentInfo];
    
    self.courseInfoTitle = [self getOnePropertyLabel];
    self.courseInfoTitle.font = [UIFont boldSystemFontOfSize:14.f];
    [self addSubview:self.courseInfoTitle];
    
    self.courseTimeLabel = [self getOnePropertyLabel];
    [self addSubview:self.courseTimeLabel];
    
    self.courseAddressLabel = [self getOnePropertyLabel];
    [self addSubview:self.courseAddressLabel];

    self.pickAddressLabel = [self getOnePropertyLabel];
    [self addSubview:self.pickAddressLabel];
    
    
    self.midLine = [self getOnelineView];
    [self addSubview:self.midLine];
    
    
    self.leftButton = [self getOnePropertybutton];
    self.leftButton.tag = 100;
    [self addSubview:self.leftButton];
    
    self.rightButton = [self getOnePropertybutton];
    self.rightButton.tag = 200;
    [self addSubview:self.rightButton];
    
    [self updateConstraints];
}


#pragma mark Layout
- (void)updateConstraints
{
    [super updateConstraints];
    
    CGFloat leftOffsetSpacing = 15.f;
    
    [self.studentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(90.f));
    }];
    
    [self.potraitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentBgView).offset(leftOffsetSpacing);
        make.top.equalTo(self.studentBgView).offset(15.f);
        make.size.mas_equalTo(CGSizeMake(60.f, 60.f));
    }];
    
    [self.statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.studentBgView).offset(14.f);
        make.right.equalTo(self.studentBgView).offset(-leftOffsetSpacing);
        make.left.equalTo(self.mainTitle.mas_right).offset(10);
    }];
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.potraitView.mas_right).offset(12.f);
        make.height.equalTo(@(16.f));
        make.top.equalTo(@((90 - 16 - 10 - 14)/2.f));
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mainTitle);
        make.right.equalTo(self.studentBgView).offset(-leftOffsetSpacing);
        //make.width.equalTo(self.mainTitle);
        make.top.equalTo(self.mainTitle.mas_bottom).offset(10.f);
        //make.height.equalTo(@(16.f));
    }];
    
    [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studentBgView).offset(leftOffsetSpacing);
        make.right.equalTo(self.studentBgView).offset(-leftOffsetSpacing);
        make.top.equalTo(self.potraitView.mas_bottom).offset(15.f);
        make.height.equalTo(@(HM_LINE_HEIGHT));
    }];
    
    // 学习进展
    [self.courseProgressTtile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftOffsetSpacing);
        make.right.equalTo(self).offset(-leftOffsetSpacing);
        make.top.equalTo(self.midLine.mas_top).offset(16.f);
        make.height.equalTo(@(14.f));
    }];
    [self.courseProgressInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.courseProgressTtile.mas_bottom).offset(10.f);
        make.left.equalTo(self).offset(leftOffsetSpacing);
        make.right.equalTo(self).offset(-leftOffsetSpacing);
    }];

    [self.courseInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseProgressInfo);
        make.left.equalTo(self.courseProgressInfo);
        make.top.equalTo(self.courseProgressInfo.mas_bottom).offset(18.f);
    }];

    [self.courseTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseInfoTitle);
        make.left.equalTo(self.courseInfoTitle);
        make.top.equalTo(self.courseInfoTitle.mas_bottom).offset(10.f);
    }];

    
    [self.courseAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseTimeLabel);
        make.top.equalTo(self.courseTimeLabel.mas_bottom).offset(10.f);
        make.centerX.equalTo(self.courseTimeLabel);
    }];
    
    [self.pickAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.courseAddressLabel);
        make.top.equalTo(self.courseAddressLabel.mas_bottom).offset(10.f);
        make.centerX.equalTo(self.courseAddressLabel);
    }];

    [self.commentTtile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(leftOffsetSpacing);
        make.right.equalTo(self).offset(-leftOffsetSpacing);
        make.top.equalTo(self.pickAddressLabel.mas_top).offset(25.f);
        make.height.equalTo(@(14.f));
    }];
    [self.commentInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentTtile.mas_bottom).offset(10.f);
        make.left.equalTo(self.commentTtile);
        make.width.equalTo(self.commentTtile.mas_width);
    }];
    
//    [self.leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(leftOffsetSpacing);
//        make.top.equalTo(self.pickAddressLabel.mas_bottom).offset(15.f);
//        make.height.equalTo(@(45.f));
//        if (self.rightButton.isHidden) {
//            make.right.equalTo(self).offset(-leftOffsetSpacing);
//        }
//    }];
//    
//    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.leftButton);
//        make.height.equalTo(self.leftButton);
//        
//        if (!self.rightButton.isHidden) {
//            make.left.equalTo(self.leftButton.mas_right).offset(15.f);
//            make.width.equalTo(self.leftButton);
//            make.right.equalTo(self).offset(-15.f);
//        }else{
//            make.left.equalTo(self.mas_right);
//        }
//     
//        
//    }];
//    

   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.rightButton.isHidden) {
        self.leftButton.frame = CGRectMake(15, self.pickAddressLabel.bottom + 15, self.width - 30, 45);
    }else{
        CGFloat width = (self.width - 30 - 15)/2.f;
        self.leftButton.frame = CGRectMake(15, self.pickAddressLabel.bottom + 15, width, 45);
        self.rightButton.frame = CGRectMake(self.leftButton.right + 15, self.leftButton.top, width, 45);
    }
}
#pragma mark - Data
- (void)setModel:(HMCourseModel *)model
{
    if (_model == model) {
        return;
    }
    _model = model;
    [self refreshUI];
}

- (void)refreshUI
{
    UIImage * defaultImage = [UIImage imageNamed:@"defoult_por"];
    self.potraitView.imageView.image = defaultImage;
    NSString * imageStr = _model.studentInfo.porInfo.originalpic;
    if(imageStr)
        [self.potraitView.imageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:defaultImage];
    
    self.mainTitle.text = _model.studentInfo.userName;
    NSLog(@"_model.studentInfo.courseProgress:%@",_model.courseProgress);
    self.subTitle.text = _model.courseProgress;
    self.statueLabel.text = [_model getStatueString];
    
    self.courseProgressTtile.text = @"学习进展";
    self.courseProgressInfo.text = _model.courseProgress;
    
    self.courseInfoTitle.text = @"课程信息";
    NSLog(@"_model.courseTime:%@",_model.courseTime);
    self.courseTimeLabel.text = _model.courseTime;
    self.courseAddressLabel.text = [NSString stringWithFormat:@"训练场地: %@",_model.courseTrainInfo.address];
    if (_model.coursePikerAddres) {
        self.pickAddressLabel.text = [NSString stringWithFormat:@"接送地点: %@",_model.coursePikerAddres];
    }else{
        self.pickAddressLabel.text = nil;
    }
    
    if ((_model.coachcomment && [_model.coachcomment length]!=0) || (_model.comment && [_model.comment length]!=0)) {
        
        self.commentTtile.text = @"评价记录";
        self.commentInfo.text = _model.coachcomment ? _model.cancelreason : _model.comment;
        
    }else if (_model.cancelreason && [_model.cancelreason length]!= 0) {
        
        self.commentInfo.text = @"拒绝理由";
        self.commentInfo.text = _model.cancelreason;
        
    }else{
        
        self.commentTtile.hidden = YES;
        self.commentInfo.hidden = YES;
        
    }
    
    [self.leftButton setHidden:NO];
    [self.rightButton setHidden:YES];
    
    switch (_model.courseStatue) {
            
        case  KCourseStatueInvalid :
            break;
        case  KCourseStatueapplying :   // "预约中"（待接受）
        {
            [self.leftButton setTitle:@"拒绝" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"拒绝" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
            self.leftButton.layer.borderColor = RGB_Color(201, 201, 201).CGColor;
            self.leftButton.layer.borderWidth = 1.f;
            
            [self.rightButton setHidden:NO];
            [self.rightButton setTitle:@"接受" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"接受" forState:UIControlStateHighlighted];
            [self.rightButton setTitleColor:RGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
            [self.rightButton setNBackColor:[UIColor whiteColor]];
            [self.rightButton setHBackColor:RGB_Color(0xe5, 0xe5, 0xe5)];
            self.rightButton.layer.masksToBounds = YES;
            self.rightButton.layer.cornerRadius = 2;
            self.rightButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
            self.rightButton.layer.borderWidth = 0.5;
            
            // 自动接收预约
            NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
            NSLog(@"自动接收预约num:%d",num.intValue);
            if (num&&num.intValue==0) {// 未自动接收预约
                [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.rightButton setNBackColor:RGB_Color(31, 124, 235)];
                [self.rightButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
                
            }
            
        }
            
            break;
        case  KCourseStatueapplycancel :// 学生取消（已取消）

            
            break;
        case  KCourseStatueapplyconfirm:  // "新订单"（已接受）
        {
            // 自动接收预约
            NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
            NSLog(@"自动接收预约num:%d",num.intValue);
            if (num&&num.intValue==1) {// 自动接收预约
                
                [self.leftButton setTitle:@"拒绝" forState:UIControlStateNormal];
                [self.leftButton setTitle:@"拒绝" forState:UIControlStateHighlighted];
                [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
                [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
                self.leftButton.layer.borderColor = RGB_Color(201, 201, 201).CGColor;
                self.leftButton.layer.borderWidth = 1.f;
                
                [self.rightButton setHidden:NO];
                [self.rightButton setTitle:@"接受" forState:UIControlStateNormal];
                [self.rightButton setTitle:@"接受" forState:UIControlStateHighlighted];
                [self.rightButton setTitleColor:RGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
                [self.rightButton setNBackColor:[UIColor whiteColor]];
                [self.rightButton setHBackColor:RGB_Color(0xe5, 0xe5, 0xe5)];
                self.rightButton.layer.masksToBounds = YES;
                self.rightButton.layer.cornerRadius = 2;
                self.rightButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
                self.rightButton.layer.borderWidth = 0.5;
                
            }
        }
       
            break;
        case  KCourseStatueapplyrefuse:      // 教练拒绝或者取消（已取消）

            break;
        case  KCourseStatueunconfirmfinish: //  待确认完成------------无此状态

            break;
        case  KCourseStatueucomments:    // 待评论(待评论)
        {
            [self.leftButton setTitle:@"评论" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"评论" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
        }
            break;
//        case  KCourseStatueOnCommended: // 评论成功（已完成）
//
//            [self.leftButton setHidden:YES];
//            [self.rightButton setHidden:YES];
//            
//            break;
        case  KCourseStatuefinish: // 订单完成（已完成）
          
            self.leftButton.hidden = YES;
            
            break;
        case  KCourseStatuesystemcancel: // 系统取消（已取消）

            
            break;
        case  KCourseStatuesignin: // 已签到(新订单)
        {
            [self.leftButton setTitle:@"确定学完" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"确定学完" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
        }
            
            break;
        case  KCourseStatuenosignin: // 未签到(已完成)
//        {
//            [self.rightButton setHighlighted:YES];
//            [self.leftButton setTitle:@"取消课程" forState:UIControlStateNormal];
//            [self.leftButton setTitle:@"取消课程" forState:UIControlStateHighlighted];
//            [self.leftButton setNBackColor:RGB_Color(205, 212, 217)];
//            [self.leftButton setHBackColor:HM_HIGHTCOLOR];
//            
//        }
            break;
            
    }
    
    
    /*
    switch (_model.courseStatue) {
            
        case KCourseStatueInvalid:
            break;
        case KCourseStatueStudentReject:
            break;
            
        case KCourseStatueRequest:
        {
            [self.leftButton setTitle:@"拒绝" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"拒绝" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:RGB_Color(0x33, 0x33, 0x33) forState:UIControlStateNormal];
            [self.leftButton setNBackColor:[UIColor whiteColor]];
            [self.leftButton setHBackColor:RGB_Color(0xe5, 0xe5, 0xe5)];
            self.leftButton.layer.borderColor = RGB_Color(201, 201, 201).CGColor;
            self.leftButton.layer.borderWidth = 1.f;
            
            [self.rightButton setHidden:NO];
            [self.rightButton setTitle:@"接受" forState:UIControlStateNormal];
            [self.rightButton setTitle:@"接受" forState:UIControlStateHighlighted];
            [self.rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.rightButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.rightButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
        }
            
            break;
        case KCourseStatueUnderWay:
        {
            [self.rightButton setHighlighted:YES];
            [self.leftButton setTitle:@"取消课程" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"取消课程" forState:UIControlStateHighlighted];
            [self.leftButton setNBackColor:RGB_Color(205, 212, 217)];
            [self.leftButton setHBackColor:HM_HIGHTCOLOR];
            
        }
            break;
        case KCourseStatueWatingToDone:
        {
            [self.leftButton setTitle:@"确定学完" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"确定学完" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
        }
            break;
        case KCourseStatueOnDone:
        {
            [self.leftButton setTitle:@"评论" forState:UIControlStateNormal];
            [self.leftButton setTitle:@"评论" forState:UIControlStateHighlighted];
            [self.leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.leftButton setNBackColor:RGB_Color(31, 124, 235)];
            [self.leftButton setHBackColor:RGB_Color(0x24, 0x6d, 0xd0)];
        }
            break;
        case KCourseStatueCanceld:
        {
            
        }
            break;
        case KCourseStatueOnCommended:
        {
            [self.leftButton setHidden:YES];
            [self.rightButton setHidden:YES];
        }
            break;
    }
     */
    
    //    [self setNeedsUpdateConstraints];
    [self setNeedsLayout];
}

#pragma marl - Action
- (void)userInfoButtonClick:(UIButton *)button
{
    NSLog(@"%s",__func__);
//    if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickStudentDetail:)]) {
//        [_delegate courseDetailViewDidClickStudentDetail:self];
//    }
}

- (void)buttonClick:(UIButton *)button
{
    
    switch (_model.courseStatue) {
            
        case  KCourseStatueInvalid :
            break;
        case  KCourseStatueapplying :   // "预约中"（待接受）
        {
            if (button.tag == 200) {// 接收
                
                // 自动接收预约
                NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
                NSLog(@"自动接收预约num:%d",num.intValue);
                if (num&&num.intValue==0) {// 未自动接收预约
                    
                    if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickAgreeButton:)]) {
                        [_delegate courseDetailViewDidClickAgreeButton:self];
                    }
                    
                }
                
            }else{// 拒绝
                
                if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickDisAgreeButton:)]) {
                    [_delegate courseDetailViewDidClickDisAgreeButton:self];
                }
            }
        }
            
            break;
        case  KCourseStatueapplycancel :// 学生取消（已取消）
            
            
            break;
        case  KCourseStatueapplyconfirm:  // "新订单"（已接受）
        {
            // 自动接收预约
            NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
            NSLog(@"自动接收预约num:%d",num.intValue);
            if (num&&num.intValue==1) {// 自动接收预约
                
                if (button.tag == 200) {// 接收
//                    
//                    // 自动接收预约
//                    NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
//                    NSLog(@"自动接收预约num:%d",num.intValue);
//                    if (num&&num.intValue==0) {// 未自动接收预约
//                        
//                        if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickAgreeButton:)]) {
//                            [_delegate courseDetailViewDidClickAgreeButton:self];
//                        }
//                        
//                    }
                    
                }else{// 拒绝
                    
                    if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickDisAgreeButton:)]) {
                        [_delegate courseDetailViewDidClickDisAgreeButton:self];
                    }
                }
                
            }
        }
            break;
        case  KCourseStatueapplyrefuse:      // 教练拒绝或者取消（已取消）
            
            break;
        case  KCourseStatueunconfirmfinish: //  待确认完成------------无此状态
            
            break;
        case  KCourseStatueucomments:    // 待评论(待评论)
        {
            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickRecommentButton:)]) {
                [_delegate courseDetailViewDidClickRecommentButton:self];
            }
        }
            break;
//        case  KCourseStatueOnCommended: // 评论成功（已完成）
//            
//            [self.leftButton setHidden:YES];
//            [self.rightButton setHidden:YES];
//            
//            break;
        case  KCourseStatuefinish: // 订单完成（已完成）
            
            break;
        case  KCourseStatuesystemcancel: // 系统取消（已取消）
            
            
            break;
        case  KCourseStatuesignin: // 已签到(新订单)
        {
            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickWatingToDone:)]) {
                [_delegate courseDetailViewDidClickWatingToDone:self];
            }
        }
            
            break;
        case  KCourseStatuenosignin: // 未签到(已完成)
//        {
//            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickCanCelButton:)]) {
//                [_delegate courseDetailViewDidClickCanCelButton:self];
//            }
//            
//        }
            break;
            
    }
    
    /*
    switch (_model.courseStatue) {
            
        case KCourseStatueInvalid:
            break;
        case KCourseStatueStudentReject:
            break;
            
        case KCourseStatueRequest:
        {
            if (button.tag == 200) {
                if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickAgreeButton:)]) {
                    [_delegate courseDetailViewDidClickAgreeButton:self];
                }
            }else{
                if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickDisAgreeButton:)]) {
                    [_delegate courseDetailViewDidClickDisAgreeButton:self];
                }
            }
        }
    
            break;
        case KCourseStatueUnderWay:
        {
            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickCanCelButton:)]) {
                [_delegate courseDetailViewDidClickCanCelButton:self];
            }
            
        }
            break;
        case KCourseStatueWatingToDone:
        {
            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickWatingToDone:)]) {
                [_delegate courseDetailViewDidClickWatingToDone:self];
            }
        }
            break;
        case KCourseStatueOnDone:
        {
            if ([_delegate respondsToSelector:@selector(courseDetailViewDidClickRecommentButton:)]) {
                [_delegate courseDetailViewDidClickRecommentButton:self];
            }
        }
            break;
        case KCourseStatueCanceld:
        {
            
        }
            break;
        case KCourseStatueOnCommended:
        {
            
        }
            break;
    }
     */

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
    label.font = [UIFont systemFontOfSize:14.f];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = RGB_Color(0x33, 0x33, 0x33);
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    return label;
}

- (HMButton *)getOnePropertybutton
{
    HMButton * button = [HMButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    return button;
}

- (HMButton *)studentBgView
{
    if (!_studentBgView) {
        _studentBgView = [[HMButton alloc] init];
        _studentBgView.hBackColor = HM_HIGHTCOLOR;
        _studentBgView.nBackColor = [UIColor clearColor];
        [_studentBgView addTarget:self action:@selector(userInfoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_studentBgView];
    }
    return _studentBgView;
}

@end