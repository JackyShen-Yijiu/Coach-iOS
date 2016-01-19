//
//  VacationViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "VacationViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
static NSString *const kVacationUrl = @"courseinfo/putcoachleave";
@interface VacationViewController ()
@property (strong, nonatomic) UILabel *beginLabel;
@property (strong, nonatomic) UITextField *beginStart;
@property (strong, nonatomic) UITextField *beginEnd;
@property (strong, nonatomic) UILabel *finalLabel;
@property (strong, nonatomic) UITextField *finalStart;
@property (strong, nonatomic) UITextField *finalEnd;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIDatePicker *dateTwoPicker;

@property (strong, nonatomic) UIDatePicker *timePicker;
@property (strong, nonatomic) UIDatePicker *timeTwoPicker;

@property (strong, nonatomic) UIButton *naviBarRightButton;

@property (strong, nonatomic) NSString *timeMarkBegin;
@property (strong, nonatomic) NSString *timeMarkEnd;
@end

@implementation VacationViewController
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minuteInterval = 30.f;
        _datePicker.minimumDate = [NSDate date];
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}
- (UIDatePicker *)dateTwoPicker {
    if (_dateTwoPicker == nil) {
        _dateTwoPicker = [[UIDatePicker alloc] init];
        _dateTwoPicker.datePickerMode = UIDatePickerModeDate;
        _dateTwoPicker.minuteInterval = 30.f;
        _dateTwoPicker.minimumDate = [NSDate date];
        [_dateTwoPicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _dateTwoPicker;
}
- (UIDatePicker *)timeTwoPicker {
    if (_timeTwoPicker == nil) {
        _timeTwoPicker = [[UIDatePicker alloc] init];
//        _timeTwoPicker.minuteInterval = 30.f;
//        _dateTwoPicker.minimumDate = [NSDate date];
        _timeTwoPicker.datePickerMode = UIDatePickerModeTime;
        [_timeTwoPicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];

    }
    return _timeTwoPicker;
}
- (UIDatePicker *)timePicker {
    if (_timePicker == nil) {
        _timePicker = [[UIDatePicker alloc] init];
        _timePicker.datePickerMode = UIDatePickerModeTime;
//        _timePicker.minuteInterval = 30.f;
//        _timePicker.minimumDate = [NSDate date];
        [_timePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _timePicker;
}
- (UILabel *)beginLabel {
    if (_beginLabel == nil) {
        _beginLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:12]];
        _beginLabel.text = @"开始";
    }
    return _beginLabel;
}
- (UILabel *)finalLabel {
    if (_finalLabel == nil) {
        _finalLabel = [WMUITool initWithTextColor:TEXTGRAYCOLOR withFont:[UIFont systemFontOfSize:12]];
        _finalLabel.text = @"结束";
        
    }
    return _finalLabel;
}
- (UITextField *)beginStart {
    if (_beginStart == nil) {
        _beginStart = [[UITextField alloc] init];
        _beginStart.placeholder = @"  日期";
        _beginStart.backgroundColor = [UIColor whiteColor];
    }
    return _beginStart;
}
- (UITextField *)beginEnd {
    if (_beginEnd == nil) {
        _beginEnd = [[UITextField alloc] init];
        _beginEnd.placeholder = @"  时间";
        _beginEnd.backgroundColor = [UIColor whiteColor];

    }
    return _beginEnd;
}
- (UITextField *)finalStart {
    if (_finalStart == nil) {
        _finalStart = [[UITextField alloc] init];
        _finalStart.placeholder = @"  日期";
        _finalStart.backgroundColor = [UIColor whiteColor];

    }
    return _finalStart;
}
- (UITextField *)finalEnd {
    if (_finalEnd == nil) {
        _finalEnd = [[UITextField alloc] init];
        _finalEnd.placeholder = @"  时间";
        _finalEnd.backgroundColor = [UIColor whiteColor];

    }
    return _finalEnd;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"休假";
    self.view.backgroundColor = RGB_Color(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.beginLabel];
    [self.view addSubview:self.beginStart];
    self.beginStart.inputView = self.datePicker;
    self.beginStart.inputView.tag = 100;
    [self.view addSubview:self.beginEnd];
    self.beginEnd.inputView = self.timePicker;
    self.beginEnd.inputView.tag = 100;

    [self.view addSubview:self.finalLabel];
    [self.view addSubview:self.finalStart];
    self.finalStart.inputView = self.dateTwoPicker;
    self.finalStart.inputView.tag = 101;

    [self.view addSubview:self.finalEnd];
    self.finalEnd.inputView = self.timeTwoPicker;
    self.finalEnd.inputView.tag = 101;

    
    [self.beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.view.mas_top).offset(18);
    }];
    [self.beginStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.top.mas_equalTo(self.beginLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(@44);
    }];
    [self.beginEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);

        make.top.mas_equalTo(self.beginStart.mas_bottom).offset(0);
        make.height.mas_equalTo(@44);

    }];
    [self.finalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.top.mas_equalTo(self.beginEnd.mas_bottom).offset(13);
    }];
    [self.finalStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(self.finalLabel.mas_bottom).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(0);

        make.height.mas_equalTo(@44);

    }];
    [self.finalEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.top.mas_equalTo(self.finalStart.mas_bottom).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(@44);

    }];
    
}
- (void)dateChange:(UIDatePicker *)picker {
    NSDate *date = picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    DYNSLog(@"tag = %ld",picker.tag);
    if (picker.tag == 100) {
        self.beginStart.text = destDateString;
        
    }else if (picker.tag == 101) {
        self.finalStart.text = destDateString;
    }
    
}
- (void)timeChange:(UIDatePicker *)picker {
    
    NSDate *date = picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"HH:mm"];
    DYNSLog(@"tag = %ld",picker.tag);

    NSString *destDateString = [dateFormatter stringFromDate:date];
    if (picker.tag == 100) {
        self.beginEnd.text = destDateString;
    }else if (picker.tag == 101) {
        self.finalEnd.text = destDateString;
    }
}
- (void)clickRight:(UIButton *)sender {
    
    if (self.beginStart.text == nil || self.beginStart.text.length == 0) {
        return;
    }
    
    if (self.beginEnd.text == nil || self.beginEnd.text.length == 0) {
        return;
    }
    
    if (self.finalStart.text == nil || self.finalStart.text.length == 0) {
        return;
    }
    
    if (self.finalEnd.text == nil || self.finalEnd.text.length == 0) {
        return;
    }
    
    NSString *begin = [NSString stringWithFormat:@"%@ %@",self.beginStart.text,self.beginEnd.text];
    NSString *end = [NSString stringWithFormat:@"%@ %@",self.finalStart.text,self.finalEnd.text];
    
    NSDateFormatter *dateFormatter =  [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSDate *beginDate = [dateFormatter dateFromString:begin];
    NSDate *endDate = [dateFormatter dateFromString:end];
    
    NSString *beginString = [NSString stringWithFormat:@"%lld", (long long)[beginDate timeIntervalSince1970]];
    NSString *endString = [NSString stringWithFormat:@"%lld", (long long)[endDate timeIntervalSince1970]];
//    ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:beginString controller:self];
//    [alerview show];
    if ([beginDate timeIntervalSince1970] >= [endDate timeIntervalSince1970]) {
        [self showTotasViewWithMes:@"结束时间必须大于开始时间"];
        return;
    }
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kVacationUrl];
    
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"begintime":beginString,@"endtime":endString};
    
    [JENetwoking startDownLoadWithUrl:urlstring postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyVacation" object:self];
            
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
            [alerview show];
        }
    }];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
