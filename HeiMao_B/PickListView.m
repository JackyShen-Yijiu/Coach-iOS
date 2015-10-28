//
//  PickListView.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "PickListView.h"
#import "PickerItemView.h"

@interface PickListView()<PickerItemViewDelegate>

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)NSMutableArray * picListViewArray;

@end

@implementation PickListView
+ (CGFloat)pickListViewHeigthWithPickerCount:(NSInteger)count
{
    CGFloat heigth = 15 + 14.f;
    heigth += (20 + 14) * count;
    heigth += 20.f; //底边界
    return heigth;
}

#pragma mark - Data
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setPickItemArray:(NSArray *)pickItemArray
{
    _pickItemArray = pickItemArray;
    
    for (NSInteger i = 0; i < pickItemArray.count; i++) {
        PickerItemModel * piceModel = _pickItemArray[i];
        PickerItemView * view = nil;
        if (i < self.picListViewArray.count) {
            view = [self.picListViewArray objectAtIndex:i];
            [view setHidden:NO];
        }else{
            view = [[PickerItemView alloc] init];
            view.delegate = self;
            view.tag = i;
            [self addSubview:view];
            [self.picListViewArray addObject:view];
        }
        view.model = piceModel;
    }
    if (pickItemArray.count < self.picListViewArray.count) {
        for (NSInteger i = pickItemArray.count; i < self.picListViewArray.count; i++) {
            PickerItemView * view = self.picListViewArray[i];
            [view setHidden:YES];
        }
    }
    [self setNeedsLayout];
}

#pragma mark Action
- (void)pickerItemDidValueChange:(PickerItemView *)pickerView
{
    if ([_delegate respondsToSelector:@selector(pickerListViewDidValueChange:)]) {
        [_delegate pickerListViewDidValueChange:self];
    }
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 19, self.width - 30, 14);
    
    CGFloat width = self.titleLabel.width;
    CGFloat heigth  = self.titleLabel.height;
    CGFloat top = self.titleLabel.bottom + 19;
    for (PickerItemView * view in self.picListViewArray) {
        if (!view.isHidden){
            view.frame = CGRectMake(self.titleLabel.left, top, width, heigth);
            top = view.bottom + 20.f;
        }
    }
}


#pragma mark -  GetMethod
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _titleLabel.textColor = RGB_Color(0x33, 0x33, 0x33);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (NSMutableArray *)picListViewArray
{
    if (!_picListViewArray) {
        _picListViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _picListViewArray;
}
@end
