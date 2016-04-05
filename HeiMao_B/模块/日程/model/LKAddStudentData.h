#import <UIKit/UIKit.h>
#import "LKAddStudentHeadportrait.h"
#import "LKAddStudentSubject.h"
#import "LKAddStudentSubjectthree.h"
#import "LKAddStudentSubjectthree.h"

@interface LKAddStudentData : NSObject
/*
 {
 headportrait =             {
 height = "";
 originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/20151119/113554430-564229d81eb4017436ade69e.png";
 thumbnailpic = "";
 width
 
 */
@property (nonatomic, strong) LKAddStudentHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) LKAddStudentSubject * subject;
@property (nonatomic, strong) LKAddStudentSubjectthree * subjectthree;
@property (nonatomic, strong) LKAddStudentSubjectthree * subjecttwo;
@property (nonatomic, strong) NSString * userid;

@property (nonatomic,assign) BOOL isSelect;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end