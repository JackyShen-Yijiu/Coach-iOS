//
//  GoodsDesInPutCell.m
//  JewelryApp
//
//  Created by kequ on 15/5/9.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import "CourseDesInPutCell.h"
#define MAXSEARCHCOUNT 200

@interface CourseDesInPutCell()<UITextViewDelegate>
@property(nonatomic,strong)UIView * bottomView;
@end

@implementation CourseDesInPutCell

+ (CGFloat)cellHeight
{
    return 90.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyNext;//返回键的类型
    self.textView.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = RGB_Color(0x99, 0x99, 0x99);
    self.textView.font  = [UIFont systemFontOfSize:14.f];
//    self.textView.scrollEnabled = NO;
    [self.contentView addSubview:self.textView];
    
    self.placeLabel = [[UILabel alloc] init];
    self.placeLabel.font = [UIFont systemFontOfSize:14.f];
    self.placeLabel.textColor = RGB_Color(0x99, 0x99, 0x99);
    [self.textView addSubview:self.placeLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.textView.frame = CGRectMake(10, 0, self.width - 20, self.height);
    self.placeLabel.frame = CGRectMake(3, 10, self.textView.width - 4, 12);
    self.bottomView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    [CATransaction commit];
}

#pragma mark  - Delegate
//#pragma mark 字数限制
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//    NSMutableString *newtxt = [NSMutableString stringWithString:textView.text];
//    [newtxt replaceCharactersInRange:range withString:text];
//    if (newtxt.length > MAXSEARCHCOUNT ) {
//        newtxt = [newtxt substringWithRange:NSMakeRange(0,MAXSEARCHCOUNT)];
//    }
//    textView.text = newtxt;
//    if ([_delegate respondsToSelector:@selector(goodsDesInPutCellDidTextViewWillChangeToString:)]) {
//        [_delegate goodsDesInPutCellDidTextViewWillChangeToString:newtxt];
//    }
//    return ([newtxt length] <= MAXSEARCHCOUNT);
//}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.placeLabel setHidden:textView.text.length];
    if ([_delegate respondsToSelector:@selector(courseDesInPutCellDidTextViewWillChangeToString:)]) {
        [_delegate courseDesInPutCellDidTextViewWillChangeToString:textView.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.textView becomeFirstResponder];
    return YES;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB_Color(230, 230, 230);
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

@end
