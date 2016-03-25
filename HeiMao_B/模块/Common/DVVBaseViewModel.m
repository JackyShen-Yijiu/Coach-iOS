//
//  DVVBaseViewModel.m
//  LuckyKing
//
//  Created by 大威 on 16/1/3.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "DVVBaseViewModel.h"

@interface DVVBaseViewModel()

@property (nonatomic, copy) DVVBaseViewModelUpdataBlock refreshSuccessBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock refreshErrorBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock loadMoreSuccessBlock;
@property (nonatomic, copy) DVVBaseViewModelUpdataBlock loadMoreErrorBlock;
@property (nonatomic, copy) DVVBaseViewModelBlock nilResponseObjectBlock;
@property (nonatomic, copy) DVVBaseViewModelBlock networkErrorBlock;
@property (nonatomic, copy) dispatch_block_t networkCallBackBlock;

@end

@implementation DVVBaseViewModel

- (void)dvvNetworkRequestRefresh {
    // 重写此方法刷新数据（需自己调用刷新回调）
}
- (void)dvvNetworkRequestLoadMore {
    // 重写此方法加载数据（需自己调用加载回调）
}
- (void)dvvNetworkRequestWithIndex:(NSUInteger)index
                         isRefresh:(BOOL)isRefresh {
    
}
- (BOOL)dvvCheckError:(id)responseObject {
    
    // 重写此方法检测服务器是否返回了数据
    return NO;
}

#pragma mark - call back
- (void)dvvRefreshSuccess {
    if (_refreshSuccessBlock) {
        _refreshSuccessBlock();
    }
}
- (void)dvvRefreshError {
    if (_refreshErrorBlock) {
        _refreshErrorBlock();
    }
}
- (void)dvvLoadMoreSuccess {
    if (_loadMoreSuccessBlock) {
        _loadMoreSuccessBlock();
    }
}
- (void)dvvLoadMoreError {
    if (_loadMoreErrorBlock) {
        _loadMoreErrorBlock();
    }
}
- (void)dvvNilResponseObject {
    if (_nilResponseObjectBlock) {
        _nilResponseObjectBlock();
    }
}
- (void)dvvNetworkError {
    if (_networkErrorBlock) {
        _networkErrorBlock();
    }
}
- (void)dvvNetworkCallBack {
    if (_networkCallBackBlock) {
        _networkCallBackBlock();
    }
}

#pragma mark - set block
- (void)dvvSetRefreshSuccessBlock:(DVVBaseViewModelUpdataBlock)refreshSuccessBlock {
    _refreshSuccessBlock = refreshSuccessBlock;
}
- (void)dvvSetRefreshErrorBlock:(DVVBaseViewModelUpdataBlock)refreshErrorBlock {
    _refreshErrorBlock = refreshErrorBlock;
}
- (void)dvvSetLoadMoreSuccessBlock:(DVVBaseViewModelUpdataBlock)loadMoreSuccessBlock {
    _loadMoreSuccessBlock = loadMoreSuccessBlock;
}
- (void)dvvSetLoadMoreErrorBlock:(DVVBaseViewModelUpdataBlock)loadMoreErrorBlock {
    _loadMoreErrorBlock = loadMoreErrorBlock;
}
- (void)dvvSetNilResponseObjectBlock:(DVVBaseViewModelBlock)nilResponseObjectBlock {
    _nilResponseObjectBlock = nilResponseObjectBlock;
}
- (void)dvvSetNetworkErrorBlock:(DVVBaseViewModelBlock)netwrokErrorBlock {
    _networkErrorBlock = netwrokErrorBlock;
}
- (void)dvvSetNetworkCallBackBlock:(dispatch_block_t)handle {
    _networkCallBackBlock = handle;
}

#pragma mark 检测是否有数据
- (BOOL)checkErrorWithData:(id)data {
    
    if (!data) {
        return YES;
    }
    NSDictionary *dict = data;
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (![[dict objectForKey:@"type"] integerValue]) {
        return YES;
    }
    if (![[dict objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
        return YES;
    }
    NSArray *array = [dict objectForKey:@"data"];
    if (!array.count) {
        return YES;
    }
    
    return NO;
}

@end
