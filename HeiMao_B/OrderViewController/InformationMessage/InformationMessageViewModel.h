//
//  InformationMessageViewModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationMessageViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *informationArray;

@property (nonatomic, assign) NSUInteger index;

@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, copy) void (^tableViewNeedReLoad)(void);

@property (nonatomic, copy) void (^showToast)(void);

- (void)networkRequestRefresh;

- (void)networkRequestLoadMore;
@end