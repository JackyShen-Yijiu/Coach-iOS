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
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {

//        self.backgroundColor = [UIColor redColor];
        
        UILabel *starTimeLabel = [[UILabel alloc]init];
        UILabel *finishTimeLabel = [[UILabel alloc]init];
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView *lineView = [[UIView alloc]init];
        
        self.starTimeLabel = starTimeLabel;
        self.finishTimeLabel = finishTimeLabel;
        self.selectButton = selectButton;
        self.lineView = lineView;
        
        [self addSubview:lineView];
        [self addSubview:starTimeLabel];
        [self addSubview:finishTimeLabel];
        [self addSubview:selectButton];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(self.mas_top).offset(-0.5);
            make.right.mas_equalTo(self.mas_right).offset(-0.5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.width.mas_equalTo(0.5);
            
            
        }];
        
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
        
        lineView.backgroundColor = RGB_Color(232, 232, 237);
        self.starTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self.starTimeLabel setFont:[UIFont systemFontOfSize:15]];
        self.finishTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self.finishTimeLabel setFont:[UIFont systemFontOfSize:13]];
        [self.finishTimeLabel setTextColor:[UIColor lightGrayColor]];

        [selectButton sizeToFit];
        selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    }
    return self;
 
}

@end
