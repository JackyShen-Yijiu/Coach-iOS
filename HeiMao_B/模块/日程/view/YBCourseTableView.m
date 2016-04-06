//
//  YBCourseTableView.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/29.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBCourseTableView.h"
#import "CourseSummaryDayCell.h"
#import "NoContentTipView.h"
#import "YBObjectTool.h"

@interface YBCourseTableView() <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) NoContentTipView * tipView2;

@end

@implementation YBCourseTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.dataTabelView];
        
        self.tipView2 = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有预约"];
        [self.tipView2 setHidden:YES];
        [self addSubview:self.tipView2];
        self.tipView2.center = CGPointMake(self.width/2.f, CGRectGetMaxY(self.frame)+self.tipView2.height);
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    _dataTabelView.frame = self.bounds;
}

- (void)reloadData
{    
    NSLog(@"reloadData dataArray:%@ reloadData dataArray.count:%lu",_dataArray,self.dataArray.count);
    
    [self.dataTabelView reloadData];
    
    // 取得当前时间之前的个数
    NSInteger index = 0;
    for (NSInteger i = 0;i < self.dataArray.count;i++) {
        
        YBCourseData *data = self.dataArray[i];
        
        // 1:大于当前日期 -1:小于当前时间 0:等于当前时间
        int compareDataNum = [YBObjectTool compareHMSDateWithBegintime:[NSString getLocalDateFormateUTCDate:data.coursebegintime] endtime:[NSString getLocalDateFormateUTCDate:data.courseendtime]];
        
        NSInteger result = [YBObjectTool compareDateWithSelectDateStr:[NSString getYearLocalDateFormateUTCDate:data.coursebegintime]];
        NSLog(@"****************result:%ld compareDataNum:%d",(long)result,compareDataNum);
        
        if (result != 1 && (compareDataNum==0 || compareDataNum==1)) {
            index++;
        }
        
    }
    
    NSLog(@"self.dataArray.count:%lu scrollToRowAtIndex:%ld",self.dataArray.count,(long)index);
    
    if (self.dataArray && self.dataArray.count > index) {
       NSInteger scrollToRowAtIndex = self.dataArray.count - index - 1;
        if (index==0) {
            scrollToRowAtIndex = 0;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:scrollToRowAtIndex inSection:0];
        [self.dataTabelView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    count =  self.dataArray.count;
    [self.tipView2 setHidden:count];
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CourseSummaryDayCell cellHeightWithModel:self.dataArray[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseSummaryDayCell * dayCell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    
    if (!dayCell) {
        dayCell = [[CourseSummaryDayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dayCell"];
    }
    dayCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row < self.dataArray.count)
        [dayCell setModel:self.dataArray[indexPath.row]];
    
    dayCell.selectData = self.selectData;
    dayCell.selectIndex = indexPath.row;
    dayCell.dataArray = self.dataArray;
    dayCell.parentViewController = self.parentViewController;
    dayCell.backgroundColor = RGB_Color(255, 255, 255);
    
    return dayCell;
    
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    
    if (_dataTabelView==nil) {
        
        _dataTabelView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.delegate = self;
        _dataTabelView.dataSource = self;
        _dataTabelView.contentInset = UIEdgeInsetsMake(0, 0, calendarH, 0);
        _dataTabelView.backgroundColor = [UIColor whiteColor];
        
    }
    return _dataTabelView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.dataTabelView) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenOpenCalendar" object:self];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenOpenCalendar" object:self];
}

@end
