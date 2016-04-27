//
//  JZBulletinCell.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZBulletinCell.h"
#import "JZBulletinData.h"

@interface JZBulletinCell ()
///  标题
@property (nonatomic, strong) UILabel *mainTitleLabel;
///  时间
@property (nonatomic, strong) UILabel *timeLabel;
///  发布者
@property (nonatomic, strong) UILabel *postNameLabel;
///  内容
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *lineView;

@end
@implementation JZBulletinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
    }
    return self;
}

-(void)initUI {
    
    self.mainTitleLabel = [[UILabel alloc]init];
    self.mainTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.mainTitleLabel.textColor = JZ_FONTCOLOR_DRAK;
    
    if (YBIphone6Plus) {
        
        [self.mainTitleLabel setFont:[UIFont systemFontOfSize:14 * JZRatio_1_1_5]];
 
    }else {
        [self.mainTitleLabel setFont:[UIFont systemFontOfSize:14]];

    }
    
    
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.textColor = JZ_FONTCOLOR_LIGHT;

    if (YBIphone6Plus) {
        
        [self.timeLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];

    }else {
        [self.timeLabel setFont:[UIFont systemFontOfSize:12]];

    }
    
    self.postNameLabel = [[UILabel alloc]init];
    self.postNameLabel.textAlignment = NSTextAlignmentRight;
    self.postNameLabel.textColor = JZ_FONTCOLOR_LIGHT;

    if (YBIphone6Plus) {
        
        [self.postNameLabel setFont:[UIFont systemFontOfSize:12 * JZRatio_1_1_5]];

    }else {
        [self.postNameLabel setFont:[UIFont systemFontOfSize:12]];

    }
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = JZ_FONTCOLOR_DRAK;
    self.contentLabel.numberOfLines = 0;
    
    if (YBIphone6Plus) {
        [self.contentLabel setFont:[UIFont systemFontOfSize:14*JZRatio_1_1_5]];

        
    }else {
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];

    }
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    
    [self.contentView addSubview:self.mainTitleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.postNameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];

}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).offset(14);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mainTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        
    }];
    
    
    [self.postNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
       
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
    
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);//
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(14);
        make.height.equalTo(@0.5);
        
    }];
    
    
    
}


+ (CGFloat)cellHeightDmData:(JZBulletinData *)dmData
{
    
    JZBulletinCell *cell = [[JZBulletinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JZBulletinCellID"];
    
    cell.data = dmData;
    
    [cell layoutIfNeeded];
    
//    if (YBIphone6Plus) {
//     return (cell.timeLabel.height + cell.mainTitleLabel.height + cell.contentLabel.height + 50.5) *JZRatio_1_1_5;
//        
//    }else {
    
        return cell.timeLabel.height + cell.mainTitleLabel.height + cell.contentLabel.height + 50.5;
//    }
//    
//    return 0;
//    
    
    
}

-(void)setData:(JZBulletinData *)data {
    
    _data = data;
    
    if ([_data.title isEqualToString:@""]) {
        
        self.mainTitleLabel.text = @"无标题";
    }else {
        self.mainTitleLabel.text = _data.title;
    }
    
    
    self.contentLabel.text = _data.content;
    self.timeLabel.text = [self getYearLocalDateFormateUTCDate:_data.createtime];
    
    self.postNameLabel.text = [NSString stringWithFormat:@"发布者：%@",_data.name];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.timeLabel.mas_bottom).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        
    }];

    
    
    
}



- (NSString *)getYearLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}




@end
