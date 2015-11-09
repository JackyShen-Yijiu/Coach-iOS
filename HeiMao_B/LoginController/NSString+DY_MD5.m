//
//  NSString+DY_MD5.m
//  BlackCat
//
//  Created by bestseller on 15/9/25.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "NSString+DY_MD5.h"
#include <CommonCrypto/CommonDigest.h>

@implementation NSString (DY_MD5)
- (NSString *)DY_MD5
{
    NSData* inputData = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char outputData[CC_MD5_DIGEST_LENGTH];
    CC_MD5([inputData bytes], (unsigned int)[inputData length], outputData);
    
    NSMutableString* hashStr = [NSMutableString string];
    int i = 0;
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i)
        [hashStr appendFormat:@"%02x", outputData[i]];
    
    return hashStr;
}
@end
