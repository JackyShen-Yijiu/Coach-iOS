//
//  OrderDetailViewController.h
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMCourseModel.h"

@interface CourseDetailViewController : UIViewController
@property(nonatomic,strong)NSString * couresID;
@property(nonatomic,strong)HMCourseModel * model; //测试接口
@end
