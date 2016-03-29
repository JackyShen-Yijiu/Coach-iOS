//
//  NSObject+DVVBaseViewModel.m
//  DVVTestBaseViewModel
//
//  Created by 大威 on 16/2/5.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import "NSObject+DVVBaseViewModel.h"
#import <objc/runtime.h>

@implementation NSObject (DVVBaseViewModel)


static char dvv_kNetworkCallBackBlock;
static char dvv_kNetworkErrorBlock;
static char dvv_kNilResponseObjectBlock;

static char dvv_kRefreshSuccessBlock;
static char dvv_kRefreshErrorBlock;

static char dvv_kLoadMoreSuccessBlock;
static char dvv_kLoadMoreErrorBlock;


- (void)dvv_networkRequestRefresh {
    // 重写此方法 刷新数据（需自己调用刷新回调）
}

- (void)dvv_networkRequestLoadMore {
    // 重写此方法 加载数据（需自己调用加载回调）
}

- (void)dvv_networkRequestWithIndex:(NSUInteger)index
                          isRefresh:(BOOL)isRefresh {
    // 重写此方法 根据第几页和是否是刷新状态来处理数据（需自己调用回调）
}

- (BOOL)dvv_checkResponseObject:(id)responseObject {
    // 重写此方法 检测服务器返回的数据
    return NO;
}


#pragma mark - 数据缓存

- (void)dvv_archiverToCacheWithObject:(id)object fileName:(NSString *)fileName {
    
    [NSKeyedArchiver archiveRootObject:object toFile:[[self dvv_sandboxCachePath] stringByAppendingString:fileName]];
}

- (id)dvv_unarchiveFromCacheWithFileName:(NSString *)fileName {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self dvv_sandboxCachePath] stringByAppendingString:fileName]];
}


#pragma mark - public

- (NSString *)dvv_sandboxCachePath {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}


#pragma mark - call back
- (void)dvv_networkCallBack {
    if (objc_getAssociatedObject(self, &dvv_kNetworkCallBackBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kNetworkCallBackBlock))();
    }
}

- (void)dvv_networkError {
    if (objc_getAssociatedObject(self, &dvv_kNetworkErrorBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kNetworkErrorBlock))();
    }
}

- (void)dvv_nilResponseObject {
    if (objc_getAssociatedObject(self, &dvv_kNilResponseObjectBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kNilResponseObjectBlock))();
    }
}

- (void)dvv_refreshSuccess {
    if (objc_getAssociatedObject(self, &dvv_kRefreshSuccessBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kRefreshSuccessBlock))();
    }
}

- (void)dvv_refreshError {
    if (objc_getAssociatedObject(self, &dvv_kRefreshErrorBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kRefreshErrorBlock))();
    }
}

- (void)dvv_loadMoreSuccess {
    if (objc_getAssociatedObject(self, &dvv_kLoadMoreSuccessBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kLoadMoreSuccessBlock))();
    }
}

- (void)dvv_loadMoreError {
    if (objc_getAssociatedObject(self, &dvv_kLoadMoreErrorBlock)) {
        ((dispatch_block_t)objc_getAssociatedObject(self, &dvv_kLoadMoreErrorBlock))();
    }
}


#pragma mark - set block
- (void)dvv_setNetworkCallBackBlock:(dispatch_block_t)networkCallBackBlock {
    objc_setAssociatedObject(self, &dvv_kNetworkCallBackBlock, networkCallBackBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setNetworkErrorBlock:(dispatch_block_t)netwrokErrorBlock {
    objc_setAssociatedObject(self, &dvv_kNetworkErrorBlock, netwrokErrorBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setNilResponseObjectBlock:(dispatch_block_t)nilResponseObjectBlock {
    objc_setAssociatedObject(self, &dvv_kNilResponseObjectBlock, nilResponseObjectBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setRefreshSuccessBlock:(dispatch_block_t)refreshSuccessBlock {
    objc_setAssociatedObject(self, &dvv_kRefreshSuccessBlock, refreshSuccessBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setRefreshErrorBlock:(dispatch_block_t)refreshErrorBlock {
    objc_setAssociatedObject(self, &dvv_kRefreshErrorBlock, refreshErrorBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setLoadMoreSuccessBlock:(dispatch_block_t)loadMoreSuccessBlock {
    objc_setAssociatedObject(self, &dvv_kLoadMoreSuccessBlock, loadMoreSuccessBlock, OBJC_ASSOCIATION_COPY);
}

- (void)dvv_setLoadMoreErrorBlock:(dispatch_block_t)loadMoreErrorBlock {
    objc_setAssociatedObject(self, &dvv_kLoadMoreErrorBlock, loadMoreErrorBlock, OBJC_ASSOCIATION_COPY);
}


@end
