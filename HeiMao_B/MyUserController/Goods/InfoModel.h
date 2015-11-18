//
//  InfoModel.h
//  studentDriving
//
//  Created by ytzhang on 15/11/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject
@property (nonatomic,retain) NSString *mobile;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSArray *addresslist;

+ (instancetype)getInstance;
@end
