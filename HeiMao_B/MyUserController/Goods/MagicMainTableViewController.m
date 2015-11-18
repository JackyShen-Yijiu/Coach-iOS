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
#import "ShopModel.h"
#import "ShopMainModel.h"
//#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "MagicAPIUrl.h"
#import "JENetwoking.h"
#import "ToolHeader.h"


#define k_Count  1
#define k_Height 150
#define k_H      80
#define k_Width self.view.frame.size.width
#define kheight 202.5


#define kRedColor       [UIColor colorWithHex:0xcc0000]

@interface MagicMainTableViewController ()

@property (nonatomic, strong) UIImageView *BackgroundImgView;

@end

@implementation MagicMainTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // 数组初始化
    self.ShopListArray = [[NSMutableArray alloc] init];
    self.shopMainListArray = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"MagicMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"mainCell"];
    self.title = @"一步商城";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
//                                                                      
//                                                                      NSForegroundColorAttributeName:MAINCOLOR}];
    
    //创建ScrollView和PageControl
    
    
    
    [self setupScrollView];
    [self setupPageControl];
    
    //开始计时
    [self startTimer];
    
    
    
    // 加载数据
    [self startDownLoad];
    
}
// 开启定时器
- (void)startTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    
    //页号随时间发生改变
    NSInteger page = (self.pageNewList.currentPage + 1) % k_Count;
    self.pageNewList.currentPage = page;
  [self pageChanged:self.pageNewList];
    
}
//ScrollView将要被拖拽时计时器失去作用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.timer invalidate];
}

//scrollView结束拖拽时又开始计时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}
#pragma mark --------加载数据

- (void)startDownLoad {
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,shopListAPI];
    NSLog(@"________________________%@",urlString);
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        
        
        NSDictionary *dataDic = [data objectForKey:@"data"];
        NSArray *keyArray = [dataDic allKeys];
        
        
            for (NSString *keyStr in keyArray)
                        {
        
                            // 封装轮播图Model
                            if ([keyStr isEqualToString:@"toplist"])
                            {
                                NSArray *array = [dataDic objectForKey:keyStr];
                                for (NSDictionary *dic in array)
                                {
                                    ShopModel *model=[[ShopModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.ShopListArray addObject:model];
                                }
                                // 将数据传给UIScroller;
                                [self loadScrollImage:_ShopListArray];
        
                            }
                            // 封装展示图Model
                            else
                            {
                                NSArray *array = [dataDic objectForKey:@"mainlist"];
                                for (NSDictionary *dic in array)
                                {
                                    ShopMainModel *mainDodel = [[ShopMainModel alloc] init];
                                    [mainDodel setValuesForKeysWithDictionary:dic];
                                    [self.shopMainListArray addObject:mainDodel];
                                }
                             }
                        }
                        [self.tableView reloadData];
        
        
    }];

}






//- (void)startDownLoad {
//    
//    NSString *urlString = [NSString stringWithFormat:BASEURL,shopListAPI];
//    NSLog(@"________________________%@",urlString);
//    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
//        DYNSLog(@"data = %@",data);
//        
//        
//             NSArray *keyArray = [data allKeys];
//                for (NSString *keyStr in keyArray)
//                {
//        
//                    // 封装轮播图Model
//                    if ([keyStr isEqualToString:@"toplist"])
//                    {
//                        NSArray *array = [data objectForKey:keyStr];
//                        for (NSDictionary *dic in array)
//                        {
//                            ShopModel *model=[[ShopModel alloc]init];
//                            [model setValuesForKeysWithDictionary:dic];
//                            [self.ShopListArray addObject:model];
//                        }
//                        // 将数据传给UIScroller;
//                        [self loadScrollImage:_ShopListArray];
//        
//                    }
//                    // 封装展示图Model
//                    else
//                    {
//                        NSArray *array = [data objectForKey:keyStr];
//                        for (NSDictionary *dic in array)
//                        {
//                            ShopMainModel *mainDodel = [[ShopMainModel alloc] init];
//                            [mainDodel setValuesForKeysWithDictionary:dic];
//                            [self.shopMainListArray addObject:mainDodel];
//                        }
//                     }
//                }
//                [self.tableView reloadData];
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                NSLog(@"Error: %@", error);}
//        //    }];

        


