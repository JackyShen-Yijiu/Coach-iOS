//
//  EaseConversationModel.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IConversationModel.h"

@interface EaseConversationModel : NSObject<IConversationModel>

@property (strong, nonatomic, readonly) EMConversation *conversation;

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *avatarURLPath;
@property (strong, nonatomic) UIImage *avatarImage;
//@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) NSString * type; //1表示学员，2表示教练
- (instancetype)initWithConversation:(EMConversation *)conversation;


@property (copy, nonatomic) NSString *detailsTitle;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *avatarPic;
@property (copy, nonatomic) NSString *badgeStr;

@end
