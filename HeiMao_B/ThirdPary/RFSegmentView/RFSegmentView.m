//
//  RFSegmentView.m
//  RFSegmentView
//
//  Created by 王若风 on 1/15/15.
//  Copyright (c) 2015 王若风. All rights reserved.
//

#import "RFSegmentView.h"

#define kLeftMargin         15
#define kItemHeight         30
#define kBorderLineWidth    0.5

@class RFSegmentItem;
@protocol RFSegmentItemDelegate
- (void)ItemStateChanged:(RFSegmentItem *)item index:(NSInteger)index isSelected:(BOOL)isSelected;
@end

@interface RFSegmentItem : UIView
@property(nonatomic ,strong) UIColor *norColor;
@property(nonatomic ,strong) UIColor *selColor;
@property(nonatomic ,strong) UILabel *titleLabel;

@property(nonatomic)         NSInteger index;
@property(nonatomic)         BOOL isSelected;
@property(nonatomic)         id   delegate;

@end

@implementation RFSegmentItem
- (id)initWithFrame:(CGRect)frame index:(NSInteger)index title:(NSString *)title norColor:(UIColor *)norColor selColor:(UIColor *)selColor isSelected:(BOOL)isSelected;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        _titleLabel.alpha = 0.7;
        [self addSubview:_titleLabel];
        
        self.norColor        = norColor;
        self.selColor        = selColor;
        self.titleLabel.text = title;
        self.index           = index;
        self.isSelected      = isSelected;
        
    }
    return self;
}

- (void)setSelColor:(UIColor *)selColor
{
    if (_selColor != selColor) {
        _selColor = selColor;
        
        if (_isSelected) {
            self.titleLabel.textColor = [UIColor blackColor];
            self.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            self.titleLabel.textColor = self.selColor;
            self.backgroundColor = [UIColor whiteColor];
        }

    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (_isSelected) {
        self.titleLabel.textColor = self.norColor;
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.isSelected = !_isSelected;
    
    if (_delegate) {
        [_delegate ItemStateChanged:self index:self.index isSelected:self.isSelected];
    }
    
}

@end
#pragma mark - RFSegmentView
@interface RFSegmentView()

@property(nonatomic ,strong) UIView *bgView;
@property(nonatomic ,strong) NSMutableArray *titlesArray;
@property(nonatomic ,strong) NSMutableArray *itemsArray;
@property(nonatomic ,strong) NSMutableArray *linesArray;
@property(nonatomic ,strong) NSMutableArray *deliveArray;

@end
@implementation RFSegmentView

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor  = [UIColor clearColor];
        float viewWidth       = CGRectGetWidth(frame);
        float viewHeight      = CGRectGetHeight(frame);
        float init_x          = CGRectGetMinX(frame);
        float init_y          = CGRectGetMinY(frame);
        
        //
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(kLeftMargin, (viewHeight - kItemHeight)/2, viewWidth -2*kLeftMargin, kItemHeight)];
        self.bgView.backgroundColor    = [UIColor whiteColor];
        self.bgView.clipsToBounds      = YES;
        self.bgView.layer.cornerRadius = 2.f;
        self.bgView.layer.borderWidth  = kBorderLineWidth;
        self.bgView.layer.borderColor  = [UIColor whiteColor].CGColor;
        [self addSubview:self.bgView];
        
        init_x = 0;
        init_y = 0;
        
        float itemWidth = CGRectGetWidth(self.bgView.frame)/items.count;
        float itemHeight = CGRectGetHeight(self.bgView.frame);
        
        if (items.count >= 2) {
            
            for (NSInteger i =0; i<items.count; i++) {
                
                RFSegmentItem *item = [[RFSegmentItem alloc] initWithFrame:CGRectMake(init_x, init_y, itemWidth, itemHeight)
                                                                     index:i title:items[i]
                                                                  norColor:JZ_BlueColor
                                                                  selColor:[UIColor whiteColor]
                                                                isSelected:(i == 0)? YES: NO];
                init_x += itemWidth;
                [self.bgView addSubview:item];
                item.delegate = self;
                
                //save all items
                if (!self.itemsArray) {
                    self.itemsArray = [[NSMutableArray alloc] initWithCapacity:items.count];
                }
                
                [self.itemsArray addObject:item];
                
            }
            
            //add Ver lines
            init_x = 0;
            for (NSInteger i = 0; i<items.count-1; i++) {
                
                // 竖分割线
                init_x += itemWidth;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(init_x, 0, kBorderLineWidth, itemHeight)];
                lineView.backgroundColor = [UIColor redColor];
                
                //save all lines
                if (!self.linesArray) {
                    self.linesArray = [[NSMutableArray alloc] initWithCapacity:items.count];
                }
                [self.linesArray addObject:lineView];
                
            }
            
            for (NSInteger i = 0; i<items.count; i++) {
                
                RFSegmentItem *item = self.itemsArray[i];

                // 横分割线
                UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(item.origin.x+20, self.height-2, itemWidth-10, 2)];
                lineLabel.backgroundColor = [UIColor whiteColor];
                [self addSubview:lineLabel];
                
                //save all lines
                if (!self.deliveArray) {
                    self.deliveArray = [[NSMutableArray alloc] initWithCapacity:items.count];
                }
                [self.deliveArray addObject:lineLabel];
                
            }
            
        }
        else
        {
            NSException *exc = [[NSException alloc] initWithName:@"items count error"
                                                          reason:@"items count at least 2"
                                                        userInfo:nil];
            @throw exc;
        }
        
        
    }
    return self;
}

