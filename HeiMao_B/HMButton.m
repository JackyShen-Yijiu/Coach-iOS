//
//  HMButton.m
//  HeiMao_B
//
//  Created by kequ on 15/10/27.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMButton.h"

@implementation HMButton
-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (self.nBackColor && self.hBackColor) {
        self.backgroundColor = highlighted ? self.hBackColor : self.nBackColor;
    }

}

- (void)setHBackColor:(UIColor *)hBackColor
{
    _hBackColor = hBackColor;
    if (_hBackColor && self.isHighlighted) {
        self.backgroundColor = _hBackColor;
    }
}

- (void)setNBackColor:(UIColor *)nBackColor
{
    _nBackColor = nBackColor;
    if (_nBackColor && !self.isHighlighted) {
        self.backgroundColor = _nBackColor;
    }
}
@end
