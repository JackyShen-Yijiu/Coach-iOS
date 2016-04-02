//
//  JZCompletionConfirmationCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/3/30.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZData;
@interface JZCompletionConfirmationCell : UITableViewCell

@property (nonatomic,strong) UIViewController *parentViewController;

@property (nonatomic , strong) NSArray *subjectArray;

@property (nonatomic,strong) JZData *listModel;

@property (nonatomic, strong) UIImageView *arrowImageView;

+ (CGFloat)cellHeihtWithlistData:(JZData *)data subjectArray:(NSArray *)subjectArray;

@end
