//
//  JZBulletinView.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshTableView.h"
#import "JZBulletinData.h"
@interface JZBulletinView : RefreshTableView

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) NSMutableArray *listDataArray;
@property (nonatomic, strong) JZBulletinData *dataModel;




@end
