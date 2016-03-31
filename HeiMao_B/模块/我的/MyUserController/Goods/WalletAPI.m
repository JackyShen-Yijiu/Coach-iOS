//
//  WalletAPI.m
//  HeiMao_B
//
//  Created by ytzhang on 15/11/26.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "WalletAPI.h"
#import "JENetwoking.h"
#import "ToolHeader.h"
#import "WalletModel.h"


static NSString *const kMyWalletUrl = @"userinfo/getmywallet?userid=%@&usertype=1&seqindex=%@&count=10";

@implementation WalletAPI

- (void)getWalletNumbet
{
    
    NSString *url = [NSString stringWithFormat:kMyWalletUrl,[UserInfoModel defaultUserInfo].userID,@"0"];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        if (data == nil) {
            return ;
        }
        NSDictionary *dic = [data objectForKey:@"data"];
        
        NSLog(@"testData  = %@",dic);
        WalletModel *walletModel = [[WalletModel alloc] init];
        walletModel.walletNumber = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wallet"]];
//        NSLog(@" walletModel.walletNumber = %@", walletModel.walletNumber);
        
    }];
    
}

- (void)refreshWalletNumbet
{
    [self getWalletNumbet];
}





#pragma mark ----- 初始化单例对象
static id instanceWalletAPI = nil;

+ (instancetype)getInstanceWalletAPI
{
    @synchronized(self){
        if (!instanceWalletAPI) {
            instanceWalletAPI = [[self alloc] init];
        }
    }
    
    return instanceWalletAPI;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!instanceWalletAPI) {
            instanceWalletAPI = [super allocWithZone:zone];
        }
    }
    
    return instanceWalletAPI;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
