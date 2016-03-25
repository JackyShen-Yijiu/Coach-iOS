//
//  HMSubjectModel.m
//  HeiMao_B
//
//  Created by kequ on 16/1/12.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "HMSubjectModel.h"

@implementation HMSubjectModel

+ (HMSubjectModel *)converJsonDicToModel:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMSubjectModel * model = [[HMSubjectModel alloc] init];
    model.subjectId = [[dic objectForKey:@"subjectid"] integerValue];
    model.subJectName = [dic objectStringForKey:@"name"];
    return model;
}
@end