//- (void)viewLoadData
//{
//    
//        //    从URL获取json数据
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:shopListAPI parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *souccrDic = [responseObject objectForKey:@"data"];
//        NSArray *keyArray = [souccrDic allKeys];
//        for (NSString *keyStr in keyArray)
//        {
//            
//            // 封装轮播图Model
//            if ([keyStr isEqualToString:@"toplist"])
//            {
//                NSArray *array = [souccrDic objectForKey:keyStr];
//                for (NSDictionary *dic in array)
//                {
//                    ShopModel *model=[[ShopModel alloc]init];
//                    [model setValuesForKeysWithDictionary:dic];
//                    [self.ShopListArray addObject:model];
//                }
//                // 将数据传给UIScroller;
//                [self loadScrollImage:_ShopListArray];
//                
//            }
//            // 封装展示图Model
//            else
//            {
//                NSArray *array = [souccrDic objectForKey:keyStr];
//                for (NSDictionary *dic in array)
//                {
//                    ShopMainModel *mainDodel = [[ShopMainModel alloc] init];
//                    [mainDodel setValuesForKeysWithDictionary:dic];
//                    [self.shopMainListArray addObject:mainDodel];
//                }
//             }
//        }
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
//    
//    
//    
//  }


#pragma mark --- 下载scrollView图片
- (void)loadScrollImage:(NSMutableArray *)imageArray {
    
    for (int i = 0; i < imageArray.count; i++) {
        
        ShopModel *shopMain = imageArray[i];
        
        NSString * strUrl = shopMain.productimg;
        
        NSString *encoded = [strUrl  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        self.BackgroundImgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*k_Width, 0, k_Width, k_Height+k_H)];
        
        [self.BackgroundImgView sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"picholder"]];
        
        self.BackgroundImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTopImageView:)];
        [self.BackgroundImgView addGestureRecognizer:singleTap];
        [self.scrollNewList addSubview:self.BackgroundImgView];
        
        
    }
}
#pragma mark ========== 点击scrollView图片显示详情
- (void)didClickTopImageView:(UITapGestureRecognizer *)tap {
    
    MagicDetailViewController *detailVC = [[MagicDetailViewController alloc] init];
    
    int count =  _scrollNewList.contentOffset.x/k_Width;
    
    detailVC.mainModel = _shopMainListArray[count];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark --------创建ScrollView
- (void)setupScrollView {
    
    //1.创建并添加到视图
    self.scrollNewList = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, k_Width, kheight)];
    [self.view addSubview:self.scrollNewList];
    
    //2.设置scrollView的一些基本属性
    self.scrollNewList.backgroundColor = [UIColor grayColor];
    self.scrollNewList.contentSize = CGSizeMake(k_Width*k_Count, 0);
    self.scrollNewList.pagingEnabled = YES;
    
    self.tableView.tableHeaderView = self.scrollNewList;
    //隐藏滑动阴影
    self.scrollNewList.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    self.scrollNewList.delegate = self;
}
#pragma mark ----创建PageControl
- (void)setupPageControl {
    
    //1.创建并添加到视图
    self.pageNewList = [[UIPageControl alloc] initWithFrame:CGRectMake(k_Height, k_Height+40, k_Width-100-180, 0)];
    self.pageNewList.numberOfPages = k_Count;
    [self.view addSubview:self.pageNewList];
    self.pageNewList.currentPage = 0;
    self.pageNewList.currentPageIndicatorTintColor = [UIColor redColor];
    
    //添加监听事件
    [self.pageNewList addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
}

//分页监听方法
- (void)pageChanged:(UIPageControl *)page {
    
    CGFloat x = page.currentPage*k_Width;
    [self.scrollNewList setContentOffset:CGPointMake(x, 0)  animated:YES];
}

//实现协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算
    int count =  scrollView.contentOffset.x/k_Width;
    
    self.pageNewList.currentPage = count;
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
    
    MagicMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShopMainModel *mainModel = _shopMainListArray[indexPath.row];
    
    NSString *encoded = [mainModel.productimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [cell.shopMainImage sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg.png"]];
     return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 195;
    
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
