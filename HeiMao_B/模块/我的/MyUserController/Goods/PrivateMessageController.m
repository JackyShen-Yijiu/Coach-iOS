//
//  PrivateMessageController.m
//  Magic
//
//  Created by ytzhang on 15/11/10.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import "PrivateMessageController.h"
#import "PrivateMessageCell.h"
#import "finishMessageView.h"
#import "ToolHeader.h"
#import "MagicMainTableViewController.h"
#import "InfoModel.h"
#import "WalletAPI.h"
#import "NetWorkEntiry.h"
#import "MyWalletViewController.h"

static NSString *const kMyInfotUrl = @"userinfo/getuserinfo?userid=%@&usertype=1";
static NSString *const kBuyproduct =  @"userinfo/buyproduct";

@interface PrivateMessageController ()

@end

@implementation PrivateMessageController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [_bottomView removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:YES];
    [self addBottomView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加取消键盘的手势
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    // 初始化数组
    self.cellArray = [NSMutableArray array];
    self.textFiledArray = [NSMutableArray array];
    self.navigationItem.title = @"个人信息";
    // 创建头部试图
    CGFloat kwight = self.view.bounds.size.width;
    CGFloat khight = 50;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kwight, khight)];
    
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kwight - 215, khight - 15, 100, 10)];
    messageLabel.font = [UIFont systemFontOfSize:13.f];
    messageLabel.text = @"收件人信息";
    messageLabel.textColor = [UIColor lightGrayColor];
    
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, messageLabel.frame.origin.y + 15, kwight, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    
    [headerView addSubview:lineView];
    [headerView addSubview:messageLabel];
    
    
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    
    // 去除多余的线
    [self cleaExtraLine];

   // 加载个人信息
    [self startDownLoad];
    
}

- (void)startDownLoad {
    NSString *url = [NSString stringWithFormat:kMyInfotUrl,[UserInfoModel defaultUserInfo].userID];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,url];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        DYNSLog(@"data = %@",data);
        
        
        // 封装我的钱包数据
        NSDictionary *dataDic = [data objectForKey:@"data"];
        InfoModel *infoModel = [[InfoModel alloc] init];
        [infoModel setValuesForKeysWithDictionary:dataDic];
        
        
        
    }];
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];
    
    
    
    [textFiledOne resignFirstResponder];
    [textFiledTwo resignFirstResponder];
    [textFiledThree resignFirstResponder];
}

// 点击确认购买按钮
#pragma mark -----加载底部View
- (void)addBottomView
{
    // 加载底部View
    _bottomView = [LTBottomView instanceBottomView];
    
    // 取出确认购买按钮,添加点击事件
    _didClickBtn = [_bottomView viewWithTag:102];
    
    // 取出积分的Label
    UILabel *numberLabel = [_bottomView viewWithTag:103];
    NSUserDefaults *defaules = [NSUserDefaults standardUserDefaults];
    
    numberLabel.text = [defaules objectForKey:@"walletStr"];

    [_didClickBtn setTitle:@"确认购买" forState:UIControlStateNormal];
    CGFloat kWight = [UIScreen mainScreen].bounds.size.width;
    CGFloat kHight = [UIScreen mainScreen].bounds.size.height;    CGFloat kbottonViewh = 50;
    _bottomView.frame = CGRectMake(0,kHight - 50 , kWight, kbottonViewh);
    NSArray *windows = [UIApplication sharedApplication].windows;
    _wid = [windows lastObject];
    _bottomView.tag = 200;
    [_wid addSubview:_bottomView];
    
    
}


- (void)backMainView:(UIButton *)btn
{
    [_finishView removeFromSuperview];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:3] animated:YES];
}
- (void)cleaExtraLine
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoModel *infoModel = [InfoModel getInstance];
    
    
    // 个人基本信息数组
    NSArray *infoArray = [[NSArray alloc] initWithObjects:[infoModel name],[infoModel mobile], nil];
    
    
    // 字符数组
    NSArray *strArray = [[NSArray alloc] initWithObjects:@"姓名",@"电话",@"地址", nil];
    // tag数组
    NSArray *tagArray = @[@200,@201,@202];
    
    static NSString *definition = @"myCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered)
        {
            UINib *nib = [UINib nibWithNibName:@"PrivateMessageCell" bundle:nil];
            [tableView registerNib:nib forCellReuseIdentifier:definition];
            nibsRegistered = YES;
        }
    _cell = [tableView dequeueReusableCellWithIdentifier:definition];
