//
//  JGBaseViewController.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/1/22.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGBaseViewController : UIViewController
- (void)loadMessageData;

//@property (nonatomic,copy)NSString *systemBadgeStr;
//
//@property (nonatomic,copy)NSString *noticeBadgeStr;
//
//@property (nonatomic,copy)NSString *newsBadgeStr;


// 系统消息
@property (nonatomic,copy)NSString *systemBadgeStr;
@property (nonatomic,copy)NSString *systemDetailsStr;
@property (nonatomic,copy)NSString *systemTimeStr;

// 公告
@property (nonatomic,copy)NSString *noticeBadgeStr;
@property (nonatomic,copy)NSString *noticeDetailsStr;
@property (nonatomic,copy)NSString *noticeTimeStr;

// 资讯
@property (nonatomic,copy)NSString *newsBadgeStr;
@property (nonatomic,copy)NSString *newsDetailsStr;
@property (nonatomic,copy)NSString *newsTimeStr;

@end
