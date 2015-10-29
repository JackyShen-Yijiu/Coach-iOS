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

typedef NS_ENUM(NSInteger, KCourseStatue){
    KCourseStatueInvalid =0,
    KCourseStatueRequest,   //请求，等待教练通过
    KCourseStatueUnderWay,  //进行中
    KCourseStatueWatingToDone, //等待教练确定课程完成
    KCourseStatueOnDone,    //教练确定完成，等待评论
    KCourseStatueOnCommended, //评论成功
    KCourseStatueCanceld      //教练取消
};

