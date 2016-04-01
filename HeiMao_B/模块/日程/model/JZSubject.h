//
//	JZSubject.h
//
//	Create by ytzhang on 31/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface JZSubject : NSObject

@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger subjectid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end