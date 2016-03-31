//
//  JZCompletionConfirmationContrillerViewController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZCompletionConfirmationContriller.h"
#import "JZCompletionConfirmationCell.h"

@interface JZCompletionConfirmationContriller () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *subjectTwoArray;

@property (nonatomic, strong) NSArray *subjectThreeArray;
@end

@implementation JZCompletionConfirmationContriller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认完成";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.tableView];
    self.subjectTwoArray = [NSArray array];
    [self initData];
   }
- (void)initData{
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
            [self.tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark ---- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    JZCompletionConfirmationCell *completionConfirmationCell = (JZCompletionConfirmationCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath ];
//    
//    return [completionConfirmationCell cellHeihtWith:_subjectTwoArray];
    return 410;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *IDCompletionConfirmationCell = @"cellID";
    JZCompletionConfirmationCell *completionConfirmationCell = [tableView dequeueReusableCellWithIdentifier:IDCompletionConfirmationCell];
    
    if (!completionConfirmationCell) {
        
        completionConfirmationCell = [[JZCompletionConfirmationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDCompletionConfirmationCell];
    }
    completionConfirmationCell.subjectArray = _subjectTwoArray;
    return completionConfirmationCell;
}
    

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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

@end
