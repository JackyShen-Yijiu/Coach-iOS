//
//  AboutUsViewController.m
//  studentDriving
//
//  Created by bestseller on 15/11/19.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
//@property (strong, nonatomic) UIImageView *logoImageView;
//@property (strong, nonatomic) UILabel *topLabel;
//@property (strong, nonatomic) UILabel *topLabelOne;
//@property (strong, nonatomic) UILabel *topLabelTwo;

@property (strong, nonatomic) UIWebView * webView;
@end

@implementation AboutUsViewController
//- (UIImageView *)logoImageView {
//    if (_logoImageView == nil) {
//        _logoImageView = [[UIImageView alloc] init];
//        _logoImageView.image = [UIImage imageNamed:@"logoImage.png"];
//    }
//    return _logoImageView;
//}
//- (UILabel *)topLabel {
//    if (_topLabel == nil) {
//        _topLabel = [[UILabel alloc] init];
//        _topLabel.textAlignment = NSTextAlignmentCenter;
//        _topLabel.font = [UIFont boldSystemFontOfSize:14];
//        _topLabel.text = @"极致";
//    }
//    return _topLabel;
//}
//- (UILabel *)topLabelOne {
//    if (_topLabelOne == nil) {
//        _topLabelOne = [[UILabel alloc] init];
//        _topLabelOne.textAlignment = NSTextAlignmentCenter;
//        _topLabelOne.font = [UIFont boldSystemFontOfSize:14];
//        _topLabelOne.text = @"做有态度的培训驾校";
//    }
//    return _topLabelOne;
//}
//- (UILabel *)topLabelTwo {
//    if (_topLabelTwo == nil) {
//        _topLabelTwo = [[UILabel alloc] init];
//        _topLabelTwo.textAlignment = NSTextAlignmentCenter;
//        _topLabelTwo.font = [UIFont boldSystemFontOfSize:14];
//        _topLabelTwo.text = @"V 1.0";
//    }
//    return _topLabelTwo;
//}

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    NSString *str = @"https://itunes.apple.com/us/app/ji-zhi-jiao-lian/id1089530725?l=zh&ls=1&mt=8";
    
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    
    
    
    
    
    
    
    
}



@end
