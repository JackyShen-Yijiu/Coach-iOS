//
//  JZCompletionConfirmationCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZCompletionConfirmationCell : UITableViewCell

@property (nonatomic , strong) NSArray *subjectArray;

- (CGFloat)cellHeihtWith:(NSArray *)dataArray;

@end
