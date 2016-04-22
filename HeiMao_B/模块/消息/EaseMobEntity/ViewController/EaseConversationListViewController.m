//
//  EaseConversationListViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseConversationListViewController.h"

#import "EaseMob.h"
#import "EaseSDKHelper.h"
#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"
#import "NoContentTipView.h"
#import "EMCDDeviceManager.h"
#import "SystemMessageDetailController.h"
#import "InformationMessageController.h"
#import "ChatViewController.h"
#import "JGUserTools.h"
#import "JZBulletinController.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";

@interface EaseConversationListViewController () <IChatManagerDelegate,EMChatManagerDelegate,SystemMessageDetailControllerDelegate,InformationMessageControllerDelegate,JZBulletinControllerDelegate>

@property (nonatomic,strong)NoContentTipView * tipView;

@property (strong, nonatomic) NSDate *lastPlaySoundDate;

@property (nonatomic,copy)NSString *systemBadgeStr;
@property (nonatomic,copy)NSString *systemDetailsStr;
@property (nonatomic,copy)NSString *systemTimeStr;

@property (nonatomic,copy)NSString *noticeBadgeStr;
@property (nonatomic,copy)NSString *noticeDetailsStr;
@property (nonatomic,copy)NSString *noticeTimeStr;

@end

@implementation EaseConversationListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.showRefreshHeader = NO;
    
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;

    [self registerNotifications];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoaded) name:KNOTIFICATION_USERLOADED object:nil];
    
    self.tipView = [[NoContentTipView alloc] initWithContetntTip:@"您现在没有消息"];
    [self.view addSubview:self.tipView];
    self.tipView.center = CGPointMake(self.view.width/2.f, self.view.height/2.f + 32);
    [self.tipView setHidden:YES];
    
}

- (void)userLoaded
{
    [self tableViewDidTriggerHeaderRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self tableViewDidTriggerHeaderRefresh];
    
    [self registerNotifications];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self unregisterNotifications];
}

- (void)initNavBar
{
    [self resetNavBar];
    
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    footer.backgroundColor = self.view.backgroundColor;
    return footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    [self.tipView setHidden:self.dataArray.count ? YES : NO];
    
    if (section==0) {
        if(self.dataArray && self.dataArray.count!=0){
            return 2;
        }else{
            return 0;
        }
    }else{
        if(self.dataArray && self.dataArray.count!=0){
            return [self.dataArray count]-2;
        }else{
            return 0;
        }
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
    EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (cell == nil) {
        cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"self.dataArray:%@",self.dataArray);
    
    if (indexPath.section==0) {
     
        EaseConversationModel *topModal = self.dataArray[indexPath.row];
        cell.topModel = topModal;
        
    }else{
    
        id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row+2];
        NSLog(@"model.type:%@",model.type);
        
        cell.model = model;
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
            cell.detailLabel.text = [_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model];
        } else {
            cell.detailLabel.text = [self _latestMessageTitleForConversationModel:model];
        }
        
        if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
            cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
        } else {
            cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
        }
        
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseConversationCell cellHeightWithModel:nil];
}

- (void)SystemMessageDetailControllerGetMessagelastmessage:(NSString *)lastmessage
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:lastmessage forKey:@"lastmessage"];
    [user synchronize];
    
}

- (void)JZBulletinControllerGetLastBulletin:(NSString *)lastBulletin
{
    NSLog(@"JZBulletinControllerGetLastBulletin lastbulletin:%@",lastBulletin);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:lastBulletin forKey:@"lastbulletin"];
    [user synchronize];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            self.systemBadgeStr = nil;
            // 系统消息界面跳转
            SystemMessageDetailController *systemMessageView = [[SystemMessageDetailController alloc] init];
            systemMessageView.delegate = self;
            [self.navigationController pushViewController:systemMessageView animated:YES];
            
        }else if (indexPath.row==1){
            
            self.noticeBadgeStr = nil;
            
            
            NSLog(@"跳转到公告界面");
            
            JZBulletinController *buletinVC = [[JZBulletinController alloc]init];
            
            buletinVC.delegate = self;
            
            [self.navigationController pushViewController:buletinVC animated:YES];
            
            
        }
        
    }else{
        
        id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row+2];
        
        NSDictionary * ext = [[model conversation] ext];
        NSLog(@"获取用户信息ext:%@",ext);
        
        if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row+2];
            [_delegate conversationListViewController:self didSelectConversationModel:model];
        }
        
    }
    
    [self tableViewDidTriggerHeaderRefresh];

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row+2];
        [[EaseMob sharedInstance].chatManager removeConversationByChatter:model.conversation.chatter deleteMessages:YES append2Chat:YES];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}

