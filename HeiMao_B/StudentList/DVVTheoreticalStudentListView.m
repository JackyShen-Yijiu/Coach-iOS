//
//  DVVTheoreticalStudentListView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVTheoreticalStudentListView.h"
#import "DVVStudentListViewModel.h"
#import "DVVTheoreticalStudentListCell.h"
#import "MJRefresh.h"
#import "DVVToast.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVTheoreticalStudentListView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) DVVStudentListViewModel *viewModel;

@end

@implementation DVVTheoreticalStudentListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        self.rowHeight = 100.f;
        self.tableFooterView = [UIView new];
        
        [self registerClass:[DVVTheoreticalStudentListCell class] forCellReuseIdentifier:kCellIdentifier];
        
        [self configRefresh];
        [self configViewModel];
    }
    return self;
}

- (void)beginNetworkRequest {
    [_viewModel dvvNetworkRequestRefresh];
}

#pragma mark - config refresh
- (void)configRefresh {
    
    __weak typeof(self) ws = self;
    // 刷新
    [ws addLegendHeaderWithRefreshingBlock:^{
        [ws.viewModel dvvNetworkRequestRefresh];
    }];
    
    // 加载
    [ws addLegendFooterWithRefreshingBlock:^{
        [ws.viewModel dvvNetworkRequestLoadMore];
    }];
}


#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DVVStudentListViewModel new];
    _viewModel.studentType = 1;
    
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        if (_viewModel.dataArray.count < 10) {
            ws.footer.state = MJRefreshFooterStateNoMoreData;
        }
        [ws reloadData];
    }];
    [_viewModel dvvSetLoadMoreSuccessBlock:^{
        [ws reloadData];
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        // 服务器没有数据
        if (_viewModel.dataArray.count) {
            [DVVToast showMessage:@"已经全部加载完毕"];
            ws.footer.state = MJRefreshFooterStateNoMoreData;
        }else {
            [DVVToast showMessage:@"暂时没有理论学员"];
        }
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        // 刷新时
        [DVVToast showMessage:@"加载失败"];
    }];
    [_viewModel dvvSetLoadMoreErrorBlock:^{
        // 加载更多时
        [DVVToast showMessage:@"加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        // 网络错误
        [DVVToast showMessage:@"网络错误"];
    }];
    [_viewModel dvvSetNetworkCallBackBlock:^{
        // 网络成功或失败都调用
        [ws.header endRefreshing];
        [ws.footer endRefreshing];
    }];
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_viewModel.dataArray.count) {
        self.hidden = NO;
        return _viewModel.dataArray.count;
    }else {
        self.hidden = YES;
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DVVTheoreticalStudentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell refreshData:_viewModel.dataArray[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
