//
//  RefreshTableView.h
//  JewelryApp
//
//  Created by kequ on 15/5/4.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YiRefreshHeader.h"
#import "YiRefreshFooter.h"

@interface RefreshTableView : UITableView

@property(nonatomic,strong)YiRefreshHeader * refreshHeader;
@property(nonatomic,strong)YiRefreshFooter * refreshFooter;

@end
