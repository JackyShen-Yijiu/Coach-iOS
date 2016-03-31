//
//  YBStudentDetailsCommentListCell.h
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/31.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YBStudentDetailsCommentListCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *dataDict;
+ (CGFloat)heightWithModel:(NSDictionary *)model;
@end
