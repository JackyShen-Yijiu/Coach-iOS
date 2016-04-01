//
//  JZExamHeaderView.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZExamSummaryInfoData.h"
@interface JZExamHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) JZExamSummaryInfoData *dataGrop;


/// 创建examHeaderView
+ (instancetype)examHeaderViewWithTableView:(UITableView *)tableView;



@end
