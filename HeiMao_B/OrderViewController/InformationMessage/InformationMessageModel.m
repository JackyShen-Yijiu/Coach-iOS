//
//  InformationMessageModel.m
//  HeiMao_B
//
//  Created by ytzhang on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "InformationMessageModel.h"

@implementation InformationMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _newsid = [dictionary objectStringForKey:@"newsid"];
        _title = [dictionary objectStringForKey:@"title"];
        _logimg = [dictionary objectStringForKey:@"logimg"];
        _descriptionString = [dictionary objectStringForKey:@"description"];
        _contenturl = [dictionary objectStringForKey:@"contenturl"];
        _createtime = [dictionary objectStringForKey:@"createtime"];
        _seqindex = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"seqindex"]];
        _newstype = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"newstype"]];
    }
    return self;
}

@end
