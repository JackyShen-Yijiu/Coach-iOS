//
//  BLInformationManager.m
//  BlackCat
//
//  Created by bestseller on 15/10/22.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "BLInformationManager.h"

@interface BLInformationManager ()
@end
@implementation BLInformationManager

- (NSMutableArray *)appointmentUserData
{
    if (_appointmentUserData == nil) {
        _appointmentUserData = [NSMutableArray array];
    }
    return _appointmentUserData;
}

+ (BLInformationManager *)sharedInstance {
    
    static BLInformationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

@end
