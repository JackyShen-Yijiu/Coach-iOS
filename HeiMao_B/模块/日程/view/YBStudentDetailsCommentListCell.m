//
//  YBStudentDetailsCommentListCell.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentDetailsCommentListCell.h"

@interface YBStudentDetailsCommentListCell()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *studycountentLabel;
@property (nonatomic,strong) UILabel *commentCountentLabel;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) UIView *delive;

@end

@implementation YBStudentDetailsCommentListCell

- (UIImageView *)iconImageView
{
    if (_iconImageView ==nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"studentList"];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"_nameLabel";
    }
    return _nameLabel;
}
- (UILabel *)studycountentLabel {
    if (!_studycountentLabel) {
        _studycountentLabel = [[UILabel alloc] init];
        _studycountentLabel.font = [UIFont boldSystemFontOfSize:12];
        _studycountentLabel.textColor = [UIColor colorWithHexString:@"6e6e6e"];
        _studycountentLabel.textAlignment = NSTextAlignmentRight;
        _studycountentLabel.text = @"_studycountentLabel";
    }
    return _studycountentLabel;
}
- (UILabel *)commentCountentLabel {
    if (!_commentCountentLabel) {
        _commentCountentLabel = [[UILabel alloc] init];
        _commentCountentLabel.font = [UIFont systemFontOfSize:14];
        _commentCountentLabel.textColor = [UIColor grayColor];
        _commentCountentLabel.textAlignment = NSTextAlignmentLeft;
        _commentCountentLabel.text = @"_commentCountentLabel";
        _commentCountentLabel.numberOfLines = 2;
    }
    return _commentCountentLabel;
}
- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.text = @"_timeLabel";
    }
    return _timeLabel;
}

-(UIView *)delive{
    if (_delive==nil) {
        _delive = [[UIView alloc] init];
        _delive.backgroundColor = [UIColor lightGrayColor];
        _delive.alpha = 0.3;
    }
    return _delive;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.contentView addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.studycountentLabel];
        
        [self.contentView addSubview:self.commentCountentLabel];
        
        [self.contentView addSubview:self.timeLabel];
        
        [self.contentView addSubview:self.delive];
        
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(48);
            make.height.mas_equalTo(48);
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(16);
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);//
            make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
        }];
        
        [self.studycountentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_top);
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(10);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        }];
        
        [self.commentCountentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(7);//
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.commentCountentLabel.mas_bottom).offset(8);//
            make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        }];
        
        [self.delive mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        
    }
    return self;
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict=dataDict;
    
    NSLog(@"_dataDict:%@",_dataDict);
    
    NSLog(@"头像:%@",_dataDict[@"coachid"][@"headportrait"][@"originalpic"]);
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataDict[@"coachid"][@"headportrait"][@"originalpic"]]] placeholderImage:[UIImage imageNamed:@"studentList"]];
    
    self.nameLabel.text = _dataDict[@"coachid"][@"name"];
    
    if (_dataDict[@"learningcontent"]) {
        self.studycountentLabel.text = [NSString stringWithFormat:@"%@",_dataDict[@"learningcontent"]];
    }else{
        self.studycountentLabel.text = @"";
    }
    
    self.commentCountentLabel.text = _dataDict[@"coachcomment"][@"commentcontent"];
    
    self.timeLabel.text = [NSString getLocalDateFormateUTCDate:_dataDict[@"coachcomment"][@"commenttime"]];
    
}

+ (CGFloat)heightWithModel:(NSDictionary *)model
{
    
    YBStudentDetailsCommentListCell *cell = [[YBStudentDetailsCommentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YBStudentDetailsCommentListCell"];
    
    cell.dataDict = model;
    
    [cell layoutIfNeeded];
    
    return cell.nameLabel.height+cell.commentCountentLabel.height+cell.timeLabel.height+20+7+8+16;
    
}

@end
