//
//  JZBulletinController.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZBulletinController.h"
#import "JZBulletinView.h"
@interface JZBulletinController ()
@property (nonatomic, weak) JZBulletinView *bulletinView;
@end

@implementation JZBulletinController


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    WS(ws);
    
    if ([ws.delegate respondsToSelector:@selector(JZBulletinControllerGetLastBulletin:)]) {
 
        
        if (ws.bulletinView.listDataArray&&self.bulletinView.listDataArray.count>0) {
            
            ws.bulletinView.dataModel = self.bulletinView.listDataArray[0];
            
            NSLog(@"%zd",ws.bulletinView.dataModel.seqindex);
       
            [ws.delegate JZBulletinControllerGetLastBulletin:[NSString stringWithFormat:@"%zd",ws.bulletinView.dataModel.seqindex]];
            
        }
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"公告";
    JZBulletinView *bulletinView = [[JZBulletinView alloc]initWithFrame:CGRectMake(0, 0, JZScreen.width, JZScreen.height)];
    self.bulletinView = bulletinView;
    bulletinView.vc = self;
    
    [self.view addSubview:bulletinView];
//
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
        
    

    
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
