#import <UIKit/UIKit.h>

@interface LKAddStudentHeadportrait : NSObject

@property (nonatomic, strong) NSString * height;
@property (nonatomic, strong) NSString * originalpic;
@property (nonatomic, strong) NSString * thumbnailpic;
@property (nonatomic, strong) NSString * width;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end