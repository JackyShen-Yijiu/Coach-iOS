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

typedef NS_ENUM(NSInteger,KCourseStatue){
    
    KCourseStatueInvalid = 0,
    KCourseStatueapplying = 1,   // 预约中(新订单)->1
    KCourseStatueapplycancel = 2,// 学生取消（已取消）
    KCourseStatueapplyconfirm,  // 已确定(新订单)
    KCourseStatueapplyrefuse,      // 教练拒绝或者取消（已取消）
    KCourseStatueunconfirmfinish, //  待确认完成------------无此状态
    KCourseStatueucomments,    // 待评论(待评论)
    KCourseStatueOnCommended, // 评论成功（已完成）
    KCourseStatuefinish, // 订单完成（已完成）
    KCourseStatuesystemcancel, // 系统取消（已取消）
    KCourseStatuesignin, // 已签到(新订单)->3
    KCourseStatuenosignin, // 未签到(已完成)

};

//对应APP界面分类：
//新订单:applyconfirm=3,  // 已确定
//待评论:ucomments:6,//待评论
//已取消:applycancel:2,// 学生取消
//已完成:finish:7,  // 订单完成
