#import <UIKit/UIKit.h>
#import "JZExamStudentListUserid.h"

@interface JZExamStudentListData : NSObject

@property (nonatomic, strong) NSString * idField;
/// 3漏考 4 没有通过 5 通过
@property (nonatomic, strong) NSString * examinationdate;
@property (nonatomic, strong) NSString * examinationstate;
/// 成绩
@property (nonatomic, strong) NSString * score;
/// 学员id :   idField  headportrait--originalpic  name
@property (nonatomic, strong) JZExamStudentListUserid * userid;
@end


