//
//  InformationMessageController.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InformationMessageControllerDelegate <NSObject>

- (void)InformationMessageControllerGetMessageLastnews:(NSString *)lastnews;

@end

@interface InformationMessageController : UIViewController

@property (nonatomic,weak)id<InformationMessageControllerDelegate>delegate;

@end
