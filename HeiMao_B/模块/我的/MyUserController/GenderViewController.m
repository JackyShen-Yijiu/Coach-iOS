//
//  GenderViewController.m
//  BlackCat
//
//  Created by bestseller on 15/10/6.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "GenderViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "ToolHeader.h"
//static NSString *const kupdateUserInfo = @"userinfo/updatecoachinfo";

@interface GenderViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) UITextField *genderTextField;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) UIButton *naviBarLeftButton;

@end

@implementation GenderViewController

- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@"男",@"女"];
    }
    return _dataArray;
}
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _pickerView;
}
- (UITextField *)genderTextField {
    if (_genderTextField == nil) {
        _genderTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, kSystemWide, 44)];
        _genderTextField.backgroundColor = [UIColor whiteColor];
    }
    return _genderTextField;
}

- (UIButton *)naviBarLeftButton {
    if (_naviBarLeftButton == nil) {
        _naviBarLeftButton = [WMUITool initWithTitle:@"取消" withTitleColor:MAINCOLOR withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarLeftButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarLeftButton addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarLeftButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.title = @"性别";
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    self.view.backgroundColor = RGBColor(245, 247, 250);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarLeftButton];
//    self.navigationItem.leftBarButtonItem = leftItem;

    
    [self.view addSubview:self.genderTextField];
    self.genderTextField.inputView = self.pickerView;
    [self.genderTextField becomeFirstResponder];

}
- (void)clickLeft:(UIButton *)sender {
    if (self.genderTextField.text == nil || self.genderTextField.text.length == 0) {
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickRight:(UIButton *)sender {
    DYNSLog(@"userid = %@",self.genderTextField.text);
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"Gender":self.genderTextField.text,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        if (!data) {
            [self showTotasViewWithMes:@"网络连接错误，请稍后再试"];
            return ;
        }
        

        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [UserInfoModel defaultUserInfo].Gender = self.genderTextField.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kGenderChange object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            if(msg){
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
                [alerview show];
            }
        }
   
    }];
    
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *resultString = self.dataArray[row];
    self.genderTextField.text = resultString;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserInfoModel defaultUserInfo].Gender) {
        self.genderTextField.text = [UserInfoModel defaultUserInfo].Gender;
        if ([self.dataArray.firstObject isEqualToString:self.genderTextField.text]) {
            [self.pickerView selectRow:0 inComponent:0 animated:YES];
        }else {
            [self.pickerView selectRow:1 inComponent:0 animated:YES];
        }
    }else {
        self.genderTextField.text = @"男";
    }
}
@end
