//
//	JZPassListData.h
//
//	Create by ytzhang on 1/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZPassListUserid.h"

@interface JZPassListData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * examinationdate;
@property (nonatomic, assign) NSInteger examinationstate;
@property (nonatomic, strong) JZPassListUserid * userid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end