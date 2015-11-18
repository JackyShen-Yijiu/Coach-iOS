//
//  TeachSubjectViewController.m
//  HeiMao_B
//
//  Created by bestseller on 15/11/16.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "TeachSubjectViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
@interface TeachSubjectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *upDateArray;

@end

@implementation TeachSubjectViewController
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
    self.title = @"可授科目";
    self.view.backgroundColor = RGB_Color(245, 247, 250);
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.dataArray = @[@"科目一",@"科目二",@"科目三",@"科目四"];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}
- (void)clickRight:(UIButton *)sender {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (NSNumber *num in self.upDateArray) {
        if (num.integerValue == 2) {
            NSDictionary *dic = @{@"subjectid":@"2",@"name":@"科目二"};

            [dataArray addObject:[JsonTransformManager dictionaryTransformJsonWith:dic]];
        }else if (num.integerValue == 3) {
            NSDictionary *dic = @{@"subjectid":@"3",@"name":@"科目三"};
            [dataArray addObject:[JsonTransformManager dictionaryTransformJsonWith:dic]];
        }
    }
    NSString *url = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"subject":dataArray};
    [JENetwoking startDownLoadWithUrl:url postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
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
    cell.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect"] forState:UIControlStateNormal];
    button.tag = 100 + indexPath.row;
    [button setBackgroundImage:[UIImage imageNamed:@"cancelSelect_click"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    [self.buttonArray addObject:button];
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.textLabel.textColor = TEXTGRAYCOLOR;
        button.userInteractionEnabled = NO;
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    for (UIButton *b in self.buttonArray) {
        if (b.tag == indexPath.row + 100) {
            if (b.selected == YES) {
                b.selected = NO;
                
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row+1];
                [self.upDateArray removeObject:num];
                
            }else if (b.selected == NO) {
                b.selected = YES;
                NSNumber *num = [NSNumber numberWithInteger:indexPath.row+1];
                [self.upDateArray addObject:num];
                
            }
        }
    }
    
    
}
- (void)clickButton:(UIButton *)sender {

}
@end
