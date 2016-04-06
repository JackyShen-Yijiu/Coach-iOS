//
//  ComingSoonController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "ComingSoonController.h"
#define imgY 164

@interface ComingSoonController ()

@end

@implementation ComingSoonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"敬请期待";
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"building_pic.jpg"]];
    if (YBIphone6Plus) {
        imgView.frame = CGRectMake(0, imgY, self.view.width, 331.2);
    }
    if (YBIphone6) {
        imgView.frame = CGRectMake(0, imgY, self.view.width, 300);
    }
    if (YBIphone5) {
        imgView.frame = CGRectMake(0, imgY, self.view.width, 256);
    }
    [self.view addSubview:imgView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
