//
//  JGSubjectthreeModel.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGSubjectthreeModel : NSObject
@property(nonatomic,assign)NSInteger finishcourse;
@property(nonatomic,assign)NSInteger missingcourse;
@property(nonatomic,strong)NSString * progress;
@property(nonatomic,assign)NSInteger reservation;
@property(nonatomic,assign)NSInteger totalcourse;
+ (JGSubjectthreeModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
