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
     self.view.layer.contents = (id)([UIImage imageNamed:@"building_pic.jpg"].CGImage);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
