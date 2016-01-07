//
//  WalletModel.h
//  HeiMao_B
//
//  Created by ytzhang on 15/11/26.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletModel : NSObject
@property (nonatomic,strong) NSString *walletNumber;

+ (instancetype)getInstanceWalletModel;
@end
