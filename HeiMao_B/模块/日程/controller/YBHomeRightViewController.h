//
//  YBHomeRightViewController.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JGBaseViewController.h"
#import "RFSegmentView.h"

@interface YBHomeRightViewController : JGBaseViewController
@property(nonatomic,strong) RFSegmentView * segController;
- (void)segmentViewSelectIndex:(NSInteger)index;
@end
