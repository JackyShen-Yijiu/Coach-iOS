//
//  MagicAPIUrl.h
//  Magic
//
//  Created by ytzhang on 15/11/10.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#ifndef MagicAPIUrl_h
#define MagicAPIUrl_h


#pragma mark ------商品列表

#define kUrlEnabled 1

#if kUrlEnabled 
      #define shopListAPI @"getmailproduct"
#else
#define  shopListAPI @"http://101.200.204.240:8181/api/v1/getmailproduct"
#endif

#endif /* MagicAPIUrl_h */
