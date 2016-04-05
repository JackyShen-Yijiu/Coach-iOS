//
//  PersonlizeModel.h
//  HeiMao_B
//
//  Created by 胡东苑 on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonlizeModel : NSObject

@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *tagtype;
@property (nonatomic, strong) NSString *tagname;
@property (nonatomic, strong) NSString *is_audit;
@property (nonatomic, strong) NSString *is_choose;
@property (nonatomic, strong) NSString *color;

+ (PersonlizeModel *)converJsonDicToModel:(NSDictionary *)dic;

@end
