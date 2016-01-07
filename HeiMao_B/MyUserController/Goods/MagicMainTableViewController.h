//
//  MagicMainTableViewController.h
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWallet.h"

@interface MagicMainTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
// 设置轮播图的属性
@property (nonatomic, strong) UIScrollView * scrollNewList;
@property (nonatomic, strong) UIPageControl * pageNewList;
@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic,retain) NSMutableArray *ShopListArray; // 存放轮播图数组
@property (nonatomic,retain) NSMutableArray *shopMainListArray; // 存放展示图片

@end
