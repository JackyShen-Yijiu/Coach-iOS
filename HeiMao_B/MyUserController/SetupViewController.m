//
//  SetupViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SetupViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "FeedBackViewController.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)


@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation SetupViewController
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"预约提醒",@"新消息通知",@"开课提醒"],@[@"关于我们",@"去评分",@"反馈"]];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
        switchControl.onTintColor = kDefaultTintColor;
        switchControl.tag = 100 + indexPath.row;
        cell.accessoryView = switchControl;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }
}

@end
