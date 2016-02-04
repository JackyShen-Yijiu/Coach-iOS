//
//  YBSignUpStuentListModelRootClass.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBSignUpStuentListModelRootClass : NSObject
@property (nonatomic, strong) NSArray *data;

- (instancetype)initWithJsonDict:(id)dictionary;

@end
