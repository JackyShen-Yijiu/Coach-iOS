//
//  MagicDetailViewController.m
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "MagicDetailViewController.h"
#import "DetailIntroduceCell.h"
#import "DetailPriceCell.h"
#import "LTBottomView.h"
#import "PrivateMessageController.h"
//#import "UIImageView+WebCache.h"
#import "ToolHeader.h"

@interface MagicDetailViewController ()

@end

@implementation MagicDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [self addBottomView];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [_bottomView  removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义导航栏返回按钮
//    [self backViewBtn];
    self.view.backgroundColor = [UIColor whiteColor];
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"商城详情";
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],

//                                                                      NSForegroundColorAttributeName:MAINCOLOR}];
    
    
    
//    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    
    // 加载用户的已有的积分数
}

#pragma mark ----- 自定义导航栏返回按钮
- (void)backViewBtn
{
    // 用自定义Button代替
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [backBtn setFrame:CGRectMake(10, 10, 25, 30)];
    
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn setTitle:nil forState:UIControlStateNormal];
    
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bc.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)backAction:(UIButton *)btn
{
    
//    UIView *viewText = [_wid viewWithTag:200];
//    [viewText removeFromSuperview];
//    NSLog(@"------");
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    numberLabel.text = [NSString stringWithFormat:@"%d",[MyWallet getInstance].amount];
    // 取出立即购买按钮,添加点击事件
   _didClickBtn = [_bottomView viewWithTag:102];
    
    
    
    
    
    
    
    
    
    [_didClickBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    CGFloat kWight = self.tableView.frame.size.width;
    CGFloat kHight = self.tableView.frame.size.height;
    if (kHight == 647) {
        kHight = kHight + 20;
    }
    
    NSLog(@"kHight= %f",kHight);
    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    
    
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    _wid = [windows lastObject];
    
    [_wid addSubview:_bottomView];
    
    
}
#pragma mark ----- 立即购买按钮的点击事件

- (void)didClick:(UIButton *)btn
{
    PrivateMessageController *privateMessageVC = [[PrivateMessageController alloc] init];

    
    [self.navigationController pushViewController:privateMessageVC animated:YES];
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
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        static NSString *definition = @"myCell";
        BOOL nibsRegistered = NO;
    // 加载第一部分Cell
    if (indexPath.row == 0)
    {
        if (!nibsRegistered)
        {
            
            UINib *nib = [UINib nibWithNibName:@"DetailPriceCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
         DetailPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:definition];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *textStr = [NSString stringWithFormat:@" 浏览   %d次",(int)_mainModel.viewcount];
        NSString *buyStr = [NSString stringWithFormat:@" 兑换   %d次",(int)_mainModel.buycount];
        NSString *moneyStr = [NSString stringWithFormat:@"%d",_mainModel.productprice];
        NSString *descStr  = _mainModel.productdesc;
        _moneyCount = _mainModel.productprice;
        cell.scanNumber.text = textStr;
        cell.buyNumber.text = buyStr;
        cell.moneyNumber.text = moneyStr;
        cell.shopDetailName.text = descStr;
        NSString *encoded = [_mainModel.detailsimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg"]];
        
        //// 判断按钮是否能点击
        _didClickBtn.selected = [MyWallet getInstance].amount > _moneyCount ? 1 : 0;
        
        NSLog(@"%d ----- %d",[MyWallet getInstance].amount,_moneyCount);
        
        if (_didClickBtn.selected) {
            [_didClickBtn setBackgroundColor:MAINCOLOR];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        
        
        
        return cell;
    }
    // 加载第二部分Cell
    else
    {
        if (!nibsRegistered)
        {
            
            UINib *nib = [UINib nibWithNibName:@"DetailIntroduceCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
        DetailIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:definition];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *encoded = [_mainModel.detailsimg stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:encoded] placeholderImage:[UIImage imageNamed:@"nav_bg"]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 250;
    }
    else
    {
        return  250;
    }
}
@end
