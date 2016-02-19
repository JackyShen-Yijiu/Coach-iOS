//
//  DVVLicensingStudentListView.h
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVVStudentListViewModel.h"

@interface DVVLicensingStudentListView : UITableView

- (void)beginNetworkRequest;

@property (nonatomic, strong) DVVStudentListViewModel *viewModel;

@property (nonatomic,weak) UIViewController *parentViewController;

@end
