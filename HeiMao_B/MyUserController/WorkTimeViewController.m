//
//  WorkTimeViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "WorkTimeViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

static NSString *const kchangeWorkTime = @"userinfo/coachsetworktime";

@interface WorkTimeViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *upDateArray;
@property (strong, nonatomic) UITextField *beginTextField;
@property (strong, nonatomic) UITextField *endTextField;
@property (strong, nonatomic) UIDatePicker *timePicker;
@property (strong, nonatomic) UIDatePicker *timeTwoPicker;

@property (copy, nonatomic) NSString *beginString;
@property (copy, nonatomic) NSString *endString;

@end

@implementation WorkTimeViewController

- (UIDatePicker *)timeTwoPicker {
    if (_timeTwoPicker == nil) {
        _timeTwoPicker = [[UIDatePicker alloc] init];
        _timeTwoPicker.datePickerMode = UIDatePickerModeTime;
        [_timeTwoPicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _timeTwoPicker;
}
- (UIDatePicker *)timePicker {
    if (_timePicker == nil) {
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.datePickerMode = UIDatePickerModeTime;
        [_timePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        
        
    }
    return _timePicker;
}

- (UITextField *)beginTextField {
    if (_beginTextField == nil) {
        _beginTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 44)];
        _beginTextField.placeholder = @"  开始";
        _beginTextField.font = [UIFont systemFontOfSize:14];
        _beginTextField.delegate = self;
    }
    return _beginTextField;
}
- (UITextField *)endTextField {
    if (_endTextField == nil) {
        _endTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 44, kSystemWide, 44)];
        _endTextField.placeholder = @"  结束";
        _endTextField.font = [UIFont systemFontOfSize:14];
        _endTextField.delegate = self;
    }
    return _endTextField;
}

- (NSMutableArray *)upDateArray {
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工作时间";
    self.view.backgroundColor = RGB_Color(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.dataArray = @[@"工作日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    [self.view addSubview:self.tableView];
    
    
    
    self.tableView.tableFooterView = [self tableViewFootView];


}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.endTextField resignFirstResponder];
    [self.beginTextField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, -150, kSystemWide, kSystemHeight-64);
     }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, 0, kSystemWide, kSystemHeight-64);
    }];
}
- (UIView *)tableViewFootView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 88)];
    
    
    self.beginTextField.inputView = self.timePicker;
    self.beginTextField.inputView.tag = 100;
    self.endTextField.inputView = self.timeTwoPicker;
    self.endTextField.inputView.tag = 101;
    [view addSubview:self.beginTextField];
    [view addSubview:self.endTextField];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect"] forState:UIControlStateNormal];
    button.tag = 100 + indexPath.row;
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
//    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row != 0) {
        cell.accessoryView = button;
        cell.userInteractionEnabled = YES;

    }else {
        cell.userInteractionEnabled = NO;
    }
    [self.buttonArray addObject:button];
    
    return cell;
}
- (void)clickRight:(UIButton *)sender {
    NSString *urlString = [NSString stringWithFormat:BASEURL,kchangeWorkTime];
    NSMutableString *workweek = [[NSMutableString alloc] init];
    NSMutableString *worktimedesc = [[NSMutableString alloc] init];
    for (NSInteger i = 0; i<self.upDateArray.count; i++) {
        NSNumber *num = self.upDateArray[i];
        if (i == self.upDateArray.count - 1 ) {
           [workweek appendFormat:@"%@",num ];
            [worktimedesc appendFormat:@"周%@,",num];

        }else {
            [workweek appendFormat:@"%@,",num];
            [worktimedesc appendFormat:@"周%@",num];

        }
    }
    [worktimedesc appendFormat:@"%@--%@",self.beginTextField.text,self.endTextField.text];
//    ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:worktimedesc controller:self];
//    [alerview show];
    NSArray *first = [self.beginTextField.text componentsSeparatedByString:@":"];
    NSArray *second = [self.endTextField.text componentsSeparatedByString:@":"];
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"workweek":workweek,@"worktimedesc":worktimedesc,@"begintimeint":first.firstObject,@"endtimeint":second.firstObject};
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
    }];
}

- (void)timeChange:(UIDatePicker *)picker {
    NSDate *date = picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"H:00"];
    DYNSLog(@"tag = %ld",picker.tag);
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    if (picker.tag == 100) {
        self.beginTextField.text = destDateString;
    }else if (picker.tag == 101) {
        self.endTextField.text = destDateString;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.endTextField resignFirstResponder];
    [self.beginTextField resignFirstResponder];
    for (UIButton *b in self.buttonArray) {
        if (b.tag == indexPath.row + 100) {
            if (b.selected == YES) {
                b.selected = NO;
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.textLabel.textColor = [UIColor blackColor];
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row];
                [self.upDateArray removeObject:num];

            }else if (b.selected == NO) {
                b.selected = YES;
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.textLabel.textColor = kDefaultTintColor;
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row];
                [self.upDateArray addObject:num];

            }
        }
    }

   
}



@end
