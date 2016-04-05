//
//  SystemMessageModelRootClass.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/14.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "SystemMessageModelRootClass.h"
#import "SystemMessageModel.h"

@implementation SystemMessageModelRootClass

- (instancetype)initWithJsonDict:(id)dictionary {
    self = [super init];
    if (self) {
        NSDictionary *dict = [[NSDictionary alloc] initWithDictionary:dictionary];
        NSArray *array = [dict objectArrayForKey:@"data"];
        NSMutableArray *marray = [NSMutableArray array];
        for (int i = 0; i < array.count; i++) {
            SystemMessageModel *messageModel = [[SystemMessageModel alloc] initWithDictionary:[array objectAtIndex:i]];
            [marray addObject:messageModel];
        }
        _data = marray;
    }
    return self;
}

@end
