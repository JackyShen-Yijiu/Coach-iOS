//
//  ComingSoonController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "ComingSoonController.h"

@interface ComingSoonController ()

@end

@implementation ComingSoonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"敬请期待";
    UIImageView *bgImg  =[[UIImageView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height)];
    bgImg.image = [ UIImage imageNamed:@"building_pic.jpg"];
    
    [self.view addSubview:bgImg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
