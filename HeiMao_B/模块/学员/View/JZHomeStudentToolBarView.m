//
//  JZHomeStudentToolBarView.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZHomeStudentToolBarView.h"

#define TITLE_COLOR [UIColor whiteColor]

#define WIDTH self.bounds.size.width
#define HEIGHT self.bounds.size.height

@interface JZHomeStudentToolBarView ()
//执行点击事件的Block
@property (nonatomic, copy) JZHomeStudentToolBarViewBlock itemBlock;

//跟随条
@property (nonatomic, strong) UILabel             *followBarLabel;


@end
@implementation JZHomeStudentToolBarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //调用初始化属性
        [self chuShiHuaShuXing];
    }
    return self;
}
#pragma mark - 初始化属性
- (void)chuShiHuaShuXing {
    
    //当前选中的按钮
    _selectButtonInteger = 0;
    
    //按钮
    _buttonNormalColor = [UIColor clearColor];
    _buttonSelectColor = [UIColor clearColor];
    
    //标题
    _titleArray=[NSArray new];
    // 正常图片
    _imgNormalArray = [NSArray new];
    // 选中图片
    _imgSelectArray = [NSArray new];
    
    _titleArray = @[ @"标题1", @"标题2", @"..." ];
    _titleFont = [UIFont systemFontOfSize:14];
    if (_titleNormalColor==nil) {
        _titleNormalColor = [UIColor colorWithWhite:1 alpha:0.75];
    }
    _titleSelectColor = TITLE_COLOR;
    
    //跟随条
    //    if (_followBarColor==nil) {
    //        _followBarColor = [UIColor yellowColor];
    //    }
    if (_followBarHeight==0) {
        _followBarHeight = 2;
    }
    _followBarLocation = 0;
}

#pragma mark - 按钮的点击事件
- (void)btnClickAction:(UIButton *)sender {
    
    //加此判断，避免重复按一个按钮，重复触发事件
    if(sender.tag != _selectButtonInteger){
        
        for (UIButton *button in sender.superview.subviews) {
            
            //使跟随条跟随
            if (button.tag==12345) {
                //获取frame
                CGRect rect=button.frame;
                //现在要移动到的minX坐标
                CGFloat  newMinX=(sender.tag)*rect.size.width;
                
                rect.origin.x=newMinX;
                //动画
                [UIButton animateWithDuration:0.3 animations:^{
                    button.frame=rect;
                }];
            }else{
                if (button.tag == _selectButtonInteger && [button isKindOfClass:[UIButton class]]) {
                    
                    //上次按下的背景色为正常情况下的颜色
                    button.backgroundColor = _buttonNormalColor;
                    //上次按下的字体色为正常情况下的颜色

                    [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:_imgNormalArray[_selectButtonInteger]] forState:UIControlStateNormal];
                }
            }
        }
        //选中此按钮
        [self selectOneButton:sender.tag];
        
        //如果Block不为空时才调用，执行在其他类中的实现的内容
        if (_itemBlock) {
            
            _itemBlock(sender);
        }
    }
}

- (void)selectItem:(NSUInteger)tag {
    
    for (UIButton *btn in self.subviews) {
        if (tag == btn.tag) {
            [self btnClickAction:btn];
        }
    }
}

#pragma mark - 选中一个按钮

- (void)selectOneButton:(NSInteger)tag {
    for (UIButton *button in self.subviews) {
        
        if (button.tag == tag && [button isKindOfClass:[UIButton class]]) {
            //改变背景色和字体颜色为选中时的颜色
            button.backgroundColor=_buttonSelectColor;
            [button setTitleColor:_titleSelectColor forState:UIControlStateNormal];
            
            [button setImage:[UIImage imageNamed:_imgSelectArray[(int)tag]] forState:UIControlStateNormal];
        }
    }
    //更改当前选中的按钮tag值
    _selectButtonInteger=tag;
}
#pragma mark - 实现在 .h中声明的，模拟点击一项的方法（参数为一个Block）
/**
 param handle 用户实现的Block
 */
- (void)dvvToolBarViewItemSelected:(JZHomeStudentToolBarViewBlock)handle {
    
    //指向用户实现的Block
    _itemBlock = handle;
}

#pragma mark - 创建导航栏中的所有按钮

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置导航栏中的按钮大小
    CGSize buttonSize = CGSizeMake(WIDTH/_titleArray.count, HEIGHT);
    
    //循环创建所有的按钮
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *itemButton = [self createOneButtonWithTitle:_titleArray[i] Size:buttonSize MinX:i*buttonSize.width Tag:i titleArray:_titleArray imgNormalArray:_imgNormalArray[i] imgSelectArray:_imgSelectArray[i]];
        
        [self addSubview:itemButton];
    }
    
    _followBarLabel = [UILabel new];
    //添加跟随的按钮
    CGFloat locationFloat = _selectButtonInteger * buttonSize.width;
    if (_followBarLocation) {
        _followBarLabel.frame = CGRectMake(locationFloat, 0, buttonSize.width, _followBarHeight);
    }else{
        _followBarLabel.frame = CGRectMake(locationFloat, buttonSize.height-_followBarHeight, buttonSize.width, _followBarHeight);
    }
    //颜色
    _followBarLabel.backgroundColor = [UIColor yellowColor];
    if (_followBarColor) {
        _followBarLabel.backgroundColor = _followBarColor;
    }
    if (_followBarAlpha) {
        _followBarLabel.alpha = _followBarAlpha;
    }
    
    //将跟随条的tag值设为12345，避免和按钮的tag值起冲突
    _followBarLabel.tag = 12345;
    
    [self addSubview:_followBarLabel];
    
    //默认选中第一个按钮
    [self selectOneButton:_selectButtonInteger];
}

#pragma mark 创建一个按钮
- (UIButton *)createOneButtonWithTitle:(NSString *)title Size:(CGSize)size MinX:(CGFloat)mimX Tag:(NSInteger)tag titleArray:(NSArray *)titleArray imgNormalArray:(NSString *)imgNormalArray imgSelectArray:(NSString *)imgSelectArray{
    
    UIButton *btn = [UIButton new];
    
    btn.titleLabel.font = [UIFont fontWithName:@"DIN-Regular" size:11];
    btn.titleLabel.font = _titleFont;
    
    CGSize btnSize = size;
    if (titleArray.count==1) {
        CGSize btnSize = [title sizeWithFont:_titleFont];
        btn.frame = CGRectMake(15, 0, btnSize.width, size.height);
    }else{
        //位置和大小
        btn.frame = CGRectMake(mimX, 0, size.width, size.height);
    }
    btn.titleLabel.textAlignment = _textAlignment;
    
    //显示文字
    [btn setTitle:title forState:UIControlStateNormal];
    //显示文字颜色
    [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    
    // 显示正常情况下图片
    if (![imgNormalArray isEqualToString:@""] && imgNormalArray != nil ) {
        CGFloat imgW = 18;
        CGFloat imgH = 20;
        CGFloat titleW = 2 * 12;
        [btn setImage:[UIImage imageNamed:imgNormalArray] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, (size.width - imgW) / 2, 26, (size.width - imgW) / 2)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(26, (size.width - titleW) / 2 - 20, 0, 20)];
    }

    //tag值
    btn.tag=tag;
    //点击事件
    [btn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

@end
