//
//  JZHomeStudentViewModel.h
//  
//
//  Created by ytzhang on 16/3/29.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+DVVBaseViewModel.h"

@interface JZHomeStudentViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *coachid;

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *subjectid;
@property (nonatomic, strong) NSString *studentState;

- (void)dvv_networkRequestRefreshwithSubjectID:(NSString *)subjectid withStudentState:(NSString *)studentState;
- (void)dvv_networkRequestLoadMorewithSubjectID:(NSString *)subjectid withStudentState:(NSString *)studentState;
@end
