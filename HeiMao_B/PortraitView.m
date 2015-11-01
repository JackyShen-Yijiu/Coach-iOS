//
//  PortraitImageView.m
//  POIDemonConroller
//
//  Created by quke on 14-4-22.
//  Copyright (c) 2014年 quke. All rights reserved.
//

#import "PortraitView.h"

@interface PortraitView()
{
    UIImageView * _bgView;
}
@end

@implementation PortraitView
@synthesize imageView = _imageView;

- (void)dealloc
{
    [self.imageView removeObserver:self forKeyPath:@"image"];
    [self removeObserver:self forKeyPath:@"frame"];
    
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:NO];
        self.clipsToBounds = YES;
        self.porContentModel = KPortraitViewContentModelScaleToFill;
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
        UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_imageView];
        [self.imageView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }
    return self;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (!self.imageView.image) return;
    CGSize size = [self getRectofProtrait:self.imageView.image];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    self.imageView.center = CGPointMake(self.frame.size.width /2.f, self.frame.size.height /2.f);
    [CATransaction commit];   
}

- (CGSize)getRectofProtrait:(UIImage *)image
{
    CGFloat width = self.frame.size.width;
    CGFloat higth = self.frame.size.height;
    CGSize size = image.size;
    CGFloat scale = 1.f;

    switch (self.porContentModel) {
        case KPortraitViewContentModelScaleToFill:
        {
            if (size.width < width || size.height < higth) {
                //放大
                scale  = MAX(width / size.width, higth / size.height);
                size.width *= scale;
                size.height *= scale;
            }else{
                scale = MIN(size.width / width, size.height / higth);
                size.width /= scale;
                size.height /= scale;
            }
        }
            break;
        case KPortraitViewContentModelScaleAndCenterToFill:
        {
            if (size.width > width || size.height > higth) {
                scale = MAX(size.width / width, size.height / higth);
                size.width /= scale;
                size.height /= scale;
            }
            
            //最小展示是原图的一半大小标准
            width *= 0.6;
            higth *= 0.6;
            if (size.width < width || size.height < higth){
                //放大
                scale  = MIN(width / size.width, higth / size.height);
                size.width *= scale;
                size.height *= scale;
            }
        }
            break;
        default:
            break;
    }

    return size;
}


- (void)setBackgroundImage:(UIImage *)image
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_bgView];
        [self sendSubviewToBack:_bgView];
    }
    _bgView.image = image;
}
@end
