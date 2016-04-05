//
//	JZUserid.h
//
//	Create by ytzhang on 31/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZHeadportrait.h"

@interface JZUserid : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) JZHeadportrait * headportrait;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end