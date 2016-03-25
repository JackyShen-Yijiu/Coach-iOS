//
//  CourseTimeModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/23.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "CourseTimeModel.h"
#import <MTLValueTransformer.h>
@implementation CourseTimeModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"begintime":@"begintime",@"endtime":@"endtime",@"timeid":@"timeid",@"timespace":@"timespace"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
- (NSInteger)numMark {
    NSUInteger lenth = self.begintime.length;
    NSUInteger lastLenth = lenth-3;
    NSString *resultString = [self.begintime substringWithRange:NSMakeRange(0, lastLenth)];
    return resultString.integerValue;
}
@end
