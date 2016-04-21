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
@property (strong, nonatomic) UILabel * beginLabel;
@property (strong, nonatomic) UITextField *endTextField;
@property (nonatomic,strong ) UILabel * endLabel;
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
        _beginTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 40, 44)];
        _beginTextField.placeholder = @"开始";
        _beginTextField.font = [UIFont systemFontOfSize:14];
        _beginTextField.delegate = self;
    }
    return _beginTextField;
}
- (UILabel *)beginLabel
{
    if (_beginLabel == nil) {
        _beginLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 40, 44)];
        _beginLabel.text = @"点";
        _beginLabel.font = [UIFont systemFontOfSize:14];
    }
    return _beginLabel;
}

- (UITextField *)endTextField {
    if (_endTextField == nil) {
        _endTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 44, 40, 44)];
        _endTextField.placeholder = @"结束";
        _endTextField.font = [UIFont systemFontOfSize:14];
        _endTextField.delegate = self;
    }
    return _endTextField;
}
- (UILabel *)endLabel
{
    if (_endLabel == nil) {
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(55,44, 40, 44)];
        _endLabel.text = @"点";
        _endLabel.font = [UIFont systemFontOfSize:14];
    }
    return _endLabel;
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
    
    self.dataArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableViewFootView];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray * workWook = [[UserInfoModel defaultUserInfo] workweek];
    
    NSLog(@"viewWillAppear workWook:%@",workWook);
    
    if (workWook.count)
        [self.upDateArray addObjectsFromArray:workWook];
    
    self.beginTextField.text = [[UserInfoModel defaultUserInfo] beginTime];
    
    self.endTextField.text = [[UserInfoModel defaultUserInfo] endTime];
    
    [self.tableView reloadData];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.endTextField resignFirstResponder];
    [self.beginTextField resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (YBIphone5) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, -200, kSystemWide, kSystemHeight-64);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.tableView.frame = CGRectMake(0, -150, kSystemWide, kSystemHeight-64);
        }];
    }
    
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
    [view addSubview:self.beginLabel];
    [view addSubview:self.endTextField];
    [view addSubview:self.endLabel];
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
    [button setBackgroundImage:[UIImage imageNamed:@"JZCoursechoose"] forState:UIControlStateNormal];
    button.tag = 1000 + indexPath.row;
    [button setBackgroundImage:[UIImage imageNamed:@"JZCoursesure"] forState:UIControlStateSelected];
    [button setSelected:[self hasSeleted:indexPath.row]];
    
    cell.accessoryView = button;

    [self.buttonArray addObject:button];
    
    return cell;
}

- (BOOL)hasSeleted:(NSInteger)indexRow
{
    NSLog(@"hasSeleted self.upDateArray:%@",self.upDateArray);
    
    for (NSNumber * value in self.upDateArray) {
        if ([value integerValue] == indexRow) {
            return YES;
        }
    }
    return NO;
}

- (void)clickRight:(UIButton *)sender {
    
    
    if (self.endTextField.text.length != 0 && self.beginTextField.text.length == 0){
        [self showTotasViewWithMes:@"起始时间不能为空"];
        return;
    }
    if (self.beginTextField.text.length != 0 && self.endTextField.text.length == 0) {
        //时间不能一个为空
        [self showTotasViewWithMes:@"结束时间不能为空"];
        return;
    }
 
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kchangeWorkTime];
    
    NSMutableString *workweek = [[NSMutableString alloc] init];
    
    NSLog(@"--self.upDateArray:%@",self.upDateArray);

    for (NSInteger i = 0; i<self.upDateArray.count; i++) {
        
        NSNumber *num = self.upDateArray[i];

        if (i==self.upDateArray.count-1){
            [workweek appendFormat:@"%@",num];
        }else{
            [workweek appendFormat:@"%@,",num];
        }
        
    }
    
    NSLog(@"++self.upDateArray:%@",self.upDateArray);
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (self.upDateArray.count) {
        [dic setValue:self.upDateArray forKey:@"weekList"];
    }
    NSString * workDes = [dic JSONString];
    if (!workDes) {
        workDes = @"";
    }

    NSArray *first = [self.beginTextField.text componentsSeparatedByString:@":"];
    NSArray *second = [self.endTextField.text componentsSeparatedByString:@":"];
    
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"workweek":workweek,@"worktimedesc":workDes,@"begintimeint":first.firstObject,@"endtimeint":second.firstObject};
    NSLog(@"param:%@",param);
    
    

    if (self.beginTextField.text>self.endTextField.text) {
        
        [self showTotasViewWithMes:@"开始时间不得大于结束时间"];
        
        return ;
    }else {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        WS(ws);
        [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            if (messege.intValue == 1) {
                [self showTotasViewWithMes:@"设置成功"];
                [UserInfoModel defaultUserInfo].workweek = [ws upDateArray];
                [UserInfoModel defaultUserInfo].beginTime = [first firstObject];
                [UserInfoModel defaultUserInfo].endTime = [second firstObject];
                [[NSNotificationCenter defaultCenter] postNotificationName:kworktimeChange object:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [self showTotasViewWithMes:msg];
            }
        }];
    }
    
    
   
}

- (void)timeChange:(UIDatePicker *)picker {
    NSDate *date = picker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"H"];
    
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
        
        if (b.tag == indexPath.row + 1000) {
            
            if (b.selected == YES) {
                
                b.selected = NO;
//                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//                cell.textLabel.textColor = [UIColor blackColor];
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row];
                [self.upDateArray removeObject:num];

            }else if (b.selected == NO) {
                
                b.selected = YES;
//                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//                cell.textLabel.textColor = kDefaultTintColor;
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row];
                [self.upDateArray addObject:num];

            }
        }
    }
    
    NSLog(@"didSelect self.upDateArray:%@",self.upDateArray);
    
}



@end
