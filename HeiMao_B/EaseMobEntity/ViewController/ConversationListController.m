//
//  ConversationListController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ConversationListController.h"
#import "EaseMob.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"
#import "UIViewController+HUD.h"
#import "ChatViewController.h"
#import "EMConversation.h"
#import "EMConversation.h"
#import "JGUserTools.h"
#import "JGvalidationView.h"
#import "WMUITool.h"
#import "DVVSendMessageToStudentController.h"


@interface ConversationListController ()<EaseConversationListViewControllerDelegate,
                                        EaseConversationListViewControllerDataSource,
                                        EMChatManagerDelegate>
@property (strong, nonatomic) UIButton *naviBarRightButton;

@property (nonatomic, strong) UIView *networkStateView;

@property (nonatomic,strong)JGvalidationView*bgView;

@end

@implementation ConversationListController



- (void)viewDidLoad {
    [super viewDidLoad];
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self networkStateView];
    [self removeEmptyConversationsFromDB];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needRefresh) name:KCourseViewController_NeedRefresh object:nil];

}

- (void)needRefresh
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initNavBar];
    
    [_bgView removeFromSuperview];
    if ([UserInfoModel defaultUserInfo].userID && [UserInfoModel defaultUserInfo].is_validation==NO) {
        _bgView = [[JGvalidationView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 80)];
        [self.view addSubview:_bgView];
        return;
    }
}


- (void)setUpRightNavBar
{
    self.myNavigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"群发短信" highTitle:@"群发短信" target:self action:@selector(clickRight) isRightItem:YES];
}

#pragma mark - initUI

- (void)initNavBar
{
    [self resetNavBar];
    
     self.myNavigationItem.title = @"消息";
    
    [self setUpRightNavBar];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}
#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
            
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
            chatController.title = [NSString stringWithFormat:@"%@",[JGUserTools getNickNameByEMUserName:conversation.chatter]];
            [self.myNavController pushViewController:chatController animated:YES];
            
        }
    }
}

#pragma mark - EaseConversationListViewControllerDataSource

// 读取回话列表后，通过代理处理回话
- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    if (conversation.conversationType == eConversationTypeChat) {
        //单聊会话
        long long time = [[NSDate date] timeIntervalSince1970] * 1000;
        EMMessage * moreMessage = [[conversation loadNumbersOfMessages:1 before:time] lastObject];
        [self fixModelInfo:conversation MessageModelInfo:moreMessage];
    }
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    return model;
}

- (void)fixModelInfo:(EMConversation *)convModel MessageModelInfo:(EMMessage *)messModel
{
    NSString * fromId = [messModel from];
    if ([fromId isEqualToString:[[UserInfoModel defaultUserInfo] userID]]) {
        convModel.ext = [[UserInfoModel defaultUserInfo] messageExt];
    }else{
        convModel.ext = [[messModel ext] copy];
    }
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
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
                // 表情映射。
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

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }

    
    return latestMessageTime;
}

#pragma mark - public
-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}
- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

- (void)clickRight{
            DVVSendMessageToStudentController *sendMsgVC = [DVVSendMessageToStudentController new];
            [self.navigationController pushViewController:sendMsgVC animated:YES];
}


@end