#pragma mark - data
- (void)tableViewDidTriggerHeaderRefresh
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
        NSDictionary *Newsinfo = [data objectInfoForKey:@"bulletininfo"];

        if (type == 1) {
            
            ws.systemBadgeStr = [NSString stringWithFormat:@"%@",messageinfo[@"messagecount"]];
            ws.systemDetailsStr = [NSString stringWithFormat:@"%@",messageinfo[@"message"]];
            
            ws.noticeBadgeStr = [NSString stringWithFormat:@"%@",Newsinfo[@"bulletincount"]];
            ws.noticeDetailsStr = [NSString stringWithFormat:@"%@",Newsinfo[@"bulletin"]];
            
            //                NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
            NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
            NSLog(@"获取聊天会话列表conversations:%@",conversations);
            
            NSArray* sorted = [conversations sortedArrayUsingComparator:
                               ^(EMConversation *obj1, EMConversation* obj2){
                                   EMMessage *message1 = [obj1 latestMessage];
                                   EMMessage *message2 = [obj2 latestMessage];
                                   if(message1.timestamp > message2.timestamp) {
                                       return(NSComparisonResult)NSOrderedAscending;
                                   }else {
                                       return(NSComparisonResult)NSOrderedDescending;
                                   }
                               }];
            
            [ws.dataArray removeAllObjects];
            
            // 添加顶部数据
            EaseConversationModel *topData1 = [[EaseConversationModel alloc] init];
            topData1.title = @"系统消息";
            topData1.detailsTitle = [self strTolerance:self.systemDetailsStr];
            topData1.avatarPic = @"system_messages.png";
            topData1.badgeStr = [self strTolerance:self.systemBadgeStr];
            [ws.dataArray addObject:topData1];
            
            EaseConversationModel *topData2 = [[EaseConversationModel alloc] init];
            topData2.title = @"公告";
            topData2.detailsTitle = [self strTolerance:self.noticeDetailsStr];
            topData2.avatarPic = @"system_bulletin.png";
            topData2.badgeStr = [self strTolerance:self.noticeBadgeStr];
            [ws.dataArray addObject:topData2];
            
            for (EMConversation *converstion in sorted) {
                
                NSLog(@"converstion.chatter:%@",converstion.chatter);
                
                EaseConversationModel *model = nil;
                if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
                    model = [_dataSource conversationListViewController:self
                                                   modelForConversation:converstion];
                }
                else{
                    model = [[EaseConversationModel alloc] initWithConversation:converstion];
                }
                
                if (model) {
                    [ws.dataArray addObject:model];
                }
                
            }
            
            [ws setupUnreadMessageCount];
            
            [ws tableViewDidFinishTriggerHeader:YES reload:YES];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self showTotasViewWithMes:@"网络连接失败"];
        
         [ws tableViewDidFinishTriggerHeader:NO reload:NO];
        
        NSLog(@"%@",error.debugDescription);
        
    }];
    
}

#pragma mark - IChatManagerDelegate 消息变化

// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{

    [self tableViewDidTriggerHeaderRefresh];
    
    [[self tableView] reloadData];
    
}

- (void)didFinishedReceiveOfflineMessages
{
    [self setupUnreadMessageCount];
    
    [[self tableView] reloadData];
    
}

#pragma mark - 小红点逻辑 Tab小红点 + App小红点
-(void)setupUnreadMessageCount
{
    
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = [self.systemBadgeStr integerValue] + [self.noticeBadgeStr integerValue];
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (unreadCount > 0) {

        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",(long)unreadCount];

    }else{
        self.tabBarItem.badgeValue = nil;
        
        [self hiddenMessCountInTabBar];
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    
    [self.tableView reloadData];
}

#pragma mark - registerNotifications

-(void)registerNotifications{
    
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [[EaseMob sharedInstance].callManager addDelegate:self delegateQueue:nil];

}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    [[EaseMob sharedInstance].callManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case eMessageBodyType_File: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}

#pragma mark - Delegate

// 收到消息回调
-(void)didReceiveMessage:(EMMessage *)message
{
    BOOL needShowNotification = YES;
    if (needShowNotification) {
#if !TARGET_IPHONE_SIMULATOR
        
        UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
#endif
    }
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(EMMessage *)message
{
    EMPushNotificationOptions *options = [[EaseMob sharedInstance].chatManager pushNotificationOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == ePushNotificationDisplayStyle_messageSummary) {
        id<IEMMessageBody> messageBody = [message.messageBodies firstObject];
        NSString *messageStr = nil;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Text:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case eMessageBodyType_Image:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case eMessageBodyType_Location:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case eMessageBodyType_Voice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case eMessageBodyType_Video:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        
        NSString *title = [message.ext objectStringForKey:@"nickName"];
        
        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
#warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.messageType] forKey:kMessageType];
    [userInfo setObject:message.conversationChatter forKey:kConversationChatter];
    notification.userInfo = userInfo;
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}


@end
