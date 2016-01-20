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
#import "InformationMessageDetailController.h"

@interface InformationMessageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RefreshTableView  *tableView;
@property (nonatomic, strong) InformationMessageViewModel *informationMessageViewModel;

@end

@implementation InformationMessageController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(InformationMessageControllerGetMessageLastnews:)]) {
        
        if (_informationMessageViewModel.informationArray&&_informationMessageViewModel.informationArray.count>0) {
          
            NSLog(@"((InformationMessageModel *)[_informationMessageViewModel.informationArray lastObject]).seqindex:%@",((InformationMessageModel *)_informationMessageViewModel.informationArray[0]).seqindex);
            
            [self.delegate InformationMessageControllerGetMessageLastnews:((InformationMessageModel *)_informationMessageViewModel.informationArray[0]).seqindex];
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"行业资讯";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.view.backgroundColor = RGB_Color(247,249,251);
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
        informationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    informationCell.informationMessageModel = _informationMessageViewModel.informationArray[indexPath.row];
    return informationCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationMessageModel *model = _informationMessageViewModel.informationArray[indexPath.row];
    InformationMessageCell *cell = (InformationMessageCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return [cell heightWithcell:model];

}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
#pragma mark --- Lazy加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationMessageDetailController *informationMessageDetailVC = [[InformationMessageDetailController alloc] init];
    InformationMessageModel *resultModel =_informationMessageViewModel.informationArray[indexPath.row];
    informationMessageDetailVC.urlStr = resultModel.contenturl;
    [self.navigationController pushViewController:informationMessageDetailVC animated:YES];
}
@end