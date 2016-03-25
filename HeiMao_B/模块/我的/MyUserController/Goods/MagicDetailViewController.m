//
//  MagicDetailViewController.m
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "MagicDetailViewController.h"
#import "PrivateMessageController.h"
#import "UIImageView+EMWebCache.h"
#import "MyWalletViewController.h"
#define kSystemWide [UIScreen mainScreen].bounds.size.width

#define kSystemHeight [UIScreen mainScreen].bounds.size.height



@interface MagicDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) NSString *walletstr;
@end

@implementation MagicDetailViewController
- (UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight - 114)];
        _webView.hidden = YES;
    }
    return _webView;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    for (UIViewController *viewCon in self.navigationController.viewControllers) {
        if ([viewCon isKindOfClass:[MyWalletViewController class]]) {
            MyWalletViewController *myWalletVC = (MyWalletViewController *)viewCon;
            [myWalletVC refreshWalletData];
        }
        
    }
     [self addBottomView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
    NSString *urlString = self.mainModel.detailurl;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.webView loadRequest:request];

    
   
}
#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    NSUserDefaults *defaules = [NSUserDefaults standardUserDefaults];
    _walletstr = [defaules objectForKey:@"walletStr"];
//
    numberLabel.text = _walletstr;
    // 取出立即购买按钮,添加点击事件
    _didClickBtn = [_bottomView viewWithTag:102];
//    NSLog(@"_main = %@",_mainModel.is_scanconsumption);
    if ((_mainModel.is_scanconsumption == 1)) {
        [_didClickBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 1 : 0;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 301;
            [_didClickBtn setBackgroundColor:RGB_Color(255, 93, 53)];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }else
    {
       [_didClickBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        //// 判断按钮是否能点击
        _didClickBtn.selected = [_walletstr intValue]  >=  _mainModel.productprice ? 1 : 0;
        if (_didClickBtn.selected) {
            _didClickBtn.tag = 302;
            [_didClickBtn setBackgroundColor:RGB_Color(255, 93, 53)];
            [_didClickBtn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        }

    }
    
    
    
    CGFloat kWight = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHight = [UIScreen mainScreen].bounds.size.height;
    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    [self.view addSubview:_bottomView];
    
    
}
#pragma mark ----- 立即购买按钮的点击事件

- (void)didClick:(UIButton *)btn
{
    
    PrivateMessageController *privateMessageVC = [[PrivateMessageController alloc] init];
    privateMessageVC.shopID = _mainModel.productid;
    [self.navigationController pushViewController:privateMessageVC animated:YES];
    

    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _webView.hidden = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self showTotasViewWithMes:@"加载失败"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSString *string =  [self.webView stringByEvaluatingJavaScriptFromString:@"save()"];
    
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
