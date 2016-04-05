//
//	JZPassListUserid.h
//
//	Create by ytzhang on 1/4/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZPassListHeadportrait.h"

@interface JZPassListUserid : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) JZPassListHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end