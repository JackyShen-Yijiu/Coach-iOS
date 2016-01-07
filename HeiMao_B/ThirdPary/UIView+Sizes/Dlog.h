//
//  Dlog.h
//  IPTV
//
//  Created by shede333 on 12-6-21.
//  Copyright (c) 2012年 . All rights reserved.
//  调试信息打印（Debug时打印信息，生成Release版本时屏蔽打印信息）

//Dlog displays when debug

#ifndef SWCommonFrame_Dlog_h
#define SWCommonFrame_Dlog_h

#ifdef DEBUG
    #ifndef _DLog
        #define _DLog(fmt, ...)
    #endif
#else
    #ifndef _DLog
        #define _DLog(...)
    #endif
#endif

#define DLog(fmt, ...) _DLog(@"\n# " fmt, ##__VA_ARGS__)
#define DVLog(fmt, ...) _DLog(@"\n* %s \n* %s \n* [Line %d]\n# " fmt, __FILE__, __func__, __LINE__, ##__VA_ARGS__)
#define DFuncLog DVLog(@"")
#define DTLog(exception) _DLog(@"try-reason:%@,",exception.reason)

#define DLogInt(intValue) DLog(#intValue@":%d",intValue)
#define DLogFloat(floatValue) DLog(#floatValue@":%f",floatValue)
#define DLogObj(objValue) DLog(#objValue@":%@",objValue)

#define DVLogInt(intValue) DVLog(#intValue@":%d",intValue)
#define DVLogFloat(floatValue) DVLog(#floatValue@":%f",floatValue)
#define DVLogObj(objValue) DVLog(#objValue@":%@",objValue)

#define ALog(fmt, ...) NSLog((@"Alog:%s-" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__)

#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif




#endif