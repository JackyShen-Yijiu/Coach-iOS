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

@property (nonatomic, assign) NSInteger courseStudentCountInt;

///  教练id
@property (nonatomic, strong) NSString *coachidStr;
#pragma mark - 加载数据
@property (nonatomic, strong) NSMutableDictionary *studentDataM;

@end

