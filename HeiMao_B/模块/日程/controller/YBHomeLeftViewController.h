//
//  YBHomeLeftViewController.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGBaseViewController.h"
#import "FDCalendar.h"

@interface YBHomeLeftViewController : JGBaseViewController

- (void)modifyVacation:(NSDate *)date;

- (void)hiddenOpenCalendar;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
