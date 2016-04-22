//
//  JZBulletinCell.h
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZBulletinData;

@interface JZBulletinCell : UITableViewCell
@property (nonatomic, strong) JZBulletinData *data;

+ (CGFloat)cellHeightDmData:(JZBulletinData *)dmData;


@end
