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
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"保存" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"可授科目";
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray * subject = [[UserInfoModel defaultUserInfo] subject];
    [self.upDateArray removeAllObjects];
    for (NSDictionary * info in subject) {
        NSNumber * number = [info objectForKey:@"subjectid"];
        if (number)
            [self.upDateArray addObject:number];
    }
    [self.tableView reloadData];

}

- (void)clickRight:(UIButton *)sender {
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    BOOL isCotainNum2 = NO;
    BOOL isContainNum3 = NO;
    for (NSNumber *num in self.upDateArray) {
        if (num.integerValue == 2) {
            isCotainNum2 = YES;
          
        }else if (num.integerValue == 3) {
            isContainNum3 = YES;
         
        }
    }
    if (isCotainNum2) {
        NSDictionary *dic = @{@"subjectid":@"2",@"name":@"科目二"};
        [dataArray addObject:dic];
    }
    if (isContainNum3) {
        NSDictionary *dic = @{@"subjectid":@"3",@"name":@"科目三"};
        [dataArray addObject:dic];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kupdateUserInfo];
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"subject":[dataArray JSONString]};
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [JENetwoking startDownLoadWithUrl:url postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        if (!data) {
            [self showTotasViewWithMes:@"网络异常，请稍后再试"];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

            return ;
        }
        
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];

        if (messege.intValue == 1) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            
            NSArray * subject = [dataParam objectArrayForKey:@"subject"];

                [[UserInfoModel defaultUserInfo] setSubject:subject];
                [self showTotasViewWithMes:@"设置成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kteachSubjectKey object:nil];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
            if (msg.length)
                [self showTotasViewWithMes:msg];
        }
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
//    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (cell == nil) {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.userInteractionEnabled = YES;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 15, 15);
    [button setBackgroundImage:[UIImage imageNamed:@"JZCoursechoose"] forState:UIControlStateNormal];
    button.tag = 100 + indexPath.row;
    [button setBackgroundImage:[UIImage imageNamed:@"JZCoursesure"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    [self.buttonArray addObject:button];
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.textLabel.textColor = TEXTGRAYCOLOR;
        [button setHidden:YES];
    }else {
        [button setHidden:NO];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    [button setSelected:[self hasSeleted:indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0 || indexPath.row == 3) {
        return;
    }
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

- (BOOL)hasSeleted:(NSInteger)indexRow
{
    for (NSNumber * value in self.upDateArray) {
        if ([value integerValue] - 1 == indexRow) {
            return YES;
        }
    }
    return NO;
}

- (void)clickButton:(UIButton *)sender {

}
@end
