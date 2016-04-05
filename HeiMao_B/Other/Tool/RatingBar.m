//
//  RatingBar.m
//  BlackCat
//
//  Created by bestseller on 15/10/8.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "RatingBar.h"

@interface RatingBar () {
    CGFloat starRating;
    CGFloat lastRating;
    
    CGFloat height;
    CGFloat width;
    
    UIImage *unSelectedImage;
    UIImage *halfSelectedImage;
    UIImage *fullSelectedImage;
    CGFloat margin;
}
@property (nonatomic,strong) UIImageView *s1;
@property (nonatomic,strong) UIImageView *s2;
@property (nonatomic,strong) UIImageView *s3;
@property (nonatomic,strong) UIImageView *s4;
@property (nonatomic,strong) UIImageView *s5;
@property (nonatomic,weak) id<RatingBarDelegate> delegate;

@end
@implementation RatingBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isIndicator = YES;
    }
    return self;
}

/**
 *  初始化设置未选中图片、半选中图片、全选中图片，以及评分值改变的代理（可以用
 *  Block）实现
 *
 *  @param deselectedName   未选中图片名称
 *  @param halfSelectedName 半选中图片名称
 *  @param fullSelectedName 全选中图片名称
 *  @param delegate          代理
 */
-(void)setImageDeselected:(NSString *)deselectedName halfSelected:(NSString *)halfSelectedName fullSelected:(NSString *)fullSelectedName andDelegate:(id<RatingBarDelegate>)delegate{
    
    self.delegate = delegate;
    
    unSelectedImage = [UIImage imageNamed:deselectedName];
    halfSelectedImage = halfSelectedName == nil ? unSelectedImage : [UIImage imageNamed:halfSelectedName];
    fullSelectedImage = [UIImage imageNamed:fullSelectedName];
    
    height = 0.0,width = 0.0;
    margin = 4;
    if (height < [fullSelectedImage size].height) {
        height = [fullSelectedImage size].height;
    }
    if (height < [halfSelectedImage size].height) {
        height = [halfSelectedImage size].height;
    }
    if (height < [unSelectedImage size].height) {
        height = [unSelectedImage size].height;
    }
    if (width < [fullSelectedImage size].width) {
        width = [fullSelectedImage size].width;
    }
    if (width < [halfSelectedImage size].width) {
        width = [halfSelectedImage size].width;
    }
    if (width < [unSelectedImage size].width) {
        width = [unSelectedImage size].width;
    }
    starRating = 0.0;
    lastRating = 0.0;
    
    _s1 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s2 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s3 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s4 = [[UIImageView alloc] initWithImage:unSelectedImage];
    _s5 = [[UIImageView alloc] initWithImage:unSelectedImage];
    
    [_s1 setFrame:CGRectMake(0,         0, width, height)];
    [_s2 setFrame:CGRectMake(width + margin,     0, width, height)];
    [_s3 setFrame:CGRectMake(2 * width + 2 * margin, 0, width, height)];
    [_s4 setFrame:CGRectMake(3 * width + 3 * margin, 0, width, height)];
    [_s5 setFrame:CGRectMake(4 * width + 4 * margin, 0, width, height)];
    
    [_s1 setUserInteractionEnabled:YES];
    [_s2 setUserInteractionEnabled:YES];
    [_s3 setUserInteractionEnabled:YES];
    [_s4 setUserInteractionEnabled:YES];
    [_s5 setUserInteractionEnabled:YES];
    
    [self addSubview:_s1];
    [self addSubview:_s2];
    [self addSubview:_s3];
    [self addSubview:_s4];
    [self addSubview:_s5];
    
    CGRect frame = [self frame];
    frame.size.width = width * 5.0f;
    frame.size.height = height;
    [self setFrame:frame];
    
}
/**
 *  获取当前的评分值
 *
 *  @return 评分值
 */
-(CGFloat)rating{
    return starRating;
}

- (void)setUpRating:(CGFloat)rating
{
    [_s1 setImage:unSelectedImage];
    [_s2 setImage:unSelectedImage];
    [_s3 setImage:unSelectedImage];
    [_s4 setImage:unSelectedImage];
    [_s5 setImage:unSelectedImage];
    
    //    if (rating >= 0.5) {
    //        [_s1 setImage:halfSelectedImage];
    //    }
    if (rating >= 1) {
        [_s1 setImage:fullSelectedImage];
    }
    //    if (rating >= 1.5) {
    //        [_s2 setImage:halfSelectedImage];
    //    }
    if (rating >= 2) {
        [_s2 setImage:fullSelectedImage];
    }
    //    if (rating >= 2.5) {
    //        [_s3 setImage:halfSelectedImage];
    //    }
    if (rating >= 3) {
        [_s3 setImage:fullSelectedImage];
    }
    //    if (rating >= 3.5) {
    //        [_s4 setImage:halfSelectedImage];
    //    }
    if (rating >= 4) {
        [_s4 setImage:fullSelectedImage];
    }
    //    if (rating >= 4.5) {
    //        [_s5 setImage:halfSelectedImage];
    //    }
    if (rating >= 5) {
        [_s5 setImage:fullSelectedImage];
    }
    
    starRating = rating;
    lastRating = rating;
    
}
/**
 *  设置评分值
 *
 *  @param rating 评分值
 */
-(void)displayRating:(CGFloat)rating
{
    [self setUpRating:rating];
   
    if ([_delegate respondsToSelector:@selector(ratingChanged:)]) {
        [_delegate ratingChanged:rating];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isIndicator) {
        return;
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width) + 1;
    if (newRating > 5)
        return;
    
    if (point.x < 0) {
        newRating = 0;
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.isIndicator) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    int newRating = (int) (point.x / width) + 1;
    if (newRating > 5)
        return;
    
    if (point.x < 0) {
        newRating = 0;
    }
    
    if (newRating != lastRating){
        [self displayRating:newRating];
    }
}
@end
