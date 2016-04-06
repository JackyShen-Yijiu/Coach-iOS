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

//        self.backgroundColor = [UIColor redColor];
        
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
        
        
        
//        self.starTimeLabel.text = @"11:00";
        self.starTimeLabel.textAlignment = UITextAlignmentCenter;
        [self.starTimeLabel setFont:[UIFont systemFontOfSize:15]];
//        self.finishTimeLabel.text = @"12:00";
        self.finishTimeLabel.textAlignment = UITextAlignmentCenter;
        [self.finishTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [self.finishTimeLabel setTextColor:[UIColor lightGrayColor]];
      
        
//        self.selectButton.backgroundColor = [UIColor orangeColor];
        
                
        [selectButton sizeToFit];
        selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        
//        NSLog(@"%@",NSStringFromCGRect(frame));
        
        
        
    }
    return self;
 
}




@end
