//
//  ModelDefine.h
//  HeiMao_B
//
//  Created by kequ on 15/5/9.
//  Copyright (c) 2015年 jewelry. All rights reserved.
//

//刷新加载数据个数
#define RELOADDATACOUNT     10
//更多加载数据个数
#define LOADMOREDATACOUNT   20

typedef NS_ENUM(NSInteger, KOrderStatue){
    KOrderStatueInvalid,
    KOrderStatueRequest,
    KOrderStatueUnderWay,
    KOrderStatueOnDone,
    KOrderStatueOnCommended,
    KOrderStatueCanceld
};

