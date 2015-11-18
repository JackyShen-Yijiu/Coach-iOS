//
//  MyWallet.h
//  studentDriving
//
//  Created by ytzhang on 15/11/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWallet : NSObject
@property (nonatomic,assign) int amount;
@property (nonatomic,assign) int type;
@property (nonatomic,assign) int seqindex;
@property (nonatomic,copy) NSString *createtime;
+ (instancetype)getInstance;
@end
