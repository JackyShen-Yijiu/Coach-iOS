//
//  LKAddStudentNoDataView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/5.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "LKAddStudentNoDataView.h"

@implementation LKAddStudentNoDataView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIImageView *noDataImageView = [[UIImageView alloc]init];
        UILabel *noDataLabel = [[UILabel alloc]init];
        
        [self addSubview:noDataImageView];
        [self addSubview:noDataLabel];
        
        self.noDataLabel = noDataLabel;
        self.noDataImageView = noDataImageView;
        
        [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).offset(140);
            make.centerX.equalTo(self.mas_centerX);

        }];
        
        [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.noDataImageView.mas_bottom).offset(32);
            make.centerX.equalTo(self.mas_centerX);
            make.width.equalTo(@200);
            make.height.equalTo(@14);
            
        }];
        
        self.noDataLabel.textAlignment = NSTextAlignmentCenter;
        self.noDataLabel.font = [UIFont systemFontOfSize:14];
        self.noDataLabel.textColor = RGB_Color(110, 110, 110);
        self.noDataLabel.text = @"您暂时还没有学员的考试信息呢";
        self.noDataImageView.image = [UIImage imageNamed:@"text_null"];
        
        
    }
    
    return self;
    
}

@end
