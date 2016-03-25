//
//  EaseConversationModel.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import "EaseConversationModel.h"
#import "EMConversation.h"

@implementation EaseConversationModel

- (instancetype)initWithConversation:(EMConversation *)conversation
{
    self = [super init];
    if (self) {
        _conversation = conversation;
        if (conversation.conversationType == eConversationTypeChat) {
            self.avatarURLPath = [conversation.ext objectStringForKey:@"headUrl"];
            self.title = [[conversation ext] objectStringForKey:@"nickName"];
            self.type = [[conversation ext] objectStringForKey:@"userType"];
            self.avatarImage = [UIImage imageNamed:@"user"];
        }
    }
    return self;
}

@end
