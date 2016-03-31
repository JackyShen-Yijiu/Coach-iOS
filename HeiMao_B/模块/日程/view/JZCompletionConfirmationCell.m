//
//  JZCompletionConfirmationCell.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCompletionConfirmationCell.h"

#import "RatingBar.h"

@interface JZCompletionConfirmationCell ()
@property (nonatomic ,strong) UIView *bgTopView; // 背景
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *bgBottomView; // 背景

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgContentView; // 背景
@property (nonatomic, strong) UILabel *tittleContentLabel;

@property (nonatomic, strong) UIView *bgRateView; // 背景
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) RatingBar *ratingBar;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) CGFloat lastY;


@end

@implementation JZCompletionConfirmationCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        self.btnArray = [NSMutableArray array];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self initButton];
    }
    return self;
}
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    // 顶部视图
    [self.contentView addSubview:self.bgTopView];
    [self.bgTopView addSubview:self.iconImageView];
    [self.bgTopView addSubview:self.nameLabel];
    [self.bgTopView addSubview:self.timeLabel];
    [self.bgTopView addSubview:self.arrowImageView];
    
    
    // 底部视图
    [self.contentView addSubview:self.bgBottomView];
    [self.bgBottomView addSubview:self.bgContentView];
    [self.bgBottomView addSubview:self.lineView];
    
    // 教学内容视图
    [self.bgContentView addSubview:self.tittleContentLabel];
       
    // 评分视图
    [self.bgContentView addSubview:self.bgRateView];
    [self.bgRateView addSubview:self.rateLabel];
    [self.bgRateView addSubview:self.ratingBar];
    [self.bgRateView addSubview:self.contentTextView];
    [self.bgRateView addSubview:self.commitButton];
}
- (void)initButton{
   
    CGFloat width = CGRectGetMinX(self.tittleContentLabel.frame);
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    for (int i = 0;i < _subjectArray.count;i++) {
        NSString *str = self.subjectArray[i];
        CGSize size = [self getLabelWidthWithString:str];
        CGFloat widthSum = 0;
        for (NSNumber *contentWidth in widthArray) {
            widthSum += contentWidth.floatValue;
        }
        if (lineNum == 1) {
            
            //            CGFloat right = [UIScreen mainScreen].bounds.size.width;
            //            CGFloat left = widthSum + labelSize.width + (widthArray.count)*24.f + 100.f;
            
            if (widthSum + size.width + (widthArray.count)*24 + 100 > [UIScreen mainScreen].bounds.size.width) {
                lineNum += 1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(size.width)];
            }else {
                width = widthArray.count*24 +widthSum +16; // 首行 第一个buttond X 的位置
                [widthArray addObject:@(size.width)];
            }
        }else {
            if (widthSum + size.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
                lineNum +=1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(size.width)];
            }else {
                width = 15+widthArray.count*24 +widthSum ;
                [widthArray addObject:@(size.width)];
            }
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (lineNum == 1) {
            // 开始是btnY值
            btn.frame = CGRectMake(width,46,size.width , size.height);
        }else {
            btn.frame = CGRectMake(width,(lineNum - 1)*15 +14*(lineNum -1) + 46,size.width , size.height);
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        btn.tag = 500 + i;
        [_btnArray addObject:btn];
        [self.bgContentView addSubview:btn];
        // 存储最后一个button的Y
        if (i == _subjectArray.count - 1) {
            _lastY = btn.frame.origin.y;
        }

    }
    
    // 动态改变
    [self.bgContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        CGFloat bgcontentViewH = _lastY + 24;
        make.top.mas_equalTo(self.bgBottomView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(bgcontentViewH);
    }];
    
    [self.bgBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        CGFloat bgBotomH = CGRectGetHeight(self.bgContentView.frame) + 200;
        make.top.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(bgBotomH); // 330

    }];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 顶部视图
    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@80); // 80
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgTopView.mas_left).offset(16);
        make.width.mas_equalTo(@48);
        make.height.mas_equalTo(@48);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_top).offset(21);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(16);
        make.width.mas_equalTo(@150);
        make.height.mas_equalTo(@14);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(12);
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@12);
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgTopView.mas_centerY);
        make.right.mas_equalTo(self.bgTopView.mas_right).offset(-16);
        make.width.mas_equalTo(@8);
        make.height.mas_equalTo(@14);
    }];
    // 底部视图
    
    [self.bgBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgTopView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@330); // 330
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgBottomView.mas_top).offset(0.5);
        make.left.mas_equalTo(self.bgBottomView.mas_left).offset(0);
        make.right.mas_equalTo(self.bgBottomView.mas_right).offset(0);
        make.height.mas_equalTo(@0.5);
    }];

    
     // 教学内容视图
    [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgBottomView.mas_top).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@110); //110
    }];
    [self.tittleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgContentView.mas_top).offset(16);
        make.left.mas_equalTo(self.bgContentView.mas_left).offset(16);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@32);
    }];
    
    // 评分视图
    [self.bgRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgContentView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.contentView.mas_left).offset(0);
        make.right.mas_equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(@200); // 200
    }];
    
    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgRateView.mas_top).offset(0);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@16);
    }];
    [self.ratingBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgRateView.mas_top).offset(0);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.width.mas_equalTo(@92);
        make.height.mas_equalTo(@16);
    }];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.ratingBar.mas_bottom).offset(16);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.height.mas_equalTo(@100);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentTextView.mas_bottom).offset(16);
        make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
        make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
        make.height.mas_equalTo(@32);
    }];


 [self initButton];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}
