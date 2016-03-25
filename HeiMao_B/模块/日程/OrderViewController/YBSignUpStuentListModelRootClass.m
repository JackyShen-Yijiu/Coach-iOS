//
//  YBSignUpStuentListModelRootClass.m
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBSignUpStuentListModelRootClass.h"
#import "YBSignUpStuentListModel.h"

@implementation YBSignUpStuentListModelRootClass
- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            YBSignUpStuentListModel *messageModel = [[YBSignUpStuentListModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:messageModel];
        }
        _data = marray;
    }
    return self;
}

@end
