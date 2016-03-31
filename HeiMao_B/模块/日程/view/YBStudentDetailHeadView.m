//
//  YBStudentDetailHeadView.m
//  studentDriving
//
//  Created by 大威 on 16/2/20.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBStudentDetailHeadView.h"
#import "YBStudentDetailsRootClass.h"
#import "ChatViewController.h"

@interface YBStudentDetailHeadView ()

@property (nonatomic, strong) UIView *centerView;

@end

@implementation YBStudentDetailHeadView

// 大背景
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [[UIImage imageNamed:@"studentList"] applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];
    }
    return _bgImageView;
}
// 阴影
- (UIImageView *)alphaView {
    if (!_alphaView) {
        _alphaView = [[UIImageView alloc] initWithFrame:self.bounds];
        _alphaView.image = [UIImage imageNamed:@"YBStudentDetailstudent_shadow"];
    }
    return _alphaView;
}
// 头像
- (UIImageView *)iconImageView
{
    if (_iconImageView ==nil) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-68/2, 64+16, 68, 68)];
        _iconImageView.image = [UIImage imageNamed:@"studentList"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = _iconImageView.width/2;
        
        _iconImageView.layer.borderWidth = 1;
        _iconImageView.layer.borderColor = JZ_BlueColor.CGColor;
        
    }
    return _iconImageView;
}
// 浅色条目
- (UIView *)midView {
    if (!_midView) {
        _midView = [[UIView alloc] initWithFrame:CGRectMake(0, self.iconImageView.frame.origin.y+self.iconImageView.height/2, self.width, 48)];
        _midView.backgroundColor = RGB_Color(209, 235, 252);
    }
    return _midView;
}
// 全周班
- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width/2-20, self.midView.height)];
        _classLabel.font = [UIFont systemFontOfSize:14];
        _classLabel.textColor = JZ_BlueColor;
        _classLabel.textAlignment = NSTextAlignmentLeft;
        _classLabel.text = @"C1全周班";
    }
    return _classLabel;
}
// 打电话
- (UIButton *)callBtn
{
    if (_callBtn == nil) {
        _callBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-16-44, self.midView.height/2-44/2, 44, 44)];
        [_callBtn setImage:[UIImage imageNamed:@"JZCoursephone"] forState:UIControlStateNormal];
        [_callBtn addTarget:self action:@selector(callBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callBtn;
}
// 聊天
- (UIButton *)chatBtn
{
    if (_chatBtn == nil) {
        _chatBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-16-44-44, self.midView.height/2-44/2, 44, 44)];
        [_chatBtn setImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
        [_chatBtn addTarget:self action:@selector(chatBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatBtn;
}
// 状态
- (UIImageView *)stateImageView
{
    if (_stateImageView == nil) {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.midView.frame), self.width, 40)];
        _stateImageView.image = [UIImage imageNamed:@"progress_bar1"];
    }
    return _stateImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 大背景
        [self addSubview:self.bgImageView];
        
        // 阴影
        [self addSubview:self.alphaView];
        
        // 浅色条目
        [self addSubview:self.midView];
        
        // 头像
        [self addSubview:self.iconImageView];
        
        // 全周班
        [self.midView addSubview:self.classLabel];
        
        // 聊天
        [self.midView addSubview:self.chatBtn];
        
        // 打电话
        [self.midView addSubview:self.callBtn];
        
        // 状态
        [self addSubview:self.stateImageView];
        
    }
    return self;
}

- (void)refreshData:(YBStudentDetailsRootClass *)dmData {
   
    self.dmData = dmData;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dmData.data.studentinfo.headportrait.originalpic]] placeholderImage:[UIImage imageNamed:@"studentList"]];

    self.bgImageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",dmData.data.studentinfo.headportrait.originalpic]] applyBlurWithRadius:10 tintColor:[UIColor clearColor] saturationDeltaFactor:1 maskImage:nil];

    self.classLabel.text = dmData.data.studentinfo.applyclasstypeinfo.name;
    
    if (dmData.data.studentinfo.subject.subjectid==1) {
        _stateImageView.image = [UIImage imageNamed:@"progress_bar1"];
    }else if (dmData.data.studentinfo.subject.subjectid==2){
        _stateImageView.image = [UIImage imageNamed:@"progress_bar2"];
    }else if (dmData.data.studentinfo.subject.subjectid==3){
        _stateImageView.image = [UIImage imageNamed:@"progress_bar3"];
    }else if (dmData.data.studentinfo.subject.subjectid==4){
        _stateImageView.image = [UIImage imageNamed:@"progress_bar4"];
    }else{
        _stateImageView.image = [UIImage imageNamed:@"progress_bar0"];
    }
    
}

- (void)chatBtnDidClick

{
    NSLog(@"%s self.dmData.data.studentinfo.userid:%@",__func__,self.dmData.data.studentinfo.userid);
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:self.dmData.data.studentinfo.userid conversationType:eConversationTypeChat];
    chatController.title = self.dmData.data.studentinfo.name;
    [self.parentViewController.navigationController pushViewController:chatController animated:YES];
    
}

- (void)callBtnDidClick
{
    NSLog(@"%s self.dmData.data.studentinfo.mobile:%@",__func__,self.dmData.data.studentinfo.mobile);
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", self.dmData.data.studentinfo.mobile];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:callWebview];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
