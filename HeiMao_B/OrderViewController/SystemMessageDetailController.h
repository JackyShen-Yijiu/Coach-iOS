//
//  SystemMessageDetailController.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SystemMessageDetailControllerDelegate <NSObject>

- (void)SystemMessageDetailControllerGetMessagelastmessage:(NSString *)lastmessage;
@end

@interface SystemMessageDetailController : UIViewController

@property (nonatomic,weak)id<SystemMessageDetailControllerDelegate>delegate;

@end
