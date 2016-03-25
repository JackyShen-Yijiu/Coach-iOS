//
//  ProtocalViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/19.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "ProtocalViewController.h"
#import "ToolHeader.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

@interface ProtocalViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIView *navImage;
@property (strong, nonatomic) UILabel *topLabel;
@property (strong, nonatomic)UIButton *goBackButton;

@end

@implementation ProtocalViewController

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
        _topLabel.text = @"服务协议";
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
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64)];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    
    [self.view addSubview:self.webView];
    
    
    
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
    
    [self.view addSubview:self.goBackButton];
    NSString *urlString = @"http://www.ifanying.com/coachAgreement.html";
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    
    [self.webView loadRequest:request];
}
- (void)dealGoBack:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    DYNSLog(@"startLoad");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    DYNSLog(@"finishLoad");
  
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    DYNSLog(@"error");
  
    
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
