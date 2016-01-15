//
//  MagicDetailViewController.h
//  TestShop
//
//  Created by ytzhang on 15/12/19.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTBottomView.h"
#import "ShopMainModel.h"
#import "MyWallet.h"

@interface MagicDetailViewController : UIViewController
@property (nonatomic,retain)ShopMainModel *mainModel;
@property (nonatomic,retain) LTBottomView *bottomView;
@property (nonatomic,retain)  UIButton *didClickBtn;
@property (nonatomic,assign) int moneyCount;
@end
