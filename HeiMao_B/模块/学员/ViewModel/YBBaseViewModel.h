//
//  YBBaseViewModel.h
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBBaseViewModel : NSObject

typedef void(^BaseViewModelUpdataBlock)();

//** 调用刷新和加载回调Block **//
- (BOOL)successRefreshBlock;
- (BOOL)errorRefreshBlock;

- (BOOL)successLoadMoreBlock;
- (BOOL)errorLoadMoreBlock;

//** 设置刷新和加载回调Block **//
// 刷新成功时：回调Block
- (void)successRefreshBlock:(BaseViewModelUpdataBlock)successRefreshBlock;
// 刷新失败时：回调Block
- (void)errorRefreshBlock:(BaseViewModelUpdataBlock)errorRefreshBlock;

// 加载成功时：回调Block
- (void)successLoadMoreBlock:(BaseViewModelUpdataBlock)successLoadMoreBlock;
// 加载失败时：回调Block
- (void)errorLoadMoreBlock:(BaseViewModelUpdataBlock)errorLoadMoreBlock;

// 1、下拉刷新时的网络请求
- (void)networkRequestRefresh;
// 2、上拉加载时的网络请求
- (void)networkRequestLoadMore;

@end
