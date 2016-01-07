//
//  WalletAPI.h
//  HeiMao_B
//
//  Created by ytzhang on 15/11/26.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletAPI : NSObject
@property (nonatomic,strong) NSString *walletStr;

+ (instancetype)getInstanceWalletAPI; // 单例对象
- (void)getWalletNumbet; // 得到我的积分数

/**
 *
 *  刷新钱包数据
 *
 */

- (void)refreshWalletNumbet;
@end
