//
//	Applyclasstypeinfo.h
//
//	Create by ytzhang on 29/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface Applyclasstypeinfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger onsaleprice;
@property (nonatomic, assign) NSInteger price;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end