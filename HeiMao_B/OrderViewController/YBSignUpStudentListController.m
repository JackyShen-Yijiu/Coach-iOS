//
//  YBSignUpStudentListController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBSignUpStudentListController.h"
#import "YBSignUpStudentListCell.h"
#import "WMUITool.h"
#import "RefreshTableView.h"
#import "YBSignUpStudentListViewModel.h"
#import "BLInformationManager.h"

@interface YBSignUpStudentListController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) RefreshTableView *tableView;
@property (nonatomic, strong)  YBSignUpStudentListViewModel *signUpStudentListViewModel;
@end

@implementation YBSignUpStudentListController
- (void)viewDidLoad{
    [self initUI];
    [self initData];
}
- (void)initData{
    _signUpStudentListViewModel = [[YBSignUpStudentListViewModel alloc] init];
    WS(ws);
    _signUpStudentListViewModel.tableViewNeedReLoad = ^{
        [ws.tableView reloadData];
        [ws.tableView.refreshHeader endRefreshing];
        [ws.tableView.refreshFooter endRefreshing];
    };
    _signUpStudentListViewModel.showToast = ^{
        ToastAlertView *tav = [[ToastAlertView alloc] initWithTitle:@"网络连接失败，请检查网络连接"];
        [tav show];
    };
    [_signUpStudentListViewModel networkRequestRefresh];
    [self setRefresh];
}

- (void)setRefresh{
    WS(ws);
    self.tableView.refreshHeader.beginRefreshingBlock = ^{
        [ws.signUpStudentListViewModel networkRequestRefresh];
    };
    self.tableView.refreshFooter.beginRefreshingBlock = ^{
        [ws.signUpStudentListViewModel networkRequestLoadMore];
    };
}

- (void)initUI{
    self.title = @"预约学员列表";
    self.view.backgroundColor = RGB_Color(245, 249, 249);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _signUpStudentListViewModel.systemMessageArray.count;
//    return [_signUpStudentListViewModel informationArray].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *kListID = @"listID";
    YBSignUpStudentListCell *listCell = [tableView dequeueReusableCellWithIdentifier:kListID];
    if (!listCell) {
        listCell = [[YBSignUpStudentListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kListID];
    }
    listCell.backgroundColor = [UIColor clearColor];
//    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 电话点击回调
    listCell.callStudent = ^(UIButton *btn){
        NSLog(@"callStudent == 被回调了");
        [self callphone:indexPath];
    };
    listCell.signUpStudentModel = _signUpStudentListViewModel.systemMessageArray[indexPath.row];
    
    return listCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[BLInformationManager sharedInstance].appointmentUserData removeAllObjects];
    YBSignUpStuentListModel *model = _signUpStudentListViewModel.systemMessageArray[indexPath.row];
    [[BLInformationManager sharedInstance].appointmentUserData addObject:model];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:self];
   
    [self.navigationController popViewControllerAnimated:YES];

}

// 打电话的回调方法
- (void)callphone:(NSIndexPath *)indexPath{
    YBSignUpStuentListModel *listModel = _signUpStudentListViewModel.systemMessageArray[indexPath.row];
    if (listModel.userInfooModel.mobile) {
        NSString * telPhoto = [NSString stringWithFormat:@"telprompt://%@",listModel.userInfooModel.mobile];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telPhoto]];
    }else{
                [self showTotasViewWithMes:@"无用户手机号"];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (RefreshTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
#pragma mark - 完成
- (void)clickRight:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:self];

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
