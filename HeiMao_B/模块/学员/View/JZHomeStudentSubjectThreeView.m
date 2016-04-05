//
//  JZHomeStudentSubjectThreeView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZHomeStudentSubjectThreeView.h"

#import "JZHomeStudentListCell.h"

@interface JZHomeStudentSubjectThreeView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation JZHomeStudentSubjectThreeView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    [self addSubview:self.tableView];
}
#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *IDCell = @"cellID";
    JZHomeStudentListCell *listCell = [tableView dequeueReusableCellWithIdentifier:IDCell];
    if (!listCell) {
        listCell = [[JZHomeStudentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCell];
    }
    return listCell;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        CGRect rect = self.bounds;
        _tableView = [[UITableView alloc] initWithFrame:rect];
        _tableView.backgroundColor = [UIColor clearColor];
         _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
@end
