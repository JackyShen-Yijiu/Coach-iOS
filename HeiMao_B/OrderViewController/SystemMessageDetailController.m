//
//  SystemMessageDetailController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SystemMessageDetailController.h"
#import "SystemMessageDetailCell.h"
#import "RefreshTableView.h"
#import "SystemMessageViewModel.h"

@interface SystemMessageDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  RefreshTableView *tableView;
@property (nonatomic,strong) SystemMessageViewModel *systemViewModel;
@end

@implementation SystemMessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self initData];
}

- (void)initData{
    _systemViewModel = [[SystemMessageViewModel alloc] init];
    WS(ws);
    _systemViewModel.tableViewNeedReLoad = ^{
        [ws.tableView reloadData];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
    };
    _systemViewModel.showToast = ^{
        ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"网络连接失败，请检查网络连接"];
        [tav show];
    };
    [_systemViewModel networkRequestRefresh];
    [self setRefresh];
}

- (void)setRefresh{
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^{
        [ws.systemViewModel networkRequestRefresh];
    };
    self.tableView.refreshFooter.beginRefreshingBlock = ^{
        [ws.systemViewModel networkRequestLoadMore];
    };
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _systemViewModel.systemMessageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    SystemMessageDetailCell *systemCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!systemCell) {
        systemCell = [[SystemMessageDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    systemCell.systemModel = _systemViewModel.systemMessageArray[indexPath.row];
    return systemCell;
}
#pragma mark --- Lazy加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
@end
