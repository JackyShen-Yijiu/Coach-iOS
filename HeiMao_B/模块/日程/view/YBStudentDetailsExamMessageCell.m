//
//  YBStudentDetailsExamMessageCell.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentDetailsExamMessageCell.h"

@implementation YBStudentDetailsExamMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBStudentDetailsExamMessageCell" owner:self options:nil];
        YBStudentDetailsExamMessageCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}

@end
