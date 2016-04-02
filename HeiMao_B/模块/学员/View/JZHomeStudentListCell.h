//
//  JZHomeStudentListCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZResultModel.h"

typedef void (^JZHomeStudentListMessageAndCall) (NSInteger tag);

@interface JZHomeStudentListCell : UITableViewCell

@property (nonatomic, strong) JZResultModel *listModel;

@property (nonatomic, copy) JZHomeStudentListMessageAndCall  studentListMessageAndCall;
@end
