//
//  JZStudentPassListCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/4/1.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZPassListData.h"

typedef void (^JZHomeStudentListMessageAndCall) (NSInteger tag);

@interface JZStudentPassListCell : UITableViewCell
@property (nonatomic, assign) JZHomeStudentListMessageAndCall  studentListMessageAndCall;
@property (nonatomic, strong) JZPassListData *passlistMoel;
@end
