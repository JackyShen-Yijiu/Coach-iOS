//
//  QueryViewController.h
//  HeiMao_B
//
//  Created by bestseller on 15/11/9.
//  Copyright © 2015年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QueryViewControllerDelegate <NSObject>

- (void)senderData:(NSDictionary *)dic;

@end
@interface QueryViewController : UIViewController
@property (weak, nonatomic) id<QueryViewControllerDelegate>delegate;
@end
