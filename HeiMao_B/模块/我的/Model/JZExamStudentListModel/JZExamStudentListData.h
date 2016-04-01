#import <UIKit/UIKit.h>
#import "JZExamStudentListUserid.h"

@interface JZExamStudentListData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * examinationdate;
@property (nonatomic, strong) NSString * examinationstate;
@property (nonatomic, strong) NSString * score;
@property (nonatomic, strong) JZExamStudentListUserid * userid;
@end