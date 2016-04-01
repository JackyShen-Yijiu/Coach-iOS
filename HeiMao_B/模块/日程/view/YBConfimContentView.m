//
//  YBConfimContentView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBConfimContentView.h"
#import "RatingBar.h"

@interface YBConfimContentView()<UITextViewDelegate,RatingBarDelegate>

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgContentView; // 背景
@property (nonatomic, strong) UILabel *tittleContentLabel;

@property (nonatomic, strong) UIView *bgRateView; // 背景
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) RatingBar *ratingBar;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *commitButton;

@property (nonatomic, strong) UILabel *placeTextLabel;

@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) CGFloat lastY;

@property (nonatomic , strong) NSArray *subjectArray;

@property (nonatomic, strong) NSString *textViewStr;

@property (nonatomic, assign) NSInteger stareLever;

@property (nonatomic, strong) JZData *dataModel;

@end

@implementation YBConfimContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentTextView.delegate = self;
        self.btnArray = [NSMutableArray array];
        
        //    教学内容视图
        [self.bgContentView addSubview:self.tittleContentLabel];
        [self addSubview:self.bgContentView];
        [self addSubview:self.lineView];
        
        
        // 评分视图
        [self addSubview:self.bgRateView];
        [self.bgRateView addSubview:self.rateLabel];
        [self.bgRateView addSubview:self.ratingBar];
        [self.bgRateView addSubview:self.contentTextView];
        [self.contentTextView addSubview:self.placeTextLabel];
        [self.bgRateView addSubview:self.commitButton];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(0.5);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(@0.5);
        }];
        
        // 教学内容视图
        [self.bgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(0);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
            make.height.mas_equalTo(@110); //110
        }];
        [self.tittleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgContentView.mas_top).offset(16);
            make.left.mas_equalTo(self.bgContentView.mas_left).offset(16);
            make.width.mas_equalTo(@100);
            make.height.mas_equalTo(@16);
        }];

        // 评分视图
        [self.bgRateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bgContentView.mas_bottom).offset(0);
            make.left.mas_equalTo(self.mas_left).offset(0);
            make.right.mas_equalTo(self.mas_right).offset(0);
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
        [self.placeTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentTextView.mas_top).offset(10);
            make.left.mas_equalTo(self.contentTextView.mas_left).offset(12);
            make.height.mas_equalTo(@14);
        
        }];
        [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentTextView.mas_bottom).offset(16);
            make.right.mas_equalTo(self.bgRateView.mas_right).offset(-16);
            make.left.mas_equalTo(self.bgRateView.mas_left).offset(16);
            make.height.mas_equalTo(@32);
        }];
        
    }
    return self;
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
        _bgContentView.backgroundColor = [UIColor whiteColor];
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
        _bgRateView.userInteractionEnabled = YES;
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
        [_ratingBar setImageDeselected:@"YBAppointMentDetailsstar.png" halfSelected:nil fullSelected:@"YBAppointMentDetailsstar_fill.png" andDelegate:self];
        _ratingBar.isIndicator = NO;
        [_ratingBar displayRating:3];
        
    }
    return _ratingBar;
}
- (UITextView *)contentTextView{
    if (_contentTextView == nil) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    }
    return _contentTextView;
}
- (UIButton *)commitButton{
    if (_commitButton == nil) {
        _commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commitButton.backgroundColor = JZ_BlueColor;
        [_commitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitContent:) forControlEvents:UIControlEventTouchUpInside];
        _commitButton.layer.masksToBounds = YES;
        _commitButton.layer.cornerRadius = 5;
    }
    return _commitButton;
}
- (UILabel *)placeTextLabel{
    if (_placeTextLabel == nil) {
        _placeTextLabel = [[UILabel alloc] init];
        _placeTextLabel.text = @"写点儿点评(选填)";
        _placeTextLabel.font = [UIFont systemFontOfSize:14];
        _placeTextLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _placeTextLabel;
}

#pragma mark - getSize

- (CGSize)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    return bounds.size;
}

- (CGFloat)confimContentView:(NSArray *)dataArray model:(JZData *)model{
    
    _subjectArray = dataArray;
    _dataModel = model;
  
    for (UIButton *btn in self.bgContentView.subviews) {
        [btn removeFromSuperview];
    }
    
    CGFloat width = CGRectGetMinX(self.tittleContentLabel.frame);
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    
    NSLog(@"_subjectArray:%lu",(unsigned long)_subjectArray.count);
    
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
            btn.frame = CGRectMake(width,20,size.width + 20 , size.height + 20);
        }else {
            btn.frame = CGRectMake(width,(lineNum - 1)*30 +14*(lineNum -1) + 20,size.width + 20 , size.height + 20);
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 15;
        btn.layer.borderColor = JZ_BlueColor.CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 500 + i;
        [_btnArray addObject:btn];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgContentView addSubview:btn];
        // 存储最后一个button的Y
        if (i == _subjectArray.count - 1) {
            _lastY = btn.frame.origin.y;
        }
        
        
    }
    CGFloat bgcontentViewH = _lastY + 50;
    NSLog(@"bgcontentViewH:%f",bgcontentViewH);
    
    // 动态改变
    [self.bgContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(bgcontentViewH);
    }];
    
    return bgcontentViewH + 200;
}

#pragma mark -- Action
  // 学习内容点击事件
- (void)didClickBtn:(UIButton *)btn{
    if (btn.selected) {
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
        btn.selected = NO;
    }else if (!btn.selected) {
        btn.backgroundColor = JZ_BlueColor;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.selected = YES;
    }
   
}
// 提交评价内容
- (void)commitContent:(UIButton *)btn{
    
    // 学习内容
    NSString *resultStudyContent = @"";
    for (UIButton *btn in _btnArray) {
        if (btn.selected) {
            resultStudyContent = [resultStudyContent stringByAppendingString:_subjectArray[btn.tag - 500]];
            NSLog(@"resultStudyContent = %@",resultStudyContent);
        }
    }
    if (resultStudyContent == nil || [resultStudyContent isEqualToString:@""]) {
        [self.parentViewController showTotasViewWithMes:@"请选择学习内容"];
        return;
    }
    
    [NetWorkEntiry postToEnstureDoneofCourseWithCoachid:[UserInfoModel defaultUserInfo].userID coureseID:_dataModel.idField learningcontent:resultStudyContent contentremarks:_textViewStr startLevel:_stareLever success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            [self.parentViewController showTotasViewWithMes:@"评论成功"];
            
        }else{
            [self.parentViewController showTotasViewWithMes:@"网络错误"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.parentViewController showTotasViewWithMes:@"网络错误"];
    }];
}
#pragma mark ---- UItextView的代理方法
- (void)textViewDidChange:(UITextView *)textView{
    if (_contentTextView.text.length == 0) {
        _placeTextLabel.hidden = NO;
    }else{
        _placeTextLabel.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    _textViewStr = textView.text;
}
#pragma mark ------ Ratingbar 代理方法
- (void)ratingChanged:(CGFloat)newRating{
    _stareLever = (NSInteger)newRating;
}
@end
