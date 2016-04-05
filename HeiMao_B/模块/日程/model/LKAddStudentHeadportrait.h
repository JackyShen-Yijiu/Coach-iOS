#import <UIKit/UIKit.h>

@interface LKAddStudentHeadportrait : NSObject
/*
 {
 headportrait =             {
 height = "";
 originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/20151119/113554430-564229d81eb4017436ade69e.png";
 thumbnailpic = "";
 width
 
 */

@property (nonatomic, strong) NSString * height;
@property (nonatomic, strong) NSString * originalpic;
@property (nonatomic, strong) NSString * thumbnailpic;
@property (nonatomic, strong) NSString * width;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end