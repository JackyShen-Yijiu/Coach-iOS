//
//  PushTransition.h
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)UINavigationControllerOperation operation;
@end
