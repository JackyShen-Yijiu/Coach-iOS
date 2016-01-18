//
//  SetupViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "SetupViewController.h"
#import "ToolHeader.h"
#import "UIDevice+JEsystemVersion.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "NSUserStoreTool.h"
#import "APService.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

static NSString *const kSettingUrl = @"userinfo/personalsetting";


@interface SetupViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation SetupViewController
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"预约提醒",@"新消息通知",@"自动接收预约"],@[@"关于我们",@"去评分",@"反馈"]];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBColor(245, 247, 250);
    }
    return _tableView;
}

- (UIButton *)tableFootView {
    UIButton *quit = [UIButton buttonWithType:UIButtonTypeCustom];
    quit.backgroundColor = [UIColor whiteColor];
    [quit setTitle:@"退出" forState:UIControlStateNormal];
    quit.titleLabel.font = [UIFont systemFontOfSize:14];
    [quit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    quit.frame = CGRectMake(0, 0, kSystemWide, 44);
    [quit addTarget:self action:@selector(clickQuit:) forControlEvents:UIControlEventTouchUpInside];
    return quit;
    
}

- (void)clickQuit:(UIButton *)sender {
    
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController *  alerContr = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertView * view = [[UIAlertView alloc] init];
        view.tag = 200;
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self alertView:view clickedButtonAtIndex:0];
        }];
        
        [alerContr addAction:cancelAction];
        
        UIAlertAction * ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self alertView:view clickedButtonAtIndex:1];
        }];
        
        [alerContr addAction:ensureAction];
        [self presentViewController:alerContr animated:YES completion:nil];
        
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确定退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 200;
        alertView.delegate = self;
        [alertView show];
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 200 && buttonIndex == 1){
        
        //退出登陆
        [[UserInfoModel defaultUserInfo] loginOut];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        NSSet *set = [NSSet setWithObject:JPushTag];
        [APService setTags:set alias:@"" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
    }
}

//取消别名标示
- (void)tagsAliasCallback:(int)iResCode
                     tags:(NSSet *)tags
                    alias:(NSString *)alias {
    NSString *callbackString =
    [NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
     tags, alias];
    
    DYNSLog(@"TagsAlias回调:%@", callbackString);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [self tableFootView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBColor(245, 247, 250);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 3;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
        switchControl.onTintColor = kDefaultTintColor;
        switchControl.tag = 100 + indexPath.row;
        if (indexPath.row == 0) {
            if ([NSUserStoreTool getObjectWithKey:@"reservationreminder"]) {
                NSNumber *num = [NSUserStoreTool getObjectWithKey:@"reservationreminder"];
                switchControl.on = num.intValue;
            }else {
                switchControl.on = YES;
                
            }
        }else if (indexPath.row == 1) {
            if ([NSUserStoreTool getObjectWithKey:@"newmessagereminder"]) {
                NSNumber *num = [NSUserStoreTool getObjectWithKey:@"newmessagereminder"];
                switchControl.on = num.intValue;
            }else {
                switchControl.on = YES;
                
            }
        }else if (indexPath.row == 2) {
            if ([NSUserStoreTool getObjectWithKey:@"classremind"]) {
                NSNumber *num = [NSUserStoreTool getObjectWithKey:@"classremind"];
                switchControl.on = num.intValue;
            }else {
                switchControl.on = YES;
                
            }
        }
        cell.accessoryView = switchControl;
        [switchControl addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

    }
    return cell;
}
- (void)switchAction:(UISwitch *)sender {
    ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
    [alerview show];
    NSMutableDictionary *mubdic = [[NSMutableDictionary alloc] initWithDictionary:@{@"userid":[UserInfoModel defaultUserInfo].userID,@"usertype":@"2"}];
    NSString *url =[NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kSettingUrl];
    if (sender.tag - 100 == 0) {
        if (sender.on == YES) {
            DYNSLog(@"sender.on = %d",sender.on);
            [mubdic setObject:@"1" forKey:@"reservationreminder"];
            [NSUserStoreTool storeWithId:@1 WithKey:@"reservationreminder"];
        }else if (sender.on == NO) {
            [mubdic setObject:@"0" forKey:@"reservationreminder"];
            [NSUserStoreTool storeWithId:@0 WithKey:@"reservationreminder"];
            
        }
        
        [JENetwoking startDownLoadWithUrl:url postParam:mubdic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            if (messege.intValue == 1) {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
                [alerview show];
            }else {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改失败" controller:self];
                [alerview show];
            }
        }];
    }else if (sender.tag - 100 == 1) {
        if (sender.on == YES) {
            DYNSLog(@"sender.on = %d",sender.on);
            [mubdic setObject:@"1" forKey:@"newmessagereminder"];
            [NSUserStoreTool storeWithId:@1 WithKey:@"newmessagereminder"];
            
        }else if (sender.on == NO) {
            [mubdic setObject:@"0" forKey:@"newmessagereminder"];
            [NSUserStoreTool storeWithId:@0 WithKey:@"newmessagereminder"];
            
        }
        [JENetwoking startDownLoadWithUrl:url postParam:mubdic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            if (messege.intValue == 1) {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
                [alerview show];
            }else {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改失败" controller:self];
                [alerview show];
            }
        }];
    }else if (sender.tag - 100 == 2) {// 自动接收预约
        if (sender.on == YES) {
            DYNSLog(@"sender.on = %d",sender.on);
            [mubdic setObject:@"1" forKey:@"classremind"];
            [NSUserStoreTool storeWithId:@1 WithKey:@"classremind"];
            
        }else if (sender.on == NO) {
            [mubdic setObject:@"0" forKey:@"classremind"];
            [NSUserStoreTool storeWithId:@0 WithKey:@"classremind"];
            
        }
        [JENetwoking startDownLoadWithUrl:url postParam:mubdic WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
            NSDictionary *dataParam = data;
            NSNumber *messege = dataParam[@"type"];
            if (messege.intValue == 1) {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
                [alerview show];
            }else {
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改失败" controller:self];
                [alerview show];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 2) {
        FeedBackViewController *feedBack = [[FeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBack animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 0) {
        AboutUsViewController *about = [[AboutUsViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        //评分
        NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1060635200" ];
        if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
            str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/1060635200"];
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

@end
