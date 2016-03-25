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


+ (CGFloat)pickListViewHeigthWithPickerCount:(NSInteger)count couleNumber:(NSInteger)couleNumber
{
    NSAssert(couleNumber == 1 || couleNumber == 2, @"目前就支持1和2两种方式");
    CGFloat heigth = 15 + 14.f;
    heigth += (20 + 14) * ceil(count/(CGFloat)couleNumber);
    heigth += 20.f; //底边界
    return heigth;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.couleNumber = 1;
    }
    return self;
}

#pragma mark - Data
- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setPickItemArray:(NSArray *)pickItemArray
{
    NSAssert(self.couleNumber == 1 || self.couleNumber == 2, @"目前就支持1和2两种方式");

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
    if (self.couleNumber == 2) {
        [self cancelAllSeleted];
        [pickerView setSeleted:YES];
    }
    if ([_delegate respondsToSelector:@selector(pickerListViewDidValueChange:)]) {
        [_delegate pickerListViewDidValueChange:self];
    }
}

- (void)cancelAllSeleted
{
    for (PickerItemView * view in self.picListViewArray) {
        [view setSeleted:NO];
    }
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(15, 19, self.width - 30, 14);
    CGFloat heigth  = self.titleLabel.height;
    CGFloat top = self.titleLabel.bottom + 19;
    for (PickerItemView * view in self.picListViewArray) {
        [view sizeToFit];
        if (!view.isHidden){
            if (self.couleNumber == 1) {
                view.frame = CGRectMake(self.titleLabel.left, top, view.width, heigth);
                top = view.bottom + 20.f;
            }else{
                if (view.tag % 2 == 0) {  //左边
                    view.frame = CGRectMake(self.titleLabel.left, top, view.width, heigth);
                }else{ //右边
                    
                    view.frame = CGRectMake(self.titleLabel.width/2.f + 30, top, view.width, heigth);
                    if (view.right > self.titleLabel.right) {
                        view.right = self.titleLabel.right;
                    }
                    top = view.bottom + 20.f;
                }
            }
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
