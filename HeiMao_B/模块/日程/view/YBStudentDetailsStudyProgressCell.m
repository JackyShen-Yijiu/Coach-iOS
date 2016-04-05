//
//  YBStudentDetailsStudyProgressCell.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBStudentDetailsStudyProgressCell.h"

@implementation YBStudentDetailsStudyProgressCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *xibArray = [[NSBundle mainBundle]loadNibNamed:@"YBStudentDetailsStudyProgressCell" owner:self options:nil];
        YBStudentDetailsStudyProgressCell *cell = xibArray.firstObject;
        
        [cell setRestorationIdentifier:reuseIdentifier];
        self = cell;
    }
    return self;
}
@end
