//
//  AppointmentCoachTimeInfoModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/23.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
#import "CourseTimeModel.h"

@interface AppointmentCoachTimeInfoModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *infoId;
@property (copy, nonatomic, readonly) NSString *coachid;
@property (copy, nonatomic, readonly) NSString *coursedate;
@property (strong, nonatomic, readonly) NSNumber *coursestudentcount;
@property (strong, nonatomic, readonly) CourseTimeModel *coursetime;
@property (strong, nonatomic, readonly) NSArray *courseuser;
@property (copy, nonatomic, readonly) NSString *createtime;
@property (strong, nonatomic, readonly) NSNumber *selectedstudentcount;
@property (assign, nonatomic, readwrite) NSInteger indexPath;
@property (assign, nonatomic, readwrite) BOOL is_selected;
@property (strong, nonatomic, readonly) NSNumber *signinstudentcount;
@end
