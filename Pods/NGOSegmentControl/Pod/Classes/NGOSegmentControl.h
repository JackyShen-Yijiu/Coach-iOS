//
//  NGOSegmentControl.h
//  andGo
//
//  Created by Stas Zhukovskiy on 11.04.15.
//  Copyright (c) 2015 Stas Zhukovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NGOSegmentControlSelected) {
    NGOSegmentControlSelectedNone,
    NGOSegmentControlSelectedLeft,
    NGOSegmentControlSelectedRight
};

@protocol NGOSegmentControlDelegate;

@interface NGOSegmentControl : UIView

@property (nonatomic) id <NGOSegmentControlDelegate>    delegate;
@property (nonatomic) NGOSegmentControlSelected         selectedButton;
@property (strong, nonatomic) UIFont                    *buttonTitleFont;
@property (strong, nonatomic) IBInspectable UIColor     *buttonTitleColor;
@property (strong, nonatomic) IBInspectable UIColor     *selectedBackgroundColor;
@property (strong, nonatomic) IBInspectable UIColor     *midSeparatorColor;
@property (strong, nonatomic) IBInspectable NSString    *firstSegmentText;
@property (strong, nonatomic) IBInspectable NSString    *secondSegmentText;

- (instancetype)initWithFirstSegmentText:(NSString *)first andSecondSegmentText:(NSString *)second;
- (void)setup;

@end


@protocol NGOSegmentControlDelegate <NSObject>

@required
- (void)segmentControl:(NGOSegmentControl *)segControl didChangeSelection:(NGOSegmentControlSelected)selection;

@end
