//
//  YBSignUpStudentListCell.h
//  HeiMao_B
//
//  Created by ytzhang on 16/2/4.
//  Copyright © 2016年 ke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBSignUpStuentListModel.h"

typedef void (^CallStudent)(UIButton *);

@interface YBSignUpStudentListCell : UITableViewCell

@property (nonatomic, strong) CallStudent callStudent;
@property (nonatomic, strong) YBSignUpStuentListModel *signUpStudentModel;
@end
