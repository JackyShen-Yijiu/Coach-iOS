//
//  StudentListModel.h
//  HeiMao_B
//
//  Created by bestseller on 15/11/19.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentListModel : NSObject
/*
 "_id": "563df526086f564d26bfe552",
 "mobile": "18444444009",
 "name": "习大大一号",
 "headportrait": {
 "originalpic": "",
 "thumbnailpic": "",
 "width": "",
 "height": ""
 },
 "subject": {
 "subjectid": 4,
 "name": "科目四"
 },
 "subjectprocess": ""
 */
@property (strong, nonatomic) NSString *infoId;
@property (strong, nonatomic) NSString *mobile;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary *headportrait;
@property (strong, nonatomic) NSDictionary *subject;
@property (strong, nonatomic) NSString *subjectprocess;
@end
