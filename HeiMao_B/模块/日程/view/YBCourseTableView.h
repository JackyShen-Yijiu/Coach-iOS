//
//  YBCourseTableView.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/29.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBCourseTableView : UIView
@property (nonatomic, strong) UITableView *dataTabelView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UIViewController *parentViewController;
- (void)reloadData;
@end
