//
//  MyWalletViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MyWalletViewController.h"
#import "UIDevice+JEsystemVersion.h"
#import "UIView+CalculateUIView.h"
#import <Chameleon.h>
#import "ToolHeader.h"
#import "MagicMainTableViewController.h"
#import "MyWallet.h"
#import "WalletAPI.h"

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)


static NSString *const kMyWalletUrl = @"userinfo/getmywallet?userid=%@&usertype=2&seqindex=%@&count=10";

@interface MyWalletViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *myWalletTitle;
@property (strong, nonatomic) UILabel *moneyDisplay;
@property (strong, nonatomic) UIButton *inviteButton;
@property (strong, nonatomic) UIButton *exchangeButton;

@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UILabel *inviteNum;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *groundView ;

@end

@implementation MyWalletViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UILabel *)inviteNum {
    if (_inviteNum == nil) {
        _inviteNum = [[UILabel alloc] init];
        _inviteNum.font = [UIFont systemFontOfSize:14];
        _inviteNum.text = [NSString stringWithFormat:@"我的邀请码:%@",[UserInfoModel defaultUserInfo].invitationcode];
    }
    return _inviteNum;
}
- (UIView *)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderColor = BACKGROUNDCOLOR.CGColor;
        _bottomView.layer.borderWidth = 1;
    }
    return _bottomView;
}
- (UILabel *)moneyDisplay {
    if (_moneyDisplay == nil) {
        _moneyDisplay = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:65]];
        _moneyDisplay.text = @"0";
    }
    return _moneyDisplay;
}
- (UIButton *)inviteButton {
    if (_inviteButton == nil) {
        _inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inviteButton setTitle:@"邀请好友" forState:UIControlStateNormal];
        [_inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _inviteButton.backgroundColor = kDefaultTintColor;
        _inviteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _inviteButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _inviteButton.layer.borderWidth = 1;
        _inviteButton.layer.cornerRadius = 2;
        [_inviteButton addTarget:self action:@selector(dealInvite:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _inviteButton;
}
- (UIButton *)exchangeButton {
    if (_exchangeButton == nil) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setTitle:@"兑换商品" forState:UIControlStateNormal];
        [_exchangeButton setTitleColor:kDefaultTintColor forState:UIControlStateNormal];
     
        _exchangeButton.backgroundColor = [UIColor whiteColor];
        _exchangeButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _exchangeButton.layer.borderColor = kDefaultTintColor.CGColor;
        _exchangeButton.layer.borderWidth = 1;
        _exchangeButton.layer.cornerRadius = 2;
        [_exchangeButton addTarget:self action:@selector(clickExchange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeButton;
}
- (UILabel *)myWalletTitle {
    if (_myWalletTitle == nil) {
        _myWalletTitle = [WMUITool initWithTextColor:[UIColor whiteColor] withFont:[UIFont systemFontOfSize:15]];
        _myWalletTitle.text = @"我的零钱";
    }
    return _myWalletTitle;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight-80-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的钱包";
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([UIDevice jeSystemVersion] >= 7.0f) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [self tableViewHead];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.inviteNum];
    [self.bottomView addSubview:self.inviteButton];
    [self.bottomView addSubview:self.exchangeButton];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
        make.height.mas_equalTo(@80);
    }];
    [self.inviteNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(15);
        make.top.mas_equalTo(self.bottomView.mas_top).offset(10);
    }];
    [self.inviteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView.mas_left).offset(15);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-10);
        make.height.mas_equalTo(@40);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide/2)-20];
        make.width.mas_equalTo(wide);
    }];
    [self.exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.bottomView.mas_bottom).offset(-10);
        make.height.mas_equalTo(@40);
        NSNumber *wide = [NSNumber numberWithFloat:(kSystemWide/2)-20];
        make.width.mas_equalTo(wide);
    }];
    
    [self startDownLoad];
    
}
- (void)dealInvite:(UIButton *)sender {
    
    self.groundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight)];
    self.groundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    
    
    UIView *backImageView = [[UIView alloc] initWithFrame:CGRectMake(kSystemWide/2-250/2, kSystemHeight/2-250/2, 250, 250)];
    backImageView.backgroundColor = [UIColor whiteColor];
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, -1, 252, 200)];
    backView.image = [UIImage imageNamed:@"red_background.png"];
    
    UIImageView *redImage = [[UIImageView alloc] initWithFrame:CGRectMake(250/2-75/2, 10, 75, 58)];
    redImage.layer.masksToBounds = YES;
    redImage.image = [UIImage imageNamed:@"red.png"];
    [backView addSubview:redImage];
    [backImageView addSubview:backView];
    
    UILabel *labelone = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 250, 20)];
    labelone.textAlignment = NSTextAlignmentCenter;
    labelone.text = @"一步学车设计了最先进的用户激励机制";
    labelone.textColor = [UIColor whiteColor];
    labelone.font = [UIFont systemFontOfSize:14];
    UILabel *labeltwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 250, 20)];
    labeltwo.font = [UIFont systemFontOfSize:13];
    labeltwo.textColor = [UIColor whiteColor];
    
    
    labeltwo.textAlignment = NSTextAlignmentCenter;
    
    labeltwo.text = @"推荐用户和学员可以长久的获利";
    UILabel *labelthree = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 250, 20)];
    labelthree.font = [UIFont systemFontOfSize:13];
    labelthree.textColor = [UIColor whiteColor];
    
    
    labelthree.textAlignment = NSTextAlignmentCenter;
    
    labelthree.text = @"赶快去邀请小伙伴来用吧";
    UILabel *labelfour = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 250,20)];
    labelfour.textAlignment = NSTextAlignmentCenter;
    labelfour.font = [UIFont systemFontOfSize:13];
    labelfour.textColor = [UIColor whiteColor];
    
    
    labelfour.text = @"记得让他们注册的时候填写你的邀请码哟";
    
    [backView addSubview:labelone];
    [backView addSubview:labeltwo];
    [backView addSubview:labelthree];
    [backView addSubview:labelfour];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = RGBColor(241, 81, 27);
    button.frame = CGRectMake(250/2-200/2, 205, 200, 40);
    [button setTitle:@"我知道了" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickDismiss:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
    
    [self.groundView addSubview:backImageView];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.groundView];
    
    
    
}
- (void)clickDismiss:(UIButton *)sender {
    [self.groundView removeFromSuperview];
}
- (void)clickExchange:(UIButton *)sender {
    MagicMainTableViewController *vc = [[MagicMainTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)startDownLoad {
    [self.dataArray removeAllObjects];
    
    NSString *url = [NSString stringWithFormat:kMyWalletUrl,[UserInfoModel defaultUserInfo].userID,@"0"];
    NSString *urlString = [NSString stringWithFormat:BASEURL,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        NSDictionary *param = [data objectForKey:@"data"];
        NSArray *list = [param objectForKey:@"list"];
        NSString *walletString = [NSString stringWithFormat:@"%@",param[@"wallet"]];
        if (walletString && walletString.length != 0) {
            if ([walletString isEqualToString:@"(null)"]) {
                walletString = @"0";
            }
            _moneyDisplay.text =  walletString;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:walletString forKey:@"walletStr"];
            
            
        }
        for (NSDictionary *dic in list) {
            MyWallet *wallet = [[MyWallet alloc] init];
            [wallet setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:wallet];
        }
        [self.tableView reloadData];
    }];
}
- (UIView *)tableViewHead {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.view.calculateFrameWithWide, 230)];
    view.backgroundColor = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom withFrame:CGRectMake(0, 0, kSystemWide, 230) andColors:@[RGBColor(16, 73, 212),RGBColor(70, 128, 247)]];
    
    [view addSubview:self.myWalletTitle];
    [self.myWalletTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.mas_top).offset(53);
        make.centerX.mas_equalTo(view.mas_centerX);
    }];
    [view addSubview:self.moneyDisplay];
    [self.moneyDisplay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.myWalletTitle.mas_bottom).offset(0);
        make.centerX.mas_equalTo(view.mas_centerX);

    }];
  
   
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, 29)];
    sectionTitle.text = @"      交易详情";
    sectionTitle.backgroundColor = RGBColor(247, 249, 251);
    sectionTitle.font = [UIFont systemFontOfSize:12];
    sectionTitle.textColor = [UIColor blackColor];
    return sectionTitle;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 29;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyWallet *wallet = self.dataArray[indexPath.row];
    cell.textLabel.text = @"分享收益";
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.text = [NSString getLitteLocalDateFormateUTCDate:wallet.createtime];
    cell.detailTextLabel.textColor = TEXTGRAYCOLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    UILabel *moneyDisplay = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    moneyDisplay.textColor = kDefaultTintColor;
    moneyDisplay.font = [UIFont systemFontOfSize:22];
    moneyDisplay.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithInt:wallet.amount]] ;
    cell.accessoryView = moneyDisplay;
    return cell;
}

- (void)refreshWalletData
{
    [self startDownLoad];
}
@end
