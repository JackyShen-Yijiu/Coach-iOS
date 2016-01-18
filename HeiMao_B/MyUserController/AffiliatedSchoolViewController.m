//
//  QueryViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "AffiliatedSchoolViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+Sizes.h"
#import "ToolHeader.h"

static NSString *const kAffiliatedSchool = @"getschoolbyname?schoolname=%@";

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)
@interface AffiliatedSchoolViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;

@property (strong, nonatomic) UISearchBar *searchTextField;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;

@end

@implementation AffiliatedSchoolViewController
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.width, self.view.height-120) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (UISearchBar *)searchTextField {
    if (_searchTextField == nil) {
        _searchTextField = [[UISearchBar alloc] init];
        _searchTextField.placeholder = @"驾校搜索";
        _searchTextField.delegate = self;
//    [_searchTextField addTarget:self action:@selector(dealChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchTextField;
}

- (UIView *)navImage {
    if (_navImage == nil) {
        _navImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.width, 64)];
        _navImage.backgroundColor = kDefaultTintColor;
    }
    return _navImage;
}
- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.backgroundColor = [UIColor redColor];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"驾校查询";
    }
    return _topLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"挂靠驾校";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navImage];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.searchTextField];
    
    
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).with.offset(20);
        make.height.mas_equalTo(@50);
    }];
    
   
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(@44);
        make.top.mas_equalTo(self.navImage.mas_bottom).offset(0);
    }];
    [self.view addSubview:self.tableView];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeEndValue:) name:uisearchbar object:_searchTextField];
//    [self searchBar:nil textDidChange:@""];
}

- (void)clickRight:(UIButton *)sender {
    //
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    NSDictionary *dic = self.dataArray[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.dataArray[indexPath.row];

    [UserInfoModel defaultUserInfo].schoolId = dic[@"schoolid"];
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"driveschoolid":dic[@"schoolid"],@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
        
    }];
}
- (void)changeEndValue:(NSNotification *)notification
{
    [self searchBar:notification.object textDidChange:_searchTextField.text];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:kAffiliatedSchool,searchText];
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *param = responseObject;
        NSArray *array = param[@"data"];
        if (array != nil && ![array isEqual:[NSNull null]]) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in array) {
                [self.dataArray addObject:dic];
            }
            [self.tableView reloadData];
        }else if(array.count == 0){
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"没有搜索到该驾校"];
            [alerview show];
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
@end
