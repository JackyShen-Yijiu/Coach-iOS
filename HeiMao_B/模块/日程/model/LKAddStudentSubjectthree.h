#import <UIKit/UIKit.h>

@interface LKAddStudentSubjectthree : NSObject

@property (nonatomic, assign) NSInteger buycoursecount;
@property (nonatomic, assign) NSInteger finishcourse;
@property (nonatomic, assign) NSInteger missingcourse;
@property (nonatomic, assign) NSInteger officialfinishhours;
@property (nonatomic, assign) NSInteger officialhours;
@property (nonatomic, strong) NSString * progress;
@property (nonatomic, assign) NSInteger reservation;
@property (nonatomic, strong) NSString * reservationid;
@property (nonatomic, assign) NSInteger totalcourse;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end