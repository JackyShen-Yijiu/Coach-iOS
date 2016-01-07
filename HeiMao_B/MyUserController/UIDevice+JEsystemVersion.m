//
//  UIDevice+JEsystemVersion.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "UIDevice+JEsystemVersion.h"

@implementation UIDevice (JEsystemVersion)
+ (float)jeSystemVersion {
    return [self currentDevice].systemVersion.floatValue;
}

@end
