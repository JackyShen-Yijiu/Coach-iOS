//
//  AppointmentCoachTimeInfoModel.m
//  BlackCat
//
//  Created by bestseller on 15/10/23.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "AppointmentCoachTimeInfoModel.h"

@implementation AppointmentCoachTimeInfoModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"infoId":@"_id",@"coachid":@"coachid",@"coursedate":@"coursedate",@"coursestudentcount":@"coursestudentcount",@"coursetime":@"coursetime",@"courseuser":@"courseuser",@"createtime":@"createtime",@"selectedstudentcount":@"selectedstudentcount",@"signinstudentcount":@"signinstudentcount"};
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    return self;
}
- (NSInteger)indexPath {
    NSArray *indexArray= [self.coursetime.begintime componentsSeparatedByString:@":"];
    NSString *indexString = indexArray.firstObject;
    return indexString.integerValue;
}

@end