//    _cell.messageTextField.text = infoArray[indexPath.row];
    
    // 添加当开始输入通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectorCell:) name:UITextFieldTextDidBeginEditingNotification object:_cell.messageTextField];
    
    // 添加值改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValue:) name:UITextFieldTextDidChangeNotification object:_cell.messageTextField];
  UILabel *label = [_cell viewWithTag:101];
    label.text = [strArray objectAtIndex:indexPath.row];
    _cell.tag = [tagArray[indexPath.row]intValue];
    
    [_cellArray addObject:_cell];
    [_textFiledArray addObject:_cell.messageTextField];
    
    
    
      return _cell;
    }

- (void)selectorCell:(NSNotification *)notification
{
    
    UITableViewCell *cellOne = [_cellArray objectAtIndex:0];
    UITableViewCell *cellTwo = [_cellArray objectAtIndex:1];
    UITableViewCell *cellThree = [_cellArray objectAtIndex:2];
    //获得textfield
    UITextField *textField = notification.object;
    UITableViewCell *selectorCell = (UITableViewCell *)[[textField superview] superview];
    if (selectorCell.tag == 200)
    {
        cellOne.selected = YES;
        cellTwo.selected = NO;
        cellThree.selected = NO;
    }else if (selectorCell.tag == 201)
    {
        cellOne.selected = NO ;
        cellTwo.selected = YES;
        cellThree.selected = NO;
//        UIKeyboardTypeAlphabet  = UIKeyboardTypePhonePad;
    }else
    {
        cellOne.selected = NO;
        cellTwo.selected = NO;
        cellThree.selected = YES;
    }
    
    }



- (void)changeValue:(NSNotification *)notification
{
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];
    
    //获得textfield
    textFiledTwo.keyboardType = UIKeyboardTypeNumberPad;
    UITextField *textFile = (UITextField *)notification.object;
    if (textFile.tag == 201) {
        NSString *phoneNum = textFiledTwo.text;
        NSString *regex = @"^((17[0-9])|(13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:phoneNum];
        if (!isMatch) {
            [self showTotasViewWithMes:@"请输入正确的手机号"];
            return;
        }
        
    }

    
    
    _didClickBtn.enabled =  textFiledOne.text.length != 0 && textFiledTwo.text.length != 0 && textFiledThree.text.length != 0 ;
    if ( _didClickBtn.enabled == 1) {
        [ _didClickBtn setBackgroundColor:MAINCOLOR];
        [ _didClickBtn addTarget:self action:@selector(pushFinshView:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [ _didClickBtn setBackgroundColor:[UIColor grayColor]];
    }
}
- (void)pushFinshView:(UIButton *)btn
{
    UITextField *textFiledOne = [_textFiledArray objectAtIndex:0];
    UITextField *textFiledTwo = [_textFiledArray objectAtIndex:1];
    UITextField *textFiledThree = [_textFiledArray objectAtIndex:2];

    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kBuyproduct];
    NSLog(@"urlString = %@",urlString);

    NSString *  userId = [[UserInfoModel defaultUserInfo] userID];
    
    NSString *productid = _shopID;
    
    NSDictionary *dic = @{@"usertype":@"1",
                          @"userid":userId,
                          @"productid":productid,
                          @"name":textFiledOne.text,
                          @"mobile":textFiledTwo.text,
                          @"address":textFiledThree.text};
    
    // 调用后台购买接口
    
    [NetWorkEntiry postToDidClickButtonByPurchaseWithUseID:userId productid:productid name:textFiledOne.text mobile:textFiledTwo.text address:textFiledThree.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"success = %@",responseObject);
        if (1 == [[responseObject objectForKey:@"type"] integerValue]) {
            _finishView =  [finishMessageView instanceBottomView];
            
            CGFloat kW = self.tableView.bounds.size.width;
            CGFloat kH = self.tableView.bounds.size.height;
            _finishView.frame = CGRectMake(0, 64, kW, kH);
            _finishView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
            UIButton *button =   [_finishView viewWithTag:100];
            [button addTarget:self action:@selector(backMainView:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationController.navigationBarHidden = YES;
            [_wid addSubview:_finishView];
        }
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
    MyWalletViewController *walletVC = [self.navigationController.viewControllers objectAtIndex:2];
    
    [walletVC refreshWalletData];
   
 
    
}

// 使Cell的分割线靠近最左边
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
