//
//  InformationMessageModelRootClass.h
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InformationMessageModelRootClass : NSObject
@property (nonatomic, strong) NSArray *data;

- (instancetype)initWithJsonDict:(id)dictionary;

@end
