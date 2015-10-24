//
//  PushTransition.m
//  JewelryApp
//
//  Created by kequ on 15/5/1.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

#define TRANSITION_DURATION 0.6f

#import "PushTransition.h"

@implementation PushTransition

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *container = transitionContext.containerView;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    CGFloat containerWidth = container.frame.size.width;
    
    // Set the needed frames to animate.
    
    CGRect toInitialFrame = [container frame];
    CGRect fromDestinationFrame = fromView.frame;
    
    if (self.operation == UINavigationControllerOperationPush)
    {
        toInitialFrame.origin.x = containerWidth;
        toView.frame = toInitialFrame;
        fromDestinationFrame.origin.x = -containerWidth;
    }
    else if (self.operation == UINavigationControllerOperationPop)
    {
        toInitialFrame.origin.x = -containerWidth;
        toView.frame = toInitialFrame;
        fromDestinationFrame.origin.x = containerWidth;
    }
    
    // Create a screenshot of the toView.
    UIView *move = [toView snapshotViewAfterScreenUpdates:YES];
    move.frame = toView.frame;
    [container addSubview:move];
    
    [UIView animateWithDuration:TRANSITION_DURATION delay:0
         usingSpringWithDamping:1000 initialSpringVelocity:1
                        options:0 animations:^{
                            move.frame = container.frame;
                            fromView.frame = fromDestinationFrame;
                        }
                     completion:^(BOOL finished) {
                         if (![[container subviews] containsObject:toView])
                         {
                             [container addSubview:toView];
                         }
                         
                         toView.frame = container.frame;
                         [fromView removeFromSuperview];
                         [move removeFromSuperview];
                         [transitionContext completeTransition: YES];
                     }
     ];
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return TRANSITION_DURATION;
}
@end
