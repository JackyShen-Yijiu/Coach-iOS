#import <UIKit/UIKit.h>
#import "LKAddStudentHeadportrait.h"
#import "LKAddStudentSubject.h"
#import "LKAddStudentSubjectthree.h"
#import "LKAddStudentSubjectthree.h"

@interface LKAddStudentData : NSObject

@property (nonatomic, strong) LKAddStudentHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) LKAddStudentSubject * subject;
@property (nonatomic, strong) LKAddStudentSubjectthree * subjectthree;
@property (nonatomic, strong) LKAddStudentSubjectthree * subjecttwo;
@property (nonatomic, strong) NSString * userid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end