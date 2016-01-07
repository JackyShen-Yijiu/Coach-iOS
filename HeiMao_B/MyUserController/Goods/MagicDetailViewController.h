//
//  MagicDetailViewController.h
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopMainModel.h"
#import "LTBottomView.h"
#import "MyWallet.h"

@interface MagicDetailViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)UIWindow *wid;
@property (nonatomic,retain)ShopMainModel *mainModel;
@property (nonatomic,retain) LTBottomView *bottomView;
@property (nonatomic,retain)  UIButton *didClickBtn;
@property (nonatomic,assign) int moneyCount;


@end
