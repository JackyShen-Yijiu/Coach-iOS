//
//  DVVLicensingStudentListView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVLicensingStudentListView.h"
#import "DVVStudentListViewModel.h"
#import "DVVTheoreticalStudentListCell.h"
#import "MJRefresh.h"
#import "DVVToast.h"
#import "ChineseString.h"
#import "YBStudentDetailsViewController.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVLicensingStudentListView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *indexArray;

@property(nonatomic,retain)NSMutableArray *LetterResultArr;

@property(nonatomic,retain) NSMutableDictionary *dataDict;

@end

@implementation DVVLicensingStudentListView

- (NSMutableArray *)indexArray
{
    if (_indexArray==nil) {
        _indexArray = [NSMutableArray array];
    }
    return _indexArray;
}
- (NSMutableArray *)LetterResultArr
{
    if (_LetterResultArr==nil) {
        _LetterResultArr = [NSMutableArray array];
    }
    return _LetterResultArr;
}
- (NSMutableDictionary *)dataDict
{
    if (_dataDict==nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

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
}


#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DVVStudentListViewModel new];
    _viewModel.studentType = 3;
    
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
       
        if (_viewModel.dataArray.count < 10) {
            ws.footer.state = MJRefreshFooterStateNoMoreData;
        }
        
        [ws.dataDict removeAllObjects];

        NSMutableArray *nameArray = [NSMutableArray array];
        for (DVVStudentListDMData *data in _viewModel.dataArray) {
            
            [nameArray addObject:data.name];
            
            [ws.dataDict setObject:data forKey:data.name];
            
        }
        
        // 返回tableview右方 indexArray
        ws.indexArray = [ChineseString IndexArray:nameArray];
        
        // 返回联系人
        ws.LetterResultArr = [ChineseString LetterSortArray:nameArray];
        
        [ws reloadData];
    }];
    
    [_viewModel dvvSetNilResponseObjectBlock:^{
        // 服务器没有数据
        if (_viewModel.dataArray.count) {
            [DVVToast showMessage:@"已经全部加载完毕"];
            ws.footer.state = MJRefreshFooterStateNoMoreData;
        }else {
//            [DVVToast showMessage:@"暂时没有领证学员"];
        }
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        // 刷新时
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.LetterResultArr objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    DVVTheoreticalStudentListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    NSString *str = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    DVVStudentListDMData *item = [self.dataDict objectForKey:str];
    
    [cell refreshData:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YBStudentDetailsViewController * stuH = [[YBStudentDetailsViewController alloc] init];
    
    NSString *str = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    DVVStudentListDMData *item = [self.dataDict objectForKey:str];
    
    stuH.studentID = item.ID;
    
    [self.parentViewController.navigationController pushViewController:stuH animated:YES];
    
}

#pragma mark -Section的Header的值
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma mark - Section header view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 320, 20)];
    [view addSubview:lab];
    view.backgroundColor = RGB_Color(239, 239, 243);
    
    if (self.indexArray.count==section) {
        
    }
    else
    {
        lab.text = [self.indexArray objectAtIndex:section];
    }
    
    lab.textColor = [UIColor lightGrayColor];
    
    return view;
}

#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
