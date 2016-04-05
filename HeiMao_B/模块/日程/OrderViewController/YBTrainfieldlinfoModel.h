//
//  YBTrainfieldlinfoModel.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBTrainfieldlinfoModel : NSObject
/*
 "trainfieldlinfo":
 {
 "name": "海淀练场",
 "id": "561636cc21ec29041a9af88e"
 }

 */
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ID;
+ (YBTrainfieldlinfoModel *)converJsonDicToModel:(NSDictionary *)dic;
@end
