//
//  InfoModel.m
//  studentDriving
//
//  Created by ytzhang on 15/11/14.
//  Copyright © 2015年 jatd. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


#pragma mark -
#pragma mark Singleton Definition

static id instance = nil;

+ (instancetype)getInstance
{
    @synchronized(self){
        if (!instance) {
            instance = [[self alloc] init];
        }
    }
    
    return instance;
}

+ (instancetype)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    
    return instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return self;
}

@end
