//
//  InformationMessageController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "InformationMessageController.h"
#import "InformationMessageCell.h"
#import "InformationMessageViewModel.h"
#import "RefreshTableView.h"

@interface InformationMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RefreshTableView  *tableView;
@property (nonatomic, strong) InformationMessageViewModel *informationMessageViewModel;

@end

@implementation InformationMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"行业资讯";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self initData];
    

    }
- (void)initData{
    _informationMessageViewModel = [[InformationMessageViewModel alloc] init];
    WS(ws);
    _informationMessageViewModel.tableViewNeedReLoad = ^{
        [ws.tableView reloadData];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
    };
    _informationMessageViewModel.showToast = ^{
        ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"网络连接失败，请检查网络连接"];
        [tav show];
    };
    [_informationMessageViewModel networkRequestRefresh];
    [self setRefresh];
}

- (void)setRefresh{
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^{
        [ws.informationMessageViewModel networkRequestRefresh];
    };
    self.tableView.refreshFooter.beginRefreshingBlock = ^{
        [ws.informationMessageViewModel networkRequestLoadMore];
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _informationMessageViewModel.informationArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    InformationMessageCell *informationCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!informationCell) {
        informationCell = [[InformationMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    informationCell.informationMessageModel = _informationMessageViewModel.informationArray[indexPath.row];
    return informationCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
#pragma mark --- Lazy加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end