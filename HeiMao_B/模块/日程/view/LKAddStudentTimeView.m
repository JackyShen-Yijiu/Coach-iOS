//
//  LKAddStudentTimeView.m
//  添加学员
//
//  Created by 雷凯 on 16/3/29.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "LKAddStudentTimeView.h"
#import "Masonry.h"


@implementation LKAddStudentTimeView


-(void)layoutSubviews {
//    
//    [self.starTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.mas_top).offset(16);
//        make.width.mas_equalTo(50);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        
//    }];
//    
//    [self.finishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.mas_equalTo(self.mas_top).offset(8);
//        make.width.mas_equalTo(50);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        
//    }];
//    
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//       
//        make.top.mas_equalTo(self.mas_top).offset(6);
//        make.width.mas_equalTo(50);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        
//        
//    }];
//    
    
}

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

        self.backgroundColor = [UIColor redColor];
        
        UILabel *starTimeLabel = [[UILabel alloc]init];
        UILabel *finishTimeLabel = [[UILabel alloc]init];
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.starTimeLabel = starTimeLabel;
        self.finishTimeLabel = finishTimeLabel;
        self.selectButton = selectButton;
        
        [self addSubview:starTimeLabel];
        [self addSubview:finishTimeLabel];
        [self addSubview:selectButton];
        
            [self.starTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.mas_equalTo(self.mas_top).offset(16);
                make.width.mas_equalTo(80);
                make.centerX.mas_equalTo(self.mas_centerX);
        
            }];

        
            [self.finishTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.mas_equalTo(self.starTimeLabel.mas_bottom).offset(8);
                make.width.mas_equalTo(80);
                make.centerX.mas_equalTo(self.mas_centerX);
        
            }];

            [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
                make.top.mas_equalTo(self.finishTimeLabel.mas_bottom).offset(6);
                make.width.mas_equalTo(80);
                make.centerX.mas_equalTo(self.mas_centerX);
                
                make.height.mas_equalTo(20);
                make.bottom.mas_equalTo(self.mas_bottomMargin).offset(-6);

            }];
        
        
        
        self.starTimeLabel.text = @"11:00";
        self.starTimeLabel.textAlignment = UITextAlignmentCenter;
        [self.starTimeLabel setFont:[UIFont systemFontOfSize:15]];
        self.finishTimeLabel.text = @"12:00";
        self.finishTimeLabel.textAlignment = UITextAlignmentCenter;
        [self.finishTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [self.finishTimeLabel setTextColor:[UIColor lightGrayColor]];
      
        
//        self.selectButton.backgroundColor = [UIColor orangeColor];
        
        [self.selectButton setTitle:@"休息" forState:UIControlStateNormal];
        [self.selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        
        [selectButton sizeToFit];
        selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        
//        NSLog(@"%@",NSStringFromCGRect(frame));
        
        
        
    }
    return self;
 
}












//
//+(instancetype)addStudentTimeView {
//    
//    LKAddStudentTimeView *view = [[LKAddStudentTimeView alloc]init];
//    
////    view.backgroundColor = [UIColor greenColor];
//    
//    CGFloat y = 0;
//    CGFloat w = [UIScreen mainScreen].bounds.size.width *0.25;
////  x
//    CGFloat h = 184;
//    
//    
//    
//    for (NSInteger i=0; i<4; i++) {
//        
//        UIView *timeView = [[UIButton alloc]initWithFrame:CGRectMake(i*w, y, w, h)];
//
//        
//        timeView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0)green:((float)arc4random_uniform(256) / 255.0)blue:((float)arc4random_uniform(256) / 255.0)alpha:1.0];
//     
//        
//        UILabel *starTimeLabel= [[UILabel alloc]init];
//        
//        starTimeLabel.frame = CGRectMake(0, 8, timeView.bounds.size.width, 16);
//        starTimeLabel.text = @"10:10";
//    
//        
//        starTimeLabel.textAlignment = UITextAlignmentCenter;
//        
//        UILabel *finishTimeLabel= [[UILabel alloc]init];
//        
//        finishTimeLabel.frame = CGRectMake(0, 30, timeView.bounds.size.width, 16);
//        finishTimeLabel.text = @"11:11";
//  
//        finishTimeLabel.textAlignment = UITextAlignmentCenter;
//        
//        UIButton *selectBtn = [[UIButton alloc]init];
//        
//        selectBtn.frame = CGRectMake(20, 40, 8, 8);
//        [selectBtn setImage:[UIImage imageNamed:@"JZCoursechoose"] forState:UIControlStateNormal];
//        [selectBtn setImage:[UIImage imageNamed:@"JZCoursesure"] forState:UIControlStateHighlighted];
//        
//        
//
//        
//        [selectBtn sizeToFit];
//        
//        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//        
//        [timeView addSubview:selectBtn];
//        
//        
//        
//        
//        
//        [timeView addSubview:starTimeLabel];
//        [timeView addSubview:finishTimeLabel];
//        
//        
//        [view addSubview:timeView];
//    }
//    
//    
//    
//    return view;

//}







@end
