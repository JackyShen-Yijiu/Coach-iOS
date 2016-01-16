//
//  PersonaizeLabelController.m
//  HeiMao_B
//
//  Created by 胡东苑 on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "PersonaizeLabelController.h"
#import "PersonalizeLabelCell.h"
#import "PersonlizeModel.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "NoContentTipView.h"

@interface PersonaizeLabelController () <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    NSInteger _tag;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *referButton;

@property (nonatomic, strong) NSMutableArray *systemTagArr;                   //系统标签
@property (nonatomic, strong) NSMutableArray *customTagArr;                   //自定义标签
@property (strong, nonatomic) NSMutableArray *systemTagColorArray;            //判断系统标签是否选择
@property (strong, nonatomic) NSMutableArray *customTagColorArray;            //判断自定义标签是否选择
@property (strong, nonatomic) NSMutableArray *systemTagBGColorArray;          //系统标签颜色
@property (strong, nonatomic) NSMutableArray *customTagBGColorArray;          //自定义标签颜色

@end

@implementation PersonaizeLabelController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64 -49)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _systemTagArr = [[NSMutableArray alloc] init];
        _customTagArr = [[NSMutableArray alloc] init];
        _systemTagColorArray = [[NSMutableArray alloc] init];
        _customTagColorArray = [[NSMutableArray alloc] init];
        _systemTagBGColorArray = [[NSMutableArray alloc] init];
        _customTagBGColorArray = [[NSMutableArray alloc] init];
        for (PersonlizeModel *model in self.systemTagArray) {
            [_systemTagArr addObject:model.tagname];
            if (model.is_choose.integerValue == 1) {
                [_systemTagColorArray addObject:@(1)];
                [_systemTagBGColorArray addObject:model.color];
            }else{
                [_systemTagColorArray addObject:@(0)];
                [_systemTagBGColorArray addObject:@""];
            }
        }
        for (PersonlizeModel *model in self.customTagArray) {
            [_customTagArr addObject:model.tagname];
            if (model.is_audit) {
                [_customTagColorArray addObject:@(0)];
                [_customTagBGColorArray addObject:@""];
            }else{
                [_customTagColorArray addObject:@(1)];
                [_customTagBGColorArray addObject:model.color];
            }
        }

        _dataArray = [NSMutableArray arrayWithObjects:_systemTagArr,_customTagArr, nil];
//        _dataArray = [[NSMutableArray alloc] init];
            
    }
    return _dataArray;
}

- (UIButton *)referButton{
    if (_referButton == nil) {
        _referButton = [[UIButton alloc] init];
        _referButton.backgroundColor = [UIColor blueColor];
        _referButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_referButton setTitle:@"提交" forState:UIControlStateNormal];
        [_referButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_referButton addTarget:self action:@selector(dealRefer:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _referButton;
}


#pragma mark -   action

- (void)dealRefer:(UIButton *)btn {
    NSString *coachTags = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kchooseTag];
    NSString *tagslist = @"";
    NSMutableArray *strArray = [[NSMutableArray alloc] init];
    for (int i = 0;i<self.systemTagColorArray.count;i++) {
        NSNumber *num = self.systemTagColorArray[i];
        if (num.integerValue == 1) {
            PersonlizeModel *model = self.systemTagArray[i];
            [strArray addObject:model._id];
        }
    }
    for (PersonlizeModel *model in self.customTagArray) {
        [strArray addObject:model._id];
    }
    tagslist = [strArray componentsJoinedByString:@","];
    NSLog(@"tagslist:%@",tagslist);
    
    [JENetwoking startDownLoadWithUrl:coachTags postParam:@{@"coachid":[UserInfoModel defaultUserInfo].userID,@"tagslist":tagslist} WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"type"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.referButton];
    [self.view addSubview:self.tableView];
    
    [self.referButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
}

#pragma mark -   delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PersonalizeLabelCell cellHeightWithNoTitleWithArray:self.dataArray[indexPath.section] WithTextFieldIsExist:indexPath.section>0?YES:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
        label.text = @"   默认标签";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        return label;
    }else {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 34)];
        label.text = @"   自定义标签";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        return label;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalizeLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (!cell) {
        cell = [[PersonalizeLabelCell alloc] initWithStyle:0 reuseIdentifier:@"yy"];
    }
    cell.addTag = ^(NSString *str) {
        NSString *coachTags = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kaddTag];
        [JENetwoking startDownLoadWithUrl:coachTags postParam:@{@"coachid":[UserInfoModel defaultUserInfo].userID,@"tagname":str} WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dic = data;
            if ([[dic objectForKey:@"type"] integerValue] == 1) {
                [_customTagArr addObject:str];
                [self.tableView reloadData];
                [self.customTagArray addObject:[PersonlizeModel converJsonDicToModel:[dic objectForKey:@"data"]]];
            }
        }];
    };
    cell.tapTagLabel = ^(NSInteger tag){
        if (indexPath.section == 0) {
            NSNumber *num = _systemTagColorArray[tag];
            [_systemTagColorArray replaceObjectAtIndex:tag withObject:@(num.integerValue==0?1:0)];
            [self.tableView reloadData];
        }else {
            _tag = tag;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除此标签吗!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }
    };
    NSLog(@"%@",_systemTagColorArray);
    NSLog(@"%@",_customTagColorArray);
    NSLog(@"%@",_systemTagBGColorArray);
    NSLog(@"%@",_customTagBGColorArray);
    [cell initUIWithNoTitleWithArray:self.dataArray[indexPath.section] WithTextFieldIsExist:indexPath.section>0?YES:NO withLabelColorArray:indexPath.section?_customTagColorArray:_systemTagColorArray withBackGroundColorArr:indexPath.section?_customTagBGColorArray:_systemTagBGColorArray];
    return cell;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        NSLog(@"cancal");
    }else {
        PersonlizeModel *model = self.customTagArray[_tag];
        NSString *delegateCoachTags = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kdelegateTag];
        [JENetwoking startDownLoadWithUrl:delegateCoachTags postParam:@{@"coachid":[UserInfoModel defaultUserInfo].userID,@"tagid":model._id} WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dic = data;
            if ([[dic objectForKey:@"type"] integerValue] == 1) {
                [_customTagArr removeObjectAtIndex:_tag];
                [self.tableView reloadData];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
