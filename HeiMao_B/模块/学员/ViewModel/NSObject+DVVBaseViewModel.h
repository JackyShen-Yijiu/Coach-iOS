//
//  NSObject+DVVBaseViewModel.h
//  DVVTestBaseViewModel
//
//  Created by 大威 on 16/2/5.
//  Copyright © 2016年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (DVVBaseViewModel)


/**
 *  重写此方法 刷新时的网络请求
 */
- (void)dvv_networkRequestRefresh;

/**
 *  重写此方法 加载时的网络请求
 */
- (void)dvv_networkRequestLoadMore;

/**
 *  重写此方法 根据第几页和是否是刷新状态来处理数据
 *
 *  @param index     第几页
 *  @param isRefresh 是否是刷新
 */
- (void)dvv_networkRequestWithIndex:(NSUInteger)index
                          isRefresh:(BOOL)isRefresh;

/**
 *  重写此方法 检测服务器返回的数据
 *
 *  @param responseObject 服务器返回的数据
 *
 *  @return YES：数据错误或没有数据  NO：有可用的数据
 */
- (BOOL)dvv_checkResponseObject:(id)responseObject;


#pragma mark - 调用回调

/**  处理完网络数据后，调用刷新成功的回调 */
- (void)dvv_refreshSuccess;
/**  处理完网络数据后，调用刷新失败的回调 */
- (void)dvv_refreshError;

/**  处理完网络数据后，调用加载成功的回调 */
- (void)dvv_loadMoreSuccess;
/**  处理完网络数据后，调用加载失败的回调 */
- (void)dvv_loadMoreError;

/**  检测完服务器返回的数据为空时的回调 */
- (void)dvv_nilResponseObject;

/**  网络加载失败的回调 */
- (void)dvv_networkError;

/**  成功或失败都调用的回调 */
- (void)dvv_networkCallBack;


#pragma mark - 设置回调

/**
 *  设置刷新成功时的回调Block
 *
 *  @param refreshSuccessBlock 刷新成功时的回调Block
 */
- (void)dvv_setRefreshSuccessBlock:(dispatch_block_t)refreshSuccessBlock;

/**
 *  设置刷新失败时的回调Block
 *
 *  @param refreshErrorBlock 刷新失败时的回调Block
 */
- (void)dvv_setRefreshErrorBlock:(dispatch_block_t)refreshErrorBlock;

// 设置加载成功、失败时的回调Block
/**
 *  设置加载成功时的回调Block
 *
 *  @param loadMoreSuccessBlock 加载成功时的回调Block
 */
- (void)dvv_setLoadMoreSuccessBlock:(dispatch_block_t)loadMoreSuccessBlock;

/**
 *  设置加载失败时的回调Block
 *
 *  @param loadMoreErrorBlock 加载失败时的回调Block
 */
- (void)dvv_setLoadMoreErrorBlock:(dispatch_block_t)loadMoreErrorBlock;

/**
 *  设置服务器返回的数据为空时的回调Block
 *
 *  @param nilResponseObjectBlock 服务器返回的数据为空时的回调Block
 */
- (void)dvv_setNilResponseObjectBlock:(dispatch_block_t)nilResponseObjectBlock;

/**
 *  设置网络错误的回调Block
 *
 *  @param netwrokErrorBlock 网络错误的回调Block
 */
- (void)dvv_setNetworkErrorBlock:(dispatch_block_t)netwrokErrorBlock;

/**
 *  设置成功或失败都调用的回调Block
 *
 *  @param handle 成功或失败都调用的回调Block
 */
- (void)dvv_setNetworkCallBackBlock:(dispatch_block_t)networkCallBackBlock;


#pragma mark - 数据缓存

/**
 *  将对象存储到沙盒的Cache目录下
 *
 *  @param object   需要存储的对象
 *  @param fileName 存储对象的文件名
 */
- (void)dvv_archiverToCacheWithObject:(id)object fileName:(NSString *)fileName;

/**
 *  将对象从沙盒的Cache目录下取出
 *
 *  @param fileName 沙盒的Cache目录下的文件名
 *
 *  @return 从Cache沙盒的目录下取出的对象
 */
- (id)dvv_unarchiveFromCacheWithFileName:(NSString *)fileName;


#pragma mark - public

/**
 *  获取沙盒的Cache目录
 *
 *  @return 沙盒的Cache目录
 */
- (NSString *)dvv_sandboxCachePath;

@end
