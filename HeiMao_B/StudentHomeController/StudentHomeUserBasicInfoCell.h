//
//  StudentHomeCell.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentHomeUserBasicInfoCell : UITableViewCell

+ (CGFloat)cellHeigth;

- (void)setBgImageUrlStr:(NSString *)bgImageUrlStr userName:(NSString *)userName userId:(NSString *)userId;

@end
