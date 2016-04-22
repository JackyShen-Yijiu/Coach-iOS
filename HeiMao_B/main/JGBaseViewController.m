//
//  JGBaseViewController.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/22.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGBaseViewController.h"
#import "EaseMob.h"

@interface JGBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation JGBaseViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadMessageData];
   
    //设置状态栏的字体颜色模式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMainChatMessage) name:@"receiveMainChatMessage" object:nil];
        
}

- (void)receiveMainChatMessage
{
    [self loadMessageData];
}

- (void)loadMessageData
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *lastmessage = [user objectForKey:@"lastmessage"];
    NSString *lastnew = [user objectForKey:@"lastnew"];
    NSString *lastbulletin = [user objectForKey:@"lastbulletin"];

    WS(ws);
    [NetWorkEntiry getMessageUnReadCountlastmessage:lastmessage lastnews:lastnew lastbulletin:lastbulletin success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"获取未读消息responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSDictionary *data = [responseObject objectInfoForKey:@"data"];
        
        NSDictionary *messageinfo = [data objectInfoForKey:@"messageinfo"];
        NSDictionary *bulletininfo = [data objectInfoForKey:@"bulletininfo"];
        NSDictionary *Newsinfo = [data objectInfoForKey:@"Newsinfo"];

        if (type == 1) {
            
            // 系统消息
            ws.systemBadgeStr = [NSString stringWithFormat:@"%@",messageinfo[@"messagecount"]];
            ws.systemDetailsStr = [NSString stringWithFormat:@"%@",messageinfo[@"message"]];
            ws.systemTimeStr = [NSString stringWithFormat:@"%@",messageinfo[@"messagetime"]];

            // 公告
            ws.noticeBadgeStr = [NSString stringWithFormat:@"%@",bulletininfo[@"bulletincount"]];
            ws.noticeDetailsStr = [NSString stringWithFormat:@"%@",bulletininfo[@"bulletin"]];
            ws.noticeTimeStr = [NSString stringWithFormat:@"%@",bulletininfo[@"bulletintime"]];

            // 资讯
            ws.newsBadgeStr = [NSString stringWithFormat:@"%@",Newsinfo[@"newscount"]];
            ws.newsDetailsStr = [NSString stringWithFormat:@"%@",Newsinfo[@"news"]];
            ws.newsTimeStr = [NSString stringWithFormat:@"%@",Newsinfo[@"newstime"]];

            [self setupUnreadMessageCount];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USERLOADED object:ws];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.debugDescription);
        
    }];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 小红点逻辑 Tab小红点 + App小红点
-(void)setupUnreadMessageCount
{
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = [self.systemBadgeStr integerValue] + [self.noticeBadgeStr integerValue] + [self.newsBadgeStr integerValue];
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    UIViewController *messageVc = [self.tabBarController.viewControllers objectAtIndex:2];
    if ([self.systemBadgeStr integerValue] + [self.noticeBadgeStr integerValue] > 0) {
        messageVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[self.systemBadgeStr integerValue] + [self.noticeBadgeStr integerValue]];
    }else{
        messageVc.tabBarItem.badgeValue = nil;
        [self hiddenMessCountInTabBar:2];
    }
    
    UIViewController *myVc = [self.tabBarController.viewControllers objectAtIndex:3];
    if ([self.newsBadgeStr integerValue] > 0) {
        myVc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)[self.newsBadgeStr integerValue]];
    }else{
        myVc.tabBarItem.badgeValue = nil;
        [self hiddenMessCountInTabBar:3];
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    
}

@end
