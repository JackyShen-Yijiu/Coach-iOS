//
//  QueryViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "QueryViewController.h"
#import <Masonry/Masonry.h>
#import "UIView+Sizes.h"
#import "ToolHeader.h"
#import <CoreLocation/CoreLocation.h>

static NSString *const kDrivingUrl = @"driveschool/nearbydriveschool?%@";

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)
@interface QueryViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;

}
@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UIButton *goBackButton;
@property (strong, nonatomic) UILabel *topLabel;
@property (assign, nonatomic) BOOL isLocation;
@property (strong, nonatomic) UISearchBar *searchTextField;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation QueryViewController
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
//        [_searchTextField addTarget:self action:@selector(dealChange:) forControlEvents:UIControlEventEditingChanged];
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
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont boldSystemFontOfSize:18];
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"驾校查询";
    }
    return _topLabel;
}

- (UIButton *)goBackButton{
    if (_goBackButton == nil) {
        _goBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_goBackButton setBackgroundImage:[UIImage imageNamed:@"返回_click"] forState:UIControlStateNormal];
        [_goBackButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
        [_goBackButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _goBackButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _goBackButton;
}

- (void)startLocation
{
    if (!_locationManager) {
        // 1. 实例化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 2. 设置代理
        _locationManager.delegate = self;
        // 3. 定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // 4.请求用户权限：分为：⓵只在前台开启定位⓶在后台也可定位，
        //注意：建议只请求⓵和⓶中的一个，如果两个权限都需要，只请求⓶即可，
        //⓵⓶这样的顺序，将导致bug：第一次启动程序后，系统将只请求⓵的权限，⓶的权限系统不会请求，只会在下一次启动应用时请求⓶
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            [_locationManager requestWhenInUseAuthorization];//⓵只在前台开启定位
//            [_locationManager requestAlwaysAuthorization];//⓶在后台也可定位
        }
     
    
    }
    
    self.isLocation = NO;
    
    // 6. 更新用户位置
    [_locationManager startUpdatingLocation];
    
   
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    NSString *locationContent =[NSString stringWithFormat:@"latitude=%f&longitude=%f&radius=10000",location.coordinate.latitude,location.coordinate.longitude];
//    NSString *locationContent =@"latitude=40.096263&longitude=116.1270&radius=10000";
    NSString *urlString = [NSString stringWithFormat:kDrivingUrl,locationContent];
    NSString *url = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],urlString];
    
    [manager stopUpdatingLocation];
    
  
    [self.dataArray removeAllObjects];
        [JENetwoking startDownLoadWithUrl:url postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
           
            NSDictionary *param = data;
            NSArray *array = param[@"data"];
            
            if (array.count >0 && array != nil && ![array isEqual:[NSNull null]]) {
                 self.isLocation = YES;
                for (NSDictionary *dic in array) {
                    [self.dataArray addObject:dic];
                }
            }
            [self.tableView reloadData];
        }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"挂靠驾校";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self startLocation];
    
    [self.view addSubview:self.navImage];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.goBackButton];
    [self.view addSubview:self.searchTextField];
    

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
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(@44);
        make.top.mas_equalTo(self.navImage.mas_bottom).offset(0);
    }];
    [self.view addSubview:self.tableView];
    
}
- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([_delegate respondsToSelector:@selector(senderData:)]) {
        [_delegate senderData:dic];
    }
    [UserInfoModel defaultUserInfo].schoolId = dic[@"schoolid"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"getschoolbyname?schoolname=%@",searchText];
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],url];
     
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"id = %@",responseObject);
        NSDictionary *param = responseObject;
        NSArray *array = param[@"data"];
        if (array.count >0 && array != nil && ![array isEqual:[NSNull null]]) {
            for (NSDictionary *dic in array) {
                [self.dataArray addObject:dic];
            }
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
//- (void)dealChange:(UITextField *)text {
//    [self.dataArray removeAllObjects];
//    NSString *urlstring = [NSString stringWithFormat:@"http://123.57.63.15:8181/api/v1/getschoolbyname?schoolname=%@",text.text];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlstring parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"id = %@",responseObject);
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        
//    }];
//}


@end
