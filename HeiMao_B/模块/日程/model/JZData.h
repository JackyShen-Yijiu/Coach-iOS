//
//	JZData.h
//
//	Create by ytzhang on 31/3/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "JZSubject.h"
#import "JZUserid.h"

@interface JZData : NSObject

@property (nonatomic, strong) NSString * _id;
@property (nonatomic, strong) NSString * begintime;
@property (nonatomic, strong) NSString * endtime;
@property (nonatomic, strong) NSString * reservationcreatetime;
@property (nonatomic, strong) NSString * reservationstate;
@property (nonatomic, strong) JZSubject * subject;
@property (nonatomic, strong) JZUserid * userid;

@property (nonatomic,assign) BOOL isOpen;

@end