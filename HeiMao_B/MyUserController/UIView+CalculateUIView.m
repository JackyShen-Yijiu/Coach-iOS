//
//  UIView+CalculateUIView.m
//  BlackCat
//
//  Created by bestseller on 15/9/15.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "UIView+CalculateUIView.h"

@implementation UIView (CalculateUIView)
- (CGFloat)calculateFrameWithX {
    return  self.frame.origin.x;
}
- (CGFloat)calculateFrameWithY {
    return self.frame.origin.y;
}
- (CGFloat)calculateFrameWithWide {
    return self.frame.size.width;
}
- (CGFloat)calculateFrameWithHeight {
    return self.frame.size.height;
}
@end
