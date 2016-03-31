//
//  ViewController.h
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LKAddStudentTimeViewController : UIViewController

/// 顶部时间view数组
@property (nonatomic, strong) NSArray *dataArray;

/// 总共的名额
@property (nonatomic, assign) NSInteger courseStudentCountInt;

/// 已约名额
@property (nonatomic, assign) NSInteger selectedstudentconutInt;

///  教练id
@property (nonatomic, strong) NSString *coachidStr;
#pragma mark - 加载数据
@property (nonatomic, strong) NSMutableDictionary *studentDataM;

/// 课程id列表
@property (nonatomic ,copy) NSString  *courseList;


@property (nonatomic, copy) NSString *UTCData;

/// 学员id
@property (nonatomic, strong) NSMutableString *userid;






@end

