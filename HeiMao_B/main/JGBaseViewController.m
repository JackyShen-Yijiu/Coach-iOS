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

@property (nonatomic,copy)NSString *systemBadgeStr;

@property (nonatomic,copy)NSString *zixunBadgeStr;

@end

@implementation JGBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self loadMessageData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    NSString *lastnews = [user objectForKey:@"lastnews"];
    
    WS(ws);
    [NetWorkEntiry getMessageUnReadCountlastmessage:lastmessage lastnews:lastnews success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"获取未读消息responseObject:%@",responseObject);
        
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        NSDictionary *data = [responseObject objectInfoForKey:@"data"];
        
        NSDictionary *messageinfo = [data objectInfoForKey:@"messageinfo"];
        NSDictionary *Newsinfo = [data objectInfoForKey:@"Newsinfo"];
        
        if (type == 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ws.systemBadgeStr = [NSString stringWithFormat:@"%@",messageinfo[@"messagecount"]];
             
                ws.zixunBadgeStr = [NSString stringWithFormat:@"%@",Newsinfo[@"newscount"]];
            
                [self setupUnreadMessageCount];
                
            });
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error.debugDescription);
        
    }];
    
}

#pragma mark - 小红点逻辑 Tab小红点 + App小红点
-(void)setupUnreadMessageCount
{
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = [self.systemBadgeStr integerValue] + [self.zixunBadgeStr integerValue];
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    UIViewController *tController = [self.tabBarController.viewControllers objectAtIndex:2];

    if (unreadCount > 0) {
        
        tController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unreadCount];
        
    }else{
        
        tController.tabBarItem.badgeValue = nil;
        
        [self hiddenMessCountInTabBar];
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    
}

@end
