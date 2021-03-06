//
//  WorkTypeListController.m
//  HeiMao_B
//
//  Created by kequ on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//


#import "WorkTypeListController.h"

@interface WorkTypeListController()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,copy)NSString * seletedWorkModelName;

@end

@implementation WorkTypeListController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    NSInteger coachtype = [UserInfoModel defaultUserInfo].coachtype;
    NSString *workProperty = [WorkTypeModel converTypeToString:coachtype];
    NSLog(@"coachtype:%lu workProperty:%@",coachtype,workProperty);
    self.seletedWorkModelName = workProperty;
    
    self.myNavigationItem.title = @"工作性质";
    
    [self initData];
    [self initUI];
}

- (void)initData
{
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:KCourseWorkTypeCount];
    for (NSInteger i = 0 ;i < KCourseWorkTypeCount;i++) {
        WorkTypeModel * model = [[WorkTypeModel alloc] init];
        model.type = i;
        model.name = [WorkTypeModel converTypeToString:i];
        [array addObject:model];
    }
    self.dataArray = array;
}

- (void)initUI
{

    [self.view addSubview:self.navImage];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.goBackButton];
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
    [self.goBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.width.mas_equalTo(@50);
        make.height.mas_equalTo(@50);
    }];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - NavBar
- (UIView *)navImage {
    if (_navImage == nil) {
        _navImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 64)];
        _navImage.backgroundColor = RGB_Color(0x28, 0x79, 0xF3);
    }
    return _navImage;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"工作性质";
    }
    return _topLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (void)goBack:(UIButton *)button
{
    if (self.isPush) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableViewDeletate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect"] forState:UIControlStateNormal];
    button.tag = indexPath.row;
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    cell.textLabel.textColor = [UIColor blackColor];
   
    WorkTypeModel * model  = self.dataArray[indexPath.row];
    
    cell.textLabel.text = model.name;
    
    [button setSelected:[model.name isEqualToString:self.seletedWorkModelName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkTypeModel * model  = self.dataArray[indexPath.row];

    self.seletedWorkModelName=model.name;
    
    [self.tableView reloadData];
    
    [self didSeletedModel];
    
}

//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.tableView reloadData];
//    [self didSeletedModel];
//}

- (void)clickButton:(UIButton *)button
{
    WorkTypeModel * model  = self.dataArray[button.tag];
    
    self.seletedWorkModelName=model.name;
    
    [self.tableView reloadData];
    
    [self didSeletedModel];
    
}

- (void)didSeletedModel
{
    
    KCourseWorkType workProperty = [WorkTypeModel converStringToType:self.seletedWorkModelName];

    if ([_delegate respondsToSelector:@selector(workTypeListController:didSeletedWorkType:workName:)] && self.seletedWorkModelName) {
        [_delegate workTypeListController:self didSeletedWorkType:workProperty workName:self.seletedWorkModelName];
    }
    
}

@end

