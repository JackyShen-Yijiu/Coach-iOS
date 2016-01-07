//
//  OrderCompleteViewController.h
//  HeiMao_B
//
//  Created by kequ on 15/12/17.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMCourseModel.h"

@class OrderCompleteViewController;
@protocol OrderCompleteViewControllerDelegate <NSObject>
- (void)orderCompleteViewControllerDidEnsutreSucess:(OrderCompleteViewController *)controller :(BOOL)isGotoRecomend;
@end
@interface OrderCompleteViewController : UIViewController
@property(nonatomic,strong)HMCourseModel * courseModel;
@property(nonatomic,weak)id<OrderCompleteViewControllerDelegate>delegate;
@end
