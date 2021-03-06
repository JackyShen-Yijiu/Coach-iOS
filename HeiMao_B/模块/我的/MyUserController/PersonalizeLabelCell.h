//
//  PersonalizeLabelCell.h
//  HeiMao_B
//
//  Created by 胡东苑 on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalizeLabelCell : UITableViewCell

@property (nonatomic, strong) UILabel *personlizeLabel;
@property (nonatomic, strong) NSArray *personlizeLabelArray;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, copy) void (^addTag)(NSString *str);
@property (nonatomic, copy) void (^tapTagLabel)(NSInteger tag);

- (void)initUIWithArray:(NSArray *)arr withLabel:(NSString *)string withBackGroundColorArr:(NSArray *)colorArr;   //带标题的cell
+ (CGFloat)cellHeightWithArray:(NSArray *)arr;

- (void)initUIWithNoTitleWithArray:(NSArray *)arr WithTextFieldIsExist:(BOOL)isExist withLabelColorArray:(NSArray *)colorArr withBackGroundColorArr:(NSArray *)bgcolorArr;                     //不带标题的cell
+ (CGFloat)cellHeightWithNoTitleWithArray:(NSArray *)arr WithTextFieldIsExist:(BOOL)isExist;

@end
