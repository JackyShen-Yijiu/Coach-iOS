//
//  AboutUsViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/19.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (strong, nonatomic) UIWebView * webView;
@end

@implementation AboutUsViewController

- (UIWebView * )webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"关于我们";
    
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    NSString *str = @"https://itunes.apple.com/us/app/ji-zhi-jiao-lian/id1089530725?l=zh&ls=1&mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}



@end
