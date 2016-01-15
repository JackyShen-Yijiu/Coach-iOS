//
//  SearchCourseViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SearchCourseViewController.h"
#import "NoContentTipView.h"
#import "CourseSummaryListCell.h"
#import "CourseDetailViewController.h"

#import "PermissiveObject.h"
#import "PermissiveResearchDatabase.h"
#import "PermissiveOperations.h"
#import "PermissiveAlignementMethods.h"
#import "HMCourseModel.h"

@interface SearchCourseViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,PermissiveResearchDatasource>

@property(nonatomic,strong) UITableView * courseSummaryTableView;
@property(nonatomic,strong) NoContentTipView * tipView1;

@property (nonatomic , assign) BOOL isModifySearchBarFrame;

@property (nonatomic , strong) NSMutableArray *searchArray;

@property (nonatomic,weak)UISearchBar *searchBar;

@end

@implementation SearchCourseViewController

- (NSMutableArray *)searchArray
{
    if (_searchArray==nil) {
        _searchArray = [NSMutableArray arrayWithArray:self.dataArray];
    }
    return _searchArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 预约
    self.courseSummaryTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.courseSummaryTableView.backgroundColor = RGB_Color(251, 251, 251);
    self.courseSummaryTableView.delegate = self;
    self.courseSummaryTableView.dataSource = self;
    self.courseSummaryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.courseSummaryTableView];
    
    //日程
    self.tipView1 = [[NoContentTipView alloc] initWithContetntTip:@"无内容"];
    [self.tipView1 setHidden:YES];
    [self.courseSummaryTableView addSubview:self.tipView1];
    self.tipView1.center = CGPointMake(self.courseSummaryTableView .width/2.f, self.courseSummaryTableView.height/2.f);
    
    [self.courseSummaryTableView reloadData];

    [self addNotification];
    
//    [[PermissiveResearchDatabase sharedDatabase] setDatasource:self];

}
//
//-(void)rebuildDatabase
//{
//    for (HMCourseModel *model in self.searchArray) {
//        
//        [[PermissiveResearchDatabase sharedDatabase] addRetainedObjet:model forKey:model.studentInfo.userName];
//        
//    }
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索";
    //searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.frame = CGRectMake(0, 0, self.view.width-50, 0.f);
    //UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconfont-chazhao-2"]];
    //leftView.backgroundColor = [UIColor clearColor];
    //leftView.frame = CGRectMake(0, 0, 22, 22);
    //searchBar.leftView = leftView;
    //searchBar.leftViewMode = UITextFieldViewModeUnlessEditing;
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 5;
    searchBar.delegate = self;
    //searchBar.clearsOnBeginEditing = YES;
    self.myNavigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    [searchBar resignFirstResponder];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar endEditing:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchBar.text:%@",searchBar.text);
    [self.searchBar endEditing:YES];
    
    [self.searchArray removeAllObjects];

    if (searchBar.text == nil) {
        [self.searchArray addObject:self.dataArray];
        [self.courseSummaryTableView reloadData];
        return;
    }
    
    NSLog(@"self.dataArray:%@",self.dataArray);
    
    for (HMCourseModel *model in self.dataArray) {
        
        NSLog(@"model.studentInfo.userName:%@",model.studentInfo.userName);
        
        if ([model.studentInfo.userName hasPrefix:searchBar.text]) {
            
            [self.searchArray addObject:model];
            
        }
        
    }
    
    [self.courseSummaryTableView reloadData];
    
}
//{
//    //1.首先清空搜索结果数组
//    [self.searchArray removeAllObjects];
//    
//    //2.将文本控制用户输入的字符进行简单处理
//    NSString *final = [searchBar.text stringByReplacingCharactersInRange:NSMakeRange(0, searchBar.text.length) withString:searchBar.text];
//    
//    //3.开始检索
//    NSLog(@"Start search by matrix");
//    
//    //4.消除所有
//    [[ScoringOperationQueue mainQueue] cancelAllOperations];
//    
//    //5.初始化
//    ExactScoringOperation *ope = [[ExactScoringOperation alloc] init];
//    
//    //6.要检索的字符串赋值
//    ope.searchedString = final;
//    
//    //7.调用检索block 返回检索到的结果
//    SearchCompletionBlock block = ^(NSArray *results) {
//        
//        NSLog(@"搜索结果results:%@",results);
//        if (results) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                //8.注意：这里统一检索出来的对象 都是PermissiveObject
//                //你自己需要的检索出来真在的对象是在PermissiveObject.refencedObject里
//                NSMutableArray *permissiveObj = [NSMutableArray arrayWithArray:results];
//                
//                //9.取出检索到你每个需要的数据 然后添加进检索结果的数据
//                for (PermissiveObject *perobj in permissiveObj) {
//                    
//                    HMCourseModel *model = perobj.refencedObject;
//                    
//                    [self.searchArray addObject:model];   // add filter menu objection
//                    
//                }
//                //10.刷新显示检索结果的tableView
//                [self.courseSummaryTableView reloadData];
//                
//                NSLog(@"End search by matrix");
//                
//            });
//            
//        }
//        
//    };
//    
//    
//    //检索完成
//    [ope setCustomCompletionBlock:block];
//    //添加操作 End.
//    [[ScoringOperationQueue mainQueue] addOperation:ope];
//
//}

#pragma mark - DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (tableView == self.courseSummaryTableView) {
        
        count =  self.searchArray.count;

        [self.tipView1 setHidden:count];

    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.courseSummaryTableView) {
        
        return [CourseSummaryListCell cellHeightWithModel:self.searchArray[indexPath.row]];

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.courseSummaryTableView) {
        
        CourseSummaryListCell * sumCell = [tableView dequeueReusableCellWithIdentifier:@"SumCell"];
        if (!sumCell) {
            sumCell = [[CourseSummaryListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SumCell"];
        }
        
        if (indexPath.row < self.searchArray.count)
            [sumCell setModel:self.searchArray[indexPath.row]];
        
        return sumCell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HMCourseModel  * courseModel = nil;
    if (tableView == self.courseSummaryTableView) {
        courseModel = [[self searchArray] objectAtIndex:indexPath.row];

    }
    if (courseModel) {
        CourseDetailViewController * decv = [[CourseDetailViewController alloc] init];
        decv.couresID = courseModel.courseId;
        [self.navigationController pushViewController:decv animated:YES];
    }
}


#pragma mark -
//其他页面预约状态发生变化，通知本页面更新
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh:) name:KCourseViewController_NeedRefresh object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginSucess:) name:@"kLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginoutSucess:) name:@"kLoginoutSuccess" object:nil];
}
#pragma mark - LoingNotification
- (void)didLoginSucess:(NSNotification *)notification
{
    //[self.courseSummaryTableView beginRefreshing];
}
- (void)didLoginoutSucess:(NSNotification *)notifcation
{
    [self.courseSummaryTableView reloadData];
}
- (void)needRefresh:(NSNotification *)notification
{
    HMCourseModel * model = [notification object];
    if (model) {
        
        for (HMCourseModel * sumModel in self.searchArray) {
            if ([sumModel.courseId isEqualToString:model.courseId]) {
                sumModel.courseStatue = model.courseStatue;
                
                [self.courseSummaryTableView reloadData];
                
                break;
            }
        }
    }
}


@end
