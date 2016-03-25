//
//  DVVToolBarView.h
//  Principal
//
//  Created by dawei on 15/11/28.
//  Copyright © 2015年 DaWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVVToolBarView : UIView

//预定义一个Block类型
typedef void(^DVVToolBarViewBlock)(UIButton *button);

//当前选中的按钮（默认为 0 ）
@property(nonatomic,assign) NSInteger selectButtonIndex;

//按钮正常情况下的颜色
@property(nonatomic,strong) UIColor *buttonNormalColor;
//按钮选中时的颜色
@property(nonatomic,strong) UIColor *buttonSelectedColor;

//存放全部标题的数组
@property(nonatomic,strong) NSArray *titleArray;
//标题字体大小
@property(nonatomic,strong) UIFont *titleFont;
//标题正常情况下的颜色
@property(nonatomic,strong) UIColor *titleNormalColor;
//标题选中时的颜色
@property(nonatomic,strong) UIColor *titleSelectedColor;

//跟随条的位置（0：下方；1：上方）
@property(nonatomic,assign) BOOL followBarLocation;
//跟随条的颜色
@property(nonatomic,strong) UIColor *followBarColor;
//跟随条的高度
@property(nonatomic,assign) CGFloat followBarHeight;

- (void)dvvSetItemSelectedBlock:(DVVToolBarViewBlock)handle;

- (void)selectItem:(NSUInteger)tag;


@end
