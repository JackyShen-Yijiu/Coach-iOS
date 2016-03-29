//
//  ViewController.h
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LKAddStudentTimeViewController : UITableViewController
/// 开始时间
@property(nonatomic,copy)NSString *starTimeText;
/// 结束时间
@property (nonatomic ,copy) NSString *finishTimeText;


@end

