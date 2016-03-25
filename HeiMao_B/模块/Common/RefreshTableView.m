//
//  RefreshTableView.m
//  JewelryApp
//
//  Created by kequ on 15/5/4.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "RefreshTableView.h"

@implementation RefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initRefreshView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initRefreshView];
    }
    return self;
}

- (void)initRefreshView
{
    self.refreshHeader =[[YiRefreshHeader alloc] init];
    self.refreshHeader.scrollView = self;
    [self.refreshHeader header];
    
    self.refreshFooter = [[YiRefreshFooter alloc] init];
    self.refreshFooter.scrollView = self;
    [self.refreshFooter footer];
    
    self.refreshHeader.beginRefreshingBlock=^(){
    };
    
    self.refreshFooter.beginRefreshingBlock=^(){
    };
    
}


@end
