//
//  WorkTypeListController.h
//  HeiMao_B
//
//  Created by kequ on 16/1/11.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkTypeModel.h"

@class WorkTypeListController;
@protocol WorkTypeListControllerDelegate <NSObject>
- (void)workTypeListController:(WorkTypeListController*)controller didSeletedWorkType:(KCourseWorkType)type workName:(NSString *)name;
@end
@interface WorkTypeListController : UIViewController
@property(nonatomic,weak)id<WorkTypeListControllerDelegate>delegate;
@end
