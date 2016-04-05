#import <UIKit/UIKit.h>

@interface LKAddStudentSubject : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger subjectid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end