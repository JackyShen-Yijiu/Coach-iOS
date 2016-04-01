#import <UIKit/UIKit.h>

@interface JZExamSummaryInfoData : NSObject

@property (nonatomic, strong) NSString * examdate;
@property (nonatomic, assign) NSInteger missexamstudent;
@property (nonatomic, assign) NSInteger nopassstudent;
@property (nonatomic, assign) NSInteger passrate;
@property (nonatomic, assign) NSInteger passstudent;
@property (nonatomic, assign) NSInteger studentcount;
@property (nonatomic, strong) NSString * subject;
/** 用来标识当前组是否打开或关闭 */
@property (nonatomic, assign, getter=isOpenGroup) BOOL openGroup;
@end