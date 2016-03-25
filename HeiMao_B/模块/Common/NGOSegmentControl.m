//
//  NGOSegmentControl.m
//  andGo
//
//  Created by Stas Zhukovskiy on 11.04.15.
//  Copyright (c) 2015 Stas Zhukovskiy. All rights reserved.
//

#import "NGOSegmentControl.h"

@interface NGOSegmentControl ()

@property (strong, nonatomic) UIButton *leftButton;
@property (strong, nonatomic) UIButton *rightButton;
@property (strong, nonatomic) UIView *midSeparator;

@end


@implementation NGOSegmentControl

#pragma mark - Init

- (instancetype)init {
    
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFirstSegmentText:(NSString *)first andSecondSegmentText:(NSString *)second {
    
    self.firstSegmentText   = (first) ? first : @"";
    self.secondSegmentText  = (second) ? second : @"";
    return self;
}

- (void)commonInit {
    
    self.selectedBackgroundColor    = [UIColor colorWithRed:0.471 green:0.831 blue:0.941 alpha:1];
    self.buttonTitleColor           = [UIColor blackColor];
    self.midSeparatorColor          = [UIColor lightGrayColor];
    self.firstSegmentText           = @"one";
    self.secondSegmentText          = @"two";
    self.buttonTitleFont            = [UIFont boldSystemFontOfSize:15];
    [self setup];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setup];
}

#pragma mark - Setters

- (void)setSelectedBackgroundColor:(UIColor *)newSelectedBackgroundColor {
    
    _selectedBackgroundColor = newSelectedBackgroundColor;
    [self setup];
}

- (void)setButtonTitleColor:(UIColor *)newButtonTitleColor {
    
    _buttonTitleColor = newButtonTitleColor;
    [self setup];
}

- (void)setMidSeparatorColor:(UIColor *)newMidSeparatorColor {
    
    _midSeparatorColor = newMidSeparatorColor;
    [self setup];
}

- (void)setFirstSegmentText:(NSString *)newFirstSegmentText {
    
    _firstSegmentText = newFirstSegmentText;
    [self setup];
}

- (void)setSecondSegmentText:(NSString *)newSecondSegmentText {
    
    _secondSegmentText = newSecondSegmentText;
    [self setup];
}

- (void)setButtonTitleFont:(UIFont *)newButtonTitleFont {
    
    _buttonTitleFont = newButtonTitleFont;
    [self setup];
}

#pragma mark - UI setup

- (void)setup {
    
    [self setupCornerRadius];
    [self setupLeftButton];
    [self setupRightButton];
    [self setupMidSeparator];
    [self setupButtonBackgrounds];
}

- (void)setupCornerRadius {
    
    self.layer.cornerRadius             = CGRectGetHeight(self.frame) / 2;
    self.layer.masksToBounds            = YES;
    self.layer.allowsEdgeAntialiasing   = YES;
}

- (void)setupLeftButton {
    
    [self.leftButton removeFromSuperview];
    self.leftButton         = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame;
    frame.origin            = CGPointMake(0, 0);
    frame.size.width        = CGRectGetWidth(self.frame) / 2;
    frame.size.height       = CGRectGetHeight(self.frame);
    self.leftButton.frame   = frame;
    [self addSubview:self.leftButton];
    
    [self.leftButton removeTarget:nil
                           action:NULL
                 forControlEvents:UIControlEventAllEvents];
    [self.leftButton addTarget:self
                        action:@selector(leftButtonPressed:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.leftButton setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
    [self.leftButton setTitle:self.firstSegmentText forState:UIControlStateNormal];
    self.leftButton.titleLabel.font = self.buttonTitleFont;
    
}

- (void)setupRightButton {
    
    [self.rightButton removeFromSuperview];
    self.rightButton        = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame;
    frame.origin.x          = CGRectGetWidth(self.frame) / 2;
    frame.origin.y          = 0;
    frame.size.width        = CGRectGetWidth(self.frame) / 2;
    frame.size.height       = CGRectGetHeight(self.frame);
    self.rightButton.frame  = frame;
    [self addSubview:self.rightButton];
    
    [self.rightButton removeTarget:nil
                            action:NULL
                  forControlEvents:UIControlEventAllEvents];
    [self.rightButton addTarget:self
                         action:@selector(rightButtonPressed:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.rightButton setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
    [self.rightButton setTitle:self.secondSegmentText forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = self.buttonTitleFont;
}

- (void)setupMidSeparator {
    
    [self.midSeparator removeFromSuperview];
    CGFloat sepWidth    = 1 / [UIScreen mainScreen].scale;
    CGRect frame;
    frame.origin.x      = (CGRectGetWidth(self.frame) / 2) - (sepWidth / 2);
    frame.origin.y      = 0;
    frame.size.width    = sepWidth;
    frame.size.height   = CGRectGetHeight(self.frame);
    self.midSeparator   = [[UIView alloc] initWithFrame:frame];
    [self addSubview:self.midSeparator];
    
    self.midSeparator.backgroundColor = self.midSeparatorColor;
}

- (void)setupButtonBackgrounds {
    
    if (self.selectedButton == NGOSegmentControlSelectedLeft) {
        
        [self.leftButton setBackgroundColor:self.selectedBackgroundColor];
        [self.rightButton setBackgroundColor:[UIColor whiteColor]];
        self.midSeparator.alpha = 0;
    }
    else if (self.selectedButton == NGOSegmentControlSelectedRight) {
        
        [self.leftButton setBackgroundColor:[UIColor whiteColor]];
        [self.rightButton setBackgroundColor:self.selectedBackgroundColor];
        self.midSeparator.alpha = 0;
    }
    else {

        [self.leftButton setBackgroundColor:[UIColor whiteColor]];
        [self.rightButton setBackgroundColor:[UIColor whiteColor]];
        self.midSeparator.alpha = 1;
    }
}

#pragma mark - Button Actions

- (void)leftButtonPressed:(id)sender {
    
    self.selectedButton = NGOSegmentControlSelectedLeft;
    [self setup];
    
    if ([self.delegate respondsToSelector:@selector(segmentControl:didChangeSelection:)]) {
        [self.delegate segmentControl:self didChangeSelection:NGOSegmentControlSelectedLeft];
    }
}

- (void)rightButtonPressed:(id)sender {
    
    self.selectedButton = NGOSegmentControlSelectedRight;
    [self setup];
    
    if ([self.delegate respondsToSelector:@selector(segmentControl:didChangeSelection:)]) {
        [self.delegate segmentControl:self didChangeSelection:NGOSegmentControlSelectedRight];
    }
}

@end
