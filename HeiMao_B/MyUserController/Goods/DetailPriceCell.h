//
//  DetailPriceCell.h
//  Magic
//
//  Created by ytzhang on 15/11/9.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPriceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *scanNumber;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumber;
@property (weak, nonatomic) IBOutlet UILabel *shopDetailName;
@property (weak, nonatomic) IBOutlet UILabel *shopDetailNamePrice;

@end
