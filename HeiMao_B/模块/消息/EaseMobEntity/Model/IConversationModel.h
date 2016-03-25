//
//  IConversationModel.h
//  ChatDemo-UI3.0
//
//  Created by dhc on 15/6/25.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class EMConversation;
@protocol IConversationModel <NSObject>

@property (strong, nonatomic, readonly) EMConversation *conversation;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *avatarURLPath;
@property (strong, nonatomic) UIImage * avatarImage;
//@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) NSString * type; //1表示学员，2表示教练

- (instancetype)initWithConversation:(EMConversation *)conversation;

@end
