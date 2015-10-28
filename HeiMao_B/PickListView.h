//
//  PickListView.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerItemView.h"

@class PickListView;
@protocol PickListViewDelegate <NSObject>
- (void)pickerListViewDidValueChange:(PickListView *)pickerListView;
@end

@interface PickListView : UIView

+ (CGFloat)pickListViewHeigthWithPickerCount:(NSInteger)count;

@property(nonatomic,strong)NSArray * pickItemArray;
@property(nonatomic,weak)id<PickListViewDelegate>delegate;
- (void)setTitle:(NSString *)title;

@end
