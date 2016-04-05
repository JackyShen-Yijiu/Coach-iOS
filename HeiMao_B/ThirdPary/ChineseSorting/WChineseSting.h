//
//  WChineseSting.h
//  iMoney
//
//  Created by wnngxzhibin on 15/6/28.
//  Copyright (c) 2015年 muqiapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"


@interface WChineseSting : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;



///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
