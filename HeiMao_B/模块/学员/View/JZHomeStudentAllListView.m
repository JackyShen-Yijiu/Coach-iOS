//
//  JZHomeStudentSubjectOneView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZHomeStudentAllListView.h"
#import "JZHomeStudentListCell.h"
#import "BLPFAlertView.h"
#import "ChatViewController.h"
#import "YBStudentDetailsViewController.h"
#import <YYModel.h>
#import "HomeDataDetailViewModel.h"
#import "JZNoDataShowBGView.h"


@interface JZHomeStudentAllListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) HomeDataDetailViewModel *viewModel;

@property (nonatomic, assign) BOOL successRequest;

@property (nonatomic, strong) JZNoDataShowBGView *noDataShowBGView;


@end

@implementation JZHomeStudentAllListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.noDataShowBGView];
        self.viewModel = [HomeDataDetailViewModel new];
        [self.viewModel successRefreshBlock:^{
            [self refreshUI];
            self.successRequest = 1;
            [self.refreshHeader endRefreshing];
            return;
        }];
        [self.viewModel successLoadMoreBlock:^{
//            [self.parementVC showTotasViewWithMes:@"已经加载全部数据"];
            
        }];
    }
    
    return self;
}
#pragma mark - 刷新数据
- (void)refreshUI {
    
    [self reloadData];
}

#pragma mark - 刷新数据
- (void)networkRequest {
    self.viewModel.subjectID = self.subjectID;
    self.viewModel.studentState = self.studentState;
    [self.viewModel networkRequestRefresh];
//    if (self.successRequest) {
//        [self refreshUI];
//        [self.refreshHeader endRefreshing];
//        return;
//    }
       }

#pragma mark --- 加载更多
- (void)moreData{
    self.viewModel.subjectID = self.subjectID;
    self.viewModel.studentState = self.studentState;
    [self.viewModel networkRequestLoadMore];
    if (self.successRequest) {
        [self refreshUI];
        [self.refreshFooter endRefreshing];
        return;
    }
    
}

- (void)setSearchType:(kDateSearchType)searchType {
    _searchType = searchType;
    self.viewModel.searchType = searchType;
}

#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     _noDataShowBGView.hidden = YES;
    if (_searchType == kDateSearchTypeToday) {
        if (self.viewModel.allListArray.count == 0) {
            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
                [self.showNodataDelegate initWithDataSearchType:kDateSearchTypeToday];
            }
        }

        return self.viewModel.allListArray.count;
    }
    if (_searchType == kDateSearchTypeYesterday) {
        if (self.viewModel.noexamListArray.count == 0) {
            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
                [self.showNodataDelegate initWithDataSearchType:kDateSearchTypeYesterday];
            }
        }

        
        return self.viewModel.noexamListArray.count;
    }
    if (_searchType == kDateSearchTypeWeek) {
        if (self.viewModel.appiontListArray.count == 0) {
        if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
                [self.showNodataDelegate initWithDataSearchType:kDateSearchTypeWeek];
            }
        }
        return self.viewModel.appiontListArray.count;
    }
    if (_searchType == kDateSearchTypeMonth) {
        if (self.viewModel.retestListArray.count == 0) {
                
                if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
                    [self.showNodataDelegate initWithDataSearchType:kDateSearchTypeMonth];
                }

        }

        
        return self.viewModel.retestListArray.count;
    }
    if (_searchType == kDateSearchTypeYear) {
        if (self.viewModel.passListArray.count == 0) {
            if ([self.showNodataDelegate respondsToSelector:@selector(initWithDataSearchType:)]) {
                [self.showNodataDelegate initWithDataSearchType:kDateSearchTypeYear];
            }
        }

                return self.viewModel.passListArray.count;
    }
    return 0;
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
    JZResultModel *model = [[JZResultModel alloc] init];
    if (_searchType == kDateSearchTypeToday) {
        model = self.viewModel.allListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeYesterday) {
        model = self.viewModel.noexamListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeWeek) {
        model = self.viewModel.appiontListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeMonth) {
        model = self.viewModel.retestListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeYear) {
        model = self.viewModel.passListArray[indexPath.row];
    }

    listCell.listModel = model;
    
    
    
    
    listCell.studentListMessageAndCall = ^(NSInteger tag){
        if (500 == tag) {
            // 信息
            [self messageWithModel:model];
        }
        if (501 == tag) {
            // 电话
            [self callPhonewithModel:model];
        }
    };

    return listCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // 跳转学员详情页
    JZResultModel *model = [[JZResultModel alloc] init];
    if (_searchType == kDateSearchTypeToday) {
        model = self.viewModel.allListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeYesterday) {
        model = self.viewModel.noexamListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeWeek) {
        model = self.viewModel.appiontListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeMonth) {
        model = self.viewModel.retestListArray[indexPath.row];
    }
    if (_searchType == kDateSearchTypeYear) {
        model = self.viewModel.passListArray[indexPath.row];
    }

    
    YBStudentDetailsViewController *studentDetailVC = [[YBStudentDetailsViewController alloc] init];
    studentDetailVC.studentID = model.userid;
    [self.parementVC.navigationController pushViewController:studentDetailVC animated:YES];
}

#pragma mark ---- 电话
- (void)callPhonewithModel:(JZResultModel *)model{
    
    if (model.mobile == nil ||[model.mobile isEqualToString:@""]) {
        [self.parementVC showTotasViewWithMes:@"该学员未录入电话!"];
        return;
    }
    
    [BLPFAlertView showAlertWithTitle:@"电话号码" message:model.mobile cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] completion:^(NSUInteger selectedOtherButtonIndex) {
        
        NSUInteger indexAlert = selectedOtherButtonIndex + 1;
        if (indexAlert == 1) {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",model.mobile];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.parementVC.view addSubview:callWebview];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else {
            return ;
        }
        
    }];
}

#pragma mark ---- 信息
- (void)messageWithModel:(JZResultModel *)model{
    NSLog(@"%s self.dmData.data.studentinfo.userid:%@",__func__,model.userid);
    
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.userid conversationType:eConversationTypeChat];
    chatController.title = model.name;
    [self.parementVC.navigationController pushViewController:chatController animated:YES];
    
    
}
- (JZNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 0,self.frame.size.width,self.frame.size.height)];
        _noDataShowBGView.imgStr = @"people_null";
        _noDataShowBGView.titleStr = @"暂无数据";
        _noDataShowBGView.titleColor  = JZ_FONTCOLOR_DRAK;
        _noDataShowBGView.fontSize = 14.f;
        _noDataShowBGView.hidden = NO;
    }
    return _noDataShowBGView;
}

@end
