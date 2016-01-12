//
//  HMSubjectModel.h
//  HeiMao_B
//
//  Created by kequ on 16/1/12.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSubjectModel : NSObject
@property(nonatomic,assign)NSInteger subjectId;
@property(nonatomic,strong)NSString * subJectName;

+ (HMSubjectModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
