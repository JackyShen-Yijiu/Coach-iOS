//
//  YBSubjectMoel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBSubjectMoel : NSObject
/*
 "subject":
 
 {
 "subjectid": 2,
 "name": "科目二"
 },
 */
@property (nonatomic, assign) NSNumber *subjectid;
@property (nonatomic, strong) NSString *name;
+ (YBSubjectMoel *)converJsonDicToModel:(NSDictionary *)dic;
@end
