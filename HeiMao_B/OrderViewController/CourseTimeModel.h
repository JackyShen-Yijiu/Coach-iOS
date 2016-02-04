//
//  CourseTimeModel.h
//  BlackCat
//
//  Created by bestseller on 15/10/23.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>
@interface CourseTimeModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic, readonly) NSString *begintime;
@property (copy, nonatomic, readonly) NSString *endtime;
@property (strong, nonatomic, readonly) NSNumber *timeid;
@property (copy, nonatomic, readonly) NSString *timespace;
@property (assign, nonatomic, readwrite) NSInteger numMark;
@end
