//
//  CoureseRatingController.h
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMStudentModel.h"


@class CoureseRatingController;
@protocol CoureseRatingControllerDelegate <NSObject>
- (void)coureseRatingControllerDidOpeartionSucess:(CoureseRatingController *)controller;
@end

@interface CoureseRatingController : UIViewController
@property(nonatomic,weak)id<CoureseRatingControllerDelegate>delegate;
@property(nonatomic,strong)NSString * courseId;
@property(nonatomic,assign)HMStudentModel * studentModel;
@end
