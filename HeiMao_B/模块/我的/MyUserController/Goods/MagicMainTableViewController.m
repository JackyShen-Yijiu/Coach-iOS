//
//  MagicMainTableViewController.m
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "MagicMainTableViewController.h"
#import "MagicMainTableViewCell.h"
#import "MagicDetailViewController.h"
#import "LTBottomView.h"
#import "ShopMainModel.h"
#import "AFNetworking.h"
#import "JENetwoking.h"
#import "ToolHeader.h"

static NSString *kMagicShop = @"/getmailproduct?index=1&count=10&producttype=0";


#define k_Count  3
#define k_Height 150
#define k_H      80
#define k_Width self.view.frame.size.width
#define kheight 202.5


#define kRedColor       [UIColor colorWithHex:0xcc0000]

@interface MagicMainTableViewController ()

@property (nonatomic, strong) UIImageView *BackgroundImgView;

@end

@implementation MagicMainTableViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [super viewDidLoad];
    // 数组初始化
    self.ShopListArray = [[NSMutableArray alloc] init];
    self.shopMainListArray = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"MagicMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.title = @"极致商城";

    
    // 加载数据
    [self startDownLoad];
    
}
#pragma mark --------加载数据

- (void)startDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HOST_TEST_DAMIAN,kMagicShop];
    NSLog(@"%@",urlString);
    NSDictionary *parm = @{@"cityname":@"北京"};
//    NSLog(@"%@",[AcountManager manager].userCity);
    [JENetwoking startDownLoadWithUrl:urlString postParam:parm WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        if (data == nil) {
            return ;
        }
        NSDictionary *dataDic = [data objectForKey:@"data"];
       
                            {
                                NSArray *array = [dataDic objectForKey:@"mainlist"];
                                if (array.count == 0) {
                                    ToastAlertView *AlertView = [[ToastAlertView alloc] initWithTitle:@"还没有商品哦!"];
                                    [AlertView show];
                                    
//                                    [self obj_showTotasViewWithMes:@"还没有商品哦!"]; 
                                    return;
                                }
                                for (NSDictionary *dic in array)
                                {
                                    ShopMainModel *mainDodel = [[ShopMainModel alloc] init];
                                    [mainDodel setValuesForKeysWithDictionary:dic];
                                    [self.shopMainListArray addObject:mainDodel];
                                }
                             }
        
                        [self.tableView reloadData];
        
        
    } ];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_shopMainListArray count];
}

// 从XIB中加载自定义Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *definition = @"myCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        
        UINib *nib = [UINib nibWithNibName:@"MagicMainTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:definition];
//        nibsRegistered = YES;
    }
    MagicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:definition];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopMainModel *mainModel = _shopMainListArray[indexPath.row];
    NSString *encoded = [mainModel.productimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.shopMainImage sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg.png"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIScreen mainScreen].bounds.size.width / 2;

    
}

#pragma mark ----- cell 的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
    detailVC.mainModel = _shopMainListArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
