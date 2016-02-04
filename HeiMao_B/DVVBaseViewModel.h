//
//  DVVBaseViewModel.h
//  LuckyKing
//
//  Created by 大威 on 16/1/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DVVBaseViewModelBlock)();
typedef void(^DVVBaseViewModelUpdataBlock)();

@interface DVVBaseViewModel : NSObject

- (BOOL)checkErrorWithData:(id)data;

// 处理完网络数据后，调用刷新成功、失败的回调
- (void)dvvRefreshSuccess;
- (void)dvvRefreshError;
// 处理完网络数据后，调用加载成功、失败的回调
- (void)dvvLoadMoreSuccess;
- (void)dvvLoadMoreError;
// 检测完服务器返回的数据为空时的回调
- (void)dvvNilResponseObject;
// 网络加载失败的回调
- (void)dvvNetworkError;
// 成功或失败都调用的回调
- (void)dvvNetworkCallBack;

// 设置刷新成功、失败时的回调Block
- (void)dvvSetRefreshSuccessBlock:(DVVBaseViewModelUpdataBlock)refreshSuccessBlock;
- (void)dvvSetRefreshErrorBlock:(DVVBaseViewModelUpdataBlock)refreshErrorBlock;
// 设置加载成功、失败时的回调Block
- (void)dvvSetLoadMoreSuccessBlock:(DVVBaseViewModelUpdataBlock)loadMoreSuccessBlock;
- (void)dvvSetLoadMoreErrorBlock:(DVVBaseViewModelUpdataBlock)loadMoreErrorBlock;
// 设置服务器返回的数据为空时的回调Block
- (void)dvvSetNilResponseObjectBlock:(DVVBaseViewModelBlock)nilResponseObjectBlock;
// 设置网络加载失败的回调Block
- (void)dvvSetNetworkErrorBlock:(DVVBaseViewModelBlock)netwrokErrorBlock;
// 设置成功或失败都调用的回调Block
- (void)dvvSetNetworkCallBackBlock:(dispatch_block_t)handle;

// 1、刷新时的网络请求
- (void)dvvNetworkRequestRefresh;
// 2、加载时的网络请求
- (void)dvvNetworkRequestLoadMore;

- (void)dvvNetworkRequestWithIndex:(NSUInteger)index
                         isRefresh:(BOOL)isRefresh;

// 检测服务器返回的数据
- (BOOL)dvvCheckError:(id)responseObject;

@end
