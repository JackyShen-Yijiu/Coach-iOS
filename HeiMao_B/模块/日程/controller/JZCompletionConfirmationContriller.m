//
//  JZCompletionConfirmationContrillerViewController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCompletionConfirmationContriller.h"
#import "JZCompletionConfirmationCell.h"
#import <YYModel.h>
#import "JZData.h"
#import "YBConfimContentView.h"
#import "JZNoDataShowBGView.h"
@interface JZCompletionConfirmationContriller () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *subjectTwoArray;

@property (nonatomic, strong) NSArray *subjectThreeArray;

@property (nonatomic, strong) NSMutableArray *listStudentArray;

@property (nonatomic, strong) JZNoDataShowBGView *noDataShowBGView;

@end

@implementation JZCompletionConfirmationContriller

- (void)viewDidLoad {
    [super viewDidLoad];
    _listStudentArray = [NSMutableArray array];
    self.title = @"确认完成";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshListTable) name:kCompletionComfiromatton object:nil];
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    [self initSubjectData];
    [self.view addSubview:self.noDataShowBGView];

   }
- (void)viewWillDisappear:(BOOL)animated{
    self.noDataShowBGView.hidden = YES;
}
- (void)initListData{
    [NetWorkEntiry getCoachOfFinishStudentWihtCoachID:[UserInfoModel defaultUserInfo].userID success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"initListData responseObject:%@",responseObject);
        
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            NSArray *resultArray = param[@"data"];
            if (resultArray.count) {
                self.noDataShowBGView.hidden = YES;
                [self.listStudentArray removeAllObjects];
                for (NSDictionary *dic in resultArray) {
                    JZData *listModel = [JZData yy_modelWithDictionary:dic];
                    [_listStudentArray addObject:listModel];
                }
            }else{
                self.noDataShowBGView.hidden = NO;
                
            }
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)initSubjectData{
    [NetWorkEntiry getSubjectTwoAndSubjectThreeContentsuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       /* 
        
        {
        "type": 1,
        "msg": "",
        "data": {
        "subjecttwo": [
        "起步",
        "直角转弯",
        "侧方停车",
        "曲线行驶",
        "坡道定点停车和起步",
        "倒车入库",
        "综合练习"
        ],
        "subjectthree": [
        "上车准备",
        "起步",
        "直线行驶",
        "变更车道",
        "通过路口",
        "靠边停车",
        "会车",
        "超车",
        "掉头",
        "夜间行驶",
        "综合练习"
        ]
        }
        }
        */
        NSDictionary *param = responseObject;
        if ([param[@"type"] integerValue] == 1) {
            
            NSArray *subjectTwo = param[@"data"][@"subjecttwo"];
            NSArray *subjectThree = param[@"data"][@"subjectthree"];
            if ( subjectTwo.count) {
                
                _subjectTwoArray =  subjectTwo;
                NSLog(@"_subjectTwoArray = %@",_subjectTwoArray);
            }
            if ( subjectThree.count) {
                _subjectThreeArray =  subjectThree;
            }
            [self initListData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark ---- 通知方法
- (void)refreshListTable{
    
    // 重新刷新列表
    [self initListData];
    [self.tableView reloadData];
}
#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listStudentArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZData *listModel = self.listStudentArray[indexPath.row];
    NSLog(@"heightForRowAtIndexPath _subjectTwoArray:%@",_subjectTwoArray);
    
    NSLog(@"indexPathrow:%ld data.isOpen:%d [JZCompletionConfirmationCell cellHeihtWithlistData:listModel]:%f",(long)indexPath.row,listModel.isOpen,[JZCompletionConfirmationCell cellHeihtWithlistData:listModel subjectArray:_subjectTwoArray]);
    
    return [JZCompletionConfirmationCell cellHeihtWithlistData:listModel subjectArray:_subjectTwoArray];

}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *IDCompletionConfirmationCell = @"JZCompletionConfirmationCell";
    JZCompletionConfirmationCell *cell = [tableView dequeueReusableCellWithIdentifier:IDCompletionConfirmationCell];
    
    if (!cell) {
        
        cell = [[JZCompletionConfirmationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCompletionConfirmationCell];
    }
    cell.subjectArray = _subjectTwoArray;
    cell.parentViewController = self;
    
    JZData *listModel = self.listStudentArray[indexPath.row];
    
    cell.listModel = listModel;
    
    // 展开箭头的方向
    if (listModel.isOpen) {
        
        [UIView animateWithDuration:0.5 animations:^{
            cell.arrowImageView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        } completion:^(BOOL finished) {
        }];

    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    JZData *listModel = self.listStudentArray[indexPath.row];
    listModel.isOpen = !listModel.isOpen;
    [self.listStudentArray replaceObjectAtIndex:indexPath.row withObject:listModel];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (JZNoDataShowBGView *)noDataShowBGView{
    if (_noDataShowBGView == nil) {
        _noDataShowBGView = [[JZNoDataShowBGView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
        _noDataShowBGView.imgStr = @"people_null";
        _noDataShowBGView.titleStr = @"暂无数据";
        _noDataShowBGView.titleColor  = JZ_FONTCOLOR_DRAK;
        _noDataShowBGView.fontSize = 14.f;
        _noDataShowBGView.hidden = YES;
    }
    return _noDataShowBGView;
}

@end
