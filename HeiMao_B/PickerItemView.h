//
//  PickerItemView.h
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PickerItemModel : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,assign,getter=isSeleted)BOOL seleted;
@property(nonatomic,strong)NSString * extentd; //预留扩展参数
@end

@class PickerItemView;
@protocol PickerItemViewDelegate <NSObject>
- (void)pickerItemDidValueChange:(PickerItemView *)pickerView;
@end
@interface PickerItemView : UIView
@property(nonatomic,weak)id<PickerItemViewDelegate>delegate;
@property(nonatomic,strong)PickerItemModel * model;
@end
