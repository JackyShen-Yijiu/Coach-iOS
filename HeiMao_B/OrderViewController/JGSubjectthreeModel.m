//
//  JGSubjectthreeModel.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGSubjectthreeModel.h"

@implementation JGSubjectthreeModel
+ (JGSubjectthreeModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    JGSubjectthreeModel * model = [[JGSubjectthreeModel alloc] init];
    model.finishcourse = [[dic objectStringForKey:@"finishcourse"] integerValue];
    model.missingcourse = [[dic objectStringForKey:@"missingcourse"] integerValue];
    model.progress = [dic objectStringForKey:@"progress"];
    model.reservation = [[dic objectStringForKey:@"reservation"] integerValue];
    model.totalcourse = [[dic objectStringForKey:@"totalcourse"] integerValue];
    return model;
}
@end