// 顶部视图
- (UIView *)bgTopView{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        _bgTopView.backgroundColor = [UIColor whiteColor];
    }
    return _bgTopView;
}
- (UIImageView *)iconImageView{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = 24;
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}
- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"周家";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"08:00-09:00";
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _timeLabel;
}
- (UIImageView *)arrowImageView{
    if (_arrowImageView == nil) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"more_right"];
        
    }
    return _arrowImageView;
}

// 底部视图
- (UIView *)bgBottomView{
    if (_bgBottomView == nil) {
        _bgBottomView = [[UIView alloc] init];
        _bgBottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bgBottomView;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
}
- (UIView *)bgContentView{
    if (_bgContentView == nil) {
        _bgContentView = [[UIView alloc] init];
        _bgContentView.backgroundColor = [UIColor grayColor];
    }
    return _bgContentView;
}

- (UILabel *)tittleContentLabel{
    if (_tittleContentLabel == nil) {
        _tittleContentLabel = [[UILabel alloc] init];
        _tittleContentLabel.text = @"教学内容(必选)";
        _tittleContentLabel.font = [UIFont systemFontOfSize:12];
        _tittleContentLabel.textColor = RGB_Color(230, 46, 72);
    }
    return _tittleContentLabel;
}

- (UIView *)bgRateView{
    if (_bgRateView == nil) {
        _bgRateView = [[UIView alloc] init];
        _bgRateView.backgroundColor = [UIColor whiteColor];
    }
    return _bgRateView;
}

- (UILabel *)rateLabel{
    if (_rateLabel == nil) {
        _rateLabel = [[UILabel alloc] init];
        _rateLabel.text = @"评分";
        _rateLabel.font = [UIFont systemFontOfSize:16];
        _rateLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _rateLabel;
}

- (RatingBar *)ratingBar{
    if (_ratingBar == nil) {
        _ratingBar = [[RatingBar alloc] init];
        [_ratingBar setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:nil];
        _ratingBar.isIndicator = YES;

    }
    return _ratingBar;
}
- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = [UIColor cyanColor];
    }
    return _contentTextView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = JZ_BlueColor;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        _commitButton.layer.masksToBounds = YES;
        _commitButton.layer.cornerRadius = 5;
    }
    return _commitButton;
}
- (CGFloat)cellHeihtWith:(NSArray *)dataArray{
    _subjectArray = dataArray;
    NSLog(@"_suc  ======= %@",_subjectArray);
    
    JZCompletionConfirmationCell *JZCompletonCell = [[JZCompletionConfirmationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    [self initButton];
    [JZCompletonCell layoutIfNeeded];
   
//    //设置按钮背景的宽度
//    CGFloat margin = 16;
//    CGFloat width = self.frame.size.height - margin * 2;
//     CGFloat lineNum = 1;
//     NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
//    for (int i = 0;i < dataArray.count;i++) {
//        NSString *str = dataArray[i];
//        CGSize labelSize = [self  getLabelWidthWithString:str];
//        CGFloat widthSum = 0;
//        for (NSNumber *contentWidth in widthArray) {
//            widthSum += contentWidth.floatValue;
//        }
//        if (widthSum + labelSize.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
//            lineNum +=1;
//            width = 15;
//            [widthArray removeAllObjects];
//            [widthArray addObject:@(labelSize.width)];
//        }else {
//            width = 15+widthArray.count*24 +widthSum ;
//            [widthArray addObject:@(labelSize.width)];
//        }
//    }
////    if (isExist) {
////        return 45 + 30 +15*(lineNum-1) +lineNum*14;
////    }
//    
    CGFloat bgBotomH = CGRectGetHeight(self.bgContentView.frame) + 200 + 80;
    
    
    return bgBotomH;
}
#pragma mark - getSize

- (CGSize)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    return bounds.size;
}

@end
