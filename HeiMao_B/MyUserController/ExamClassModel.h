//
//  ExamClassModel.h
//  HeiMao_B
//
//  Created by bestseller on 15/11/17.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamClassModel : NSObject
//"classid": "563353d2348813ac315be714",
//"classname": "海淀暑假班",
//"price": 4700,
//"onsaleprice": 4700,
//"address": "",
@property (copy, nonatomic) NSString *classid;
@property (copy, nonatomic) NSString *classname;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *onsaleprice;
@property (copy, nonatomic) NSString *address;
@property (strong, nonatomic) NSArray *vipserverlist;
@property (assign, nonatomic) BOOL is_choose;
@end
