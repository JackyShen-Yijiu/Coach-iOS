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

@end

@implementation DVVBaseViewModel

- (void)dvvNetworkRequestRefresh {
    // 重写此方法刷新数据（需自己调用刷新回调）
}
- (void)dvvNetworkRequestLoadMore {
    // 重写此方法加载数据（需自己调用加载回调）
}
- (BOOL)dvvCheckErrorWithResponseObject:(id)responseObject {
    
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

@end
