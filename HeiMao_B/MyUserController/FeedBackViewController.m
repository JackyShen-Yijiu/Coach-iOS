//
//  FeedBackViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/8.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "FeedBackViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

@interface FeedBackViewController ()
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *submitButton;
@end

@implementation FeedBackViewController

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.backgroundColor = kDefaultTintColor;
        [_submitButton addTarget:self action:@selector(clickSubmit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 90)];
        _textView.backgroundColor = [UIColor whiteColor];
    }
    return _textView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = RGBColor(245, 247, 250);
    self.title = @"反馈";
    
    [self.view addSubview:self.textView];
    
    [self.view addSubview:self.submitButton];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.height.mas_equalTo(@44);
    }];
}
- (void)clickSubmit:(UIButton *)sender {
    
}

@end
