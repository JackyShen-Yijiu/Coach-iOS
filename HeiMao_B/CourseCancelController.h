//
//  CourseCancelController.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KControllType) {
    KControllTypeReject,
    KControllTypeCancel
};

@class CourseCancelController;
@protocol CourseCancelControllerDelegate <NSObject>
- (void)courseCancelControllerDidOpeartionSucess:(CourseCancelController *)controller;
@end

@interface CourseCancelController : UIViewController
@property(nonatomic,weak)id<CourseCancelControllerDelegate>delegate;
@property(nonatomic,assign)KControllType controllerType;
@property(nonatomic,strong)NSString * courseId;
@end
