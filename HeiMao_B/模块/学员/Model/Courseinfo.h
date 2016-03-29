//
//	Courseinfo.h
//
//	Create by ytzhang on 29/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Courseinfo : NSObject

@property (nonatomic, assign) NSInteger buycoursecount;
@property (nonatomic, assign) NSInteger finishcourse;
@property (nonatomic, assign) NSInteger missingcourse;
@property (nonatomic, assign) NSInteger officialfinishhours;
@property (nonatomic, assign) NSInteger officialhours;
@property (nonatomic, strong) NSString * progress;
@property (nonatomic, assign) NSInteger reservation;
@property (nonatomic, assign) NSInteger totalcourse;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end