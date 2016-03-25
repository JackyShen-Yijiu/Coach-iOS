//
//  PFActionSheetView.h
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PFActionSheetViewCompletion)(NSUInteger selectedOtherButtonIndex);

@interface PFActionSheetView : NSObject
+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
         cancelButtonTitle:(NSString *)cancelButtonTitle
         otherButtonTitles:(NSArray *)otherButtonTitles
                    withVc:(UIViewController *)vc
                completion:(PFActionSheetViewCompletion)completion;

@end
