//
//  WalletModel.m
//  HeiMao_B
//
//  Created by ytzhang on 15/11/26.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "WalletModel.h"

@implementation WalletModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
#pragma mark ----- 初始化单例对象
static id instanceWalletModel = nil;

+ (instancetype)getInstanceWalletModel
{
    @synchronized(self){
        if (!instanceWalletModel) {
            instanceWalletModel = [[self alloc] init];
        }
    }
    
    return instanceWalletModel;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!instanceWalletModel) {
            instanceWalletModel = [super allocWithZone:zone];
        }
    }
    
    return instanceWalletModel;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return self;
}


@end