- (void)setTintColor:(UIColor *)tintColor
{
    if (self.itemsArray.count < 2) {
        return;
    }
    
    if (_tintColor != tintColor) {
        
        self.bgView.layer.borderColor  = tintColor.CGColor;
        
        for (NSInteger i = 0; i<self.itemsArray.count; i++) {
            RFSegmentItem *item = self.itemsArray[i];
            item.selColor = tintColor;
            [item setNeedsDisplay];
        }
        
        for (NSInteger i = 0; i<self.linesArray.count; i++) {
            UIView *lineView = self.linesArray[i];
            lineView.backgroundColor = tintColor;
        }
        
    }
    
}
#pragma mark - Selete
- (void)setSeltedIndex:(NSInteger)index
{
    
    NSLog(@"%s index:%ld",__func__,(long)index);
    
    if (self.itemsArray.count <2 || index >= self.itemsArray.count) {
        return;
    }
    for (int i =0; i<self.itemsArray.count; i++) {
        RFSegmentItem *item = self.itemsArray[i];
        item.isSelected = NO;
    }
    
    // 底部分割线
    UILabel *deliveLabel = self.deliveArray[index];
    deliveLabel.backgroundColor = JZ_BlueColor;
    
    RFSegmentItem * currentItem = [self.itemsArray objectAtIndex:index];
    currentItem.isSelected = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(segmentViewSelectIndex:)])
    {
        [_delegate segmentViewSelectIndex:index];
    }
}

#pragma mark - RFSegmentItemDelegate
- (void)ItemStateChanged:(RFSegmentItem *)currentItem index:(NSInteger)index isSelected:(BOOL)isSelected
{
    NSLog(@"%s index:%ld",__func__,(long)index);
    
    for (int i = 0; i < self.deliveArray.count; i++) {
        UILabel *deliveLabel = self.deliveArray[i];
        deliveLabel.backgroundColor = [UIColor whiteColor];
    }
    // 底部分割线
    UILabel *deliveLabel = self.deliveArray[index];
    deliveLabel.backgroundColor = JZ_BlueColor;
    
    if (self.itemsArray.count <2) {
        return;
    }
    [self setSeltedIndex:index];
}

@end
