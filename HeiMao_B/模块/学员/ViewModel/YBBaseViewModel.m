//
//  YBBaseViewModel.m
//  Headmaster
//
//  Created by 大威 on 15/12/2.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "YBBaseViewModel.h"

@interface YBBaseViewModel()

@property (nonatomic, copy) BaseViewModelUpdataBlock mySuccessRefreshBlock;

@property (nonatomic, copy) BaseViewModelUpdataBlock myErrorRefreshBlock;

@property (nonatomic, copy) BaseViewModelUpdataBlock mySuccessLoadMoreBlock;

@property (nonatomic, copy) BaseViewModelUpdataBlock myErrorLoadMoreBlock;

@end

@implementation YBBaseViewModel

- (void)networkRequestRefresh {
    // 重写此方法刷新数据（需自己调用刷新回调）
}

- (void)networkRequestLoadMore {
    // 重写此方法加载数据（需自己调用加载回调）
}

#pragma mark - call back

- (BOOL)successRefreshBlock {
    if (_mySuccessRefreshBlock) {
        _mySuccessRefreshBlock();
        return YES;
    }
    return NO;
}

- (BOOL)errorRefreshBlock {
    if (_myErrorRefreshBlock) {
        _myErrorRefreshBlock();
        return YES;
    }
    return NO;
}

- (BOOL)successLoadMoreBlock {
    if (_mySuccessLoadMoreBlock) {
        _mySuccessLoadMoreBlock();
        return YES;
    }
    return NO;
}

- (BOOL)errorLoadMoreBlock {
    if (_myErrorLoadMoreBlock) {
        _myErrorLoadMoreBlock();
        return YES;
    }
    return NO;
}

#pragma mark - set call back

- (void)successRefreshBlock:(BaseViewModelUpdataBlock)successRefreshBlock {
    _mySuccessRefreshBlock = successRefreshBlock;
}

- (void)errorRefreshBlock:(BaseViewModelUpdataBlock)errorRefreshBlock {
    _myErrorRefreshBlock = errorRefreshBlock;
}

- (void)successLoadMoreBlock:(BaseViewModelUpdataBlock)successLoadMoreBlock {
    _mySuccessLoadMoreBlock = successLoadMoreBlock;
}

- (void)errorLoadMoreBlock:(BaseViewModelUpdataBlock)errorLoadMoreBlock {
    _myErrorLoadMoreBlock = errorLoadMoreBlock;
}

@end
