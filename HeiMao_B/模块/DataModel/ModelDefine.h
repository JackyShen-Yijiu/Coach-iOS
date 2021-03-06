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
    KCourseStatueapplying = 1,   // 预约中(新订单)-------"预约中"（待接受）
    KCourseStatueapplycancel = 2,// 学生取消（已取消)-------"学生取消"
    KCourseStatueapplyconfirm,  // 已确定(新订单)-------"新订单"（已接受）
    KCourseStatueapplyrefuse,      // 教练拒绝或者取消（已取消）-------"已取消"
    KCourseStatueunconfirmfinish, //  待确认完成(无此状态)-------"待确认完成"
    KCourseStatueucomments,    // 待评论(待评论)-------"待评论"
//    KCourseStatueOnCommended, // 评论成功（已完成）-------"评论成功"
    KCourseStatuefinish, // 订单完成（已完成）-------"订单完成"
    KCourseStatuesystemcancel, // 系统取消（已取消）-------"系统取消"
    KCourseStatuesignin, // 已签到(新订单)-------"已签到"
    KCourseStatuenosignin, // 未签到(已完成)-------"已漏课"
    
};


#pragma mark -- 对应APP首页顶部分类
//新订单:applying=1,
//待评论:ucomments:6,
//已取消:applycancel:2
//已完成:finish:7,

#pragma mark -- 对应APP界面显示
/*
 case  KCourseStatueInvalid :
 break;
 case  KCourseStatueapplying :   // 预约中
 return @"预约中";
 break;
 case  KCourseStatueapplycancel :// 学生取消
 return @"学生取消";
 break;
 case  KCourseStatueapplyconfirm:  // 已确定
 return @"新订单";
 break;
 case  KCourseStatueapplyrefuse:      // 教练（拒绝或者取消）
 return @"已取消";
 break;
 case  KCourseStatueunconfirmfinish: //  待确认完成  (v1.1 中没有该字段)
 return @"待确认完成";
 break;
 case  KCourseStatueucomments:    // 待评论
 return @"待评论";
 break;
 case  KCourseStatueOnCommended: // 评论成功
 return @"评论成功";
 break;
 case  KCourseStatuefinish: // 订单完成
 return @"订单完成";
 break;
 case  KCourseStatuesystemcancel: // 系统取消
 return @"系统取消";
 break;
 case  KCourseStatuesignin: // 已签到
 return @"已签到";
 break;
 case  KCourseStatuenosignin: // 未签到
 return @"已漏课";
 */

