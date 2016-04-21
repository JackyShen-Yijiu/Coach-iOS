//
//  JZBulletinController.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JZBulletinControllerDelegate <NSObject>

- (void)JZBulletinControllerGetLastBulletin:(NSString *)lastBulletin;
@end
@interface JZBulletinController : UIViewController
@property (nonatomic,weak)id<JZBulletinControllerDelegate>delegate;

@end
