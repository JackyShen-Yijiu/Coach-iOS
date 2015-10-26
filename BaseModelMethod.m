//
//  BaseModelMethod.m
//  JewelryApp
//
//  Created by kequ on 15/5/17.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "BaseModelMethod.h"
#import "HMOrderModel.h"

@implementation BaseModelMethod



+ (NSArray *)getOrderListArrayFormDicInfo:(NSArray *)array
{
    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0;i < 20;i++) {
        HMOrderModel * orderModel = [HMOrderModel converJsonDicToModel:nil];
        if (orderModel) {
            [oArray addObject:orderModel];
        }
    }
    return [oArray copy];

//    if (![array isKindOfClass:[NSArray class]] || !array.count) {
//        return nil;
//    }
//    NSMutableArray * oArray = [NSMutableArray arrayWithCapacity:0];
//    for (NSDictionary * info in array) {
//        HMOrderModel * orderModel = [HMOrderModel converJsonDicToModel:info];
//        if (orderModel) {
//            [oArray addObject:orderModel];
//        }
//    }
//    return [oArray copy];
}
@end
