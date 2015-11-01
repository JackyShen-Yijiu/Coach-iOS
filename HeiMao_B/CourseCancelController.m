//
//  CourseCancelController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/28.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CourseCancelController.h"
#import "CoursePicListCell.h"
#import "CourseDesInPutCell.h"
#import "CourseEnsureCell.h"

@interface CourseCancelControllerModel : NSObject
@property(nonatomic,strong)NSString * pickerTitle;
@property(nonatomic,strong)NSArray * pickItemsDataList;
@property(nonatomic,strong)NSString * inputDes;
@end
@implementation CourseCancelControllerModel
@end

@interface CourseCancelController()<UITableViewDataSource,UITableViewDelegate,CourseDesInPutCellDelegate,CourseEnsureCellDelegate,UIAlertViewDelegate>
{
    CGFloat _scrollViewOffset;
}
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)CourseCancelControllerModel * model;
@property(nonatomic,strong)CourseDesInPutCell * inputCell;

@end

@implementation CourseCancelController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB_Color(247, 249, 251);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addKeyBoradNotificaiton];
}


#pragma mark Life Sycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
}

#pragma mark - initUI
- (void)initNavBar
{
    [self resetNavBar];
    [self refreshNavBarTitle];
}

- (void)refreshNavBarTitle
{
    switch (self.controllerType) {
        case KControllTypeCancel:
            self.myNavigationItem.title = @"取消课程";
            break;
        case KControllTypeReject:
            self.myNavigationItem.title = @"拒绝课程";
            break;
        default:
            break;
    }
}

#pragma mark - Data
- (void)setControllerType:(KControllType)controllerType
{
    _controllerType = controllerType;
    [self refreshNavBarTitle];
    [self refreshModel];
}

- (void)refreshModel
{
    CourseCancelControllerModel * model = [[CourseCancelControllerModel alloc] init];
    switch (self.controllerType) {
        case KControllTypeCancel:
        {
            model.pickerTitle = @"取消原因";
            NSMutableArray * picList = [NSMutableArray arrayWithCapacity:3];
            
            PickerItemModel * pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"临时有事";
            [picList addObject:pickerModel];
            
            pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"身体抱恙";
            [picList addObject:pickerModel];


            pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"其他";
            [picList addObject:pickerModel];
            
            model.pickItemsDataList = picList;
        }
            break;
        case KControllTypeReject:
        {
            model.pickerTitle = @"拒绝原因";
            NSMutableArray * picList = [NSMutableArray arrayWithCapacity:3];
            
            PickerItemModel * pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"临时有事,无法参加";
            [picList addObject:pickerModel];
            
            pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"名额已满";
            [picList addObject:pickerModel];
            
            pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"身体抱恙";
            [picList addObject:pickerModel];
            
            
            pickerModel = [[PickerItemModel alloc] init];
            pickerModel.title = @"其他";
            [picList addObject:pickerModel];
            
            model.pickItemsDataList = picList;
            
        }
            break;
        default:
            break;
    }
    self.model = model;
    [self.tableView reloadData];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [CoursePicListCell cellHight:[[self model] pickItemsDataList].count];
    }else if (indexPath.row == 1){
        return [CourseDesInPutCell cellHeight];
    }else if (indexPath.row == 2){
        return [CourseEnsureCell cellHeigthWithTitle:self.controllerType == KControllTypeCancel];
    }
    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CoursePicListCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CoursePicListCell class])];
        if (!cell) {
            cell = [[CoursePicListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CoursePicListCell class])];
        }
        [cell.pickListView setTitle:self.model.pickerTitle];
        cell.pickListView.pickItemArray = self.model.pickItemsDataList;
        return cell;
    }else if (indexPath.row == 1){
        
        CourseDesInPutCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseDesInPutCell class])];
        if (!cell) {
            cell = [[CourseDesInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseDesInPutCell class])];
            cell.delegate = self;
        }
        self.inputCell = cell;
        cell.placeLabel.text =  self.controllerType == KControllTypeCancel ? @"取消预约说明" : @"拒绝预约说明";
        return cell;

    }else if (indexPath.row == 2){
        CourseEnsureCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseEnsureCell class])];
        if (!cell) {
            cell = [[CourseEnsureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseEnsureCell class])];
            cell.delegate = self;
        }
        [cell setTitle:self.controllerType == KControllTypeCancel ? @"亲，多次取消会影响您的信用积分吆！" : @""];
        return cell;

    }
    
    return [UITableViewCell new];
}

#pragma mark - Action
- (void)courseDesInPutCellDidTextViewWillChangeToString:(NSString *)str
{
    self.model.inputDes = str;
}

#pragma mark - KeyBoard
- (void)addKeyBoradNotificaiton
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardShow:(NSNotification*)notification
{
    if([self.inputCell.textView isFirstResponder]){
        [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, self.inputCell.top - 10) animated:YES];
    }
}

- (void)keyboardHide:(NSNotification*)notification
{
    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIPanGestureRecognizer * pan = scrollView.panGestureRecognizer;
    CGPoint  velocityInView = [pan velocityInView:scrollView];
    if (velocityInView.y > 0) {
        [self.inputCell.textView resignFirstResponder];
    }
    
//    if (_scrollViewOffset > scrollView.contentOffset.y) {
//        [self.inputCell.textView resignFirstResponder];
//    }
//    _scrollViewOffset = scrollView.contentOffset.y;
}

#pragma mark - Action
- (void)courseCellDidEnstureClick:(CourseEnsureCell *)cell
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    if (self.controllerType == KControllTypeReject) {
    [NetWorkEntiry postToDealRequestOfCoureseWithCoachid:[[UserInfoModel defaultUserInfo] userID] coureseID:self.courseId didReject:NO cancelreason:[self seletedReasion] cancelcontent:self.model.inputDes  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger type = [[responseObject objectForKey:@"type"] integerValue];
        if (type == 1) {
            [self showAlertView];
        }else{
            [self dealErrorResponseWithInfo:responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self showTotasViewWithMes:@"网络异常"];
    }];
}
- (void)dealErrorResponseWithInfo:(NSDictionary *)dic
{
    [self showTotasViewWithMes:[dic objectForKey:@"msg"]];

}

#pragma mar - AlertView
- (void)showAlertView
{
    if (NSClassFromString(@"UIAlertController")) {
        UIAlertController * alertCont = [UIAlertController alertControllerWithTitle:nil message:@"操作成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * actionn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self alertView:[UIAlertView new] clickedButtonAtIndex:0];
        }];
        [alertCont addAction:actionn];
        [self presentViewController:alertCont animated:YES completion:nil];
    }else{
        UIAlertView * alerView = [[UIAlertView alloc] initWithTitle:nil message:@"操作成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alerView show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([_delegate respondsToSelector:@selector(courseCancelControllerDidOpeartionSucess:)]) {
        [_delegate courseCancelControllerDidOpeartionSucess:self];
    }
}

- (NSString *)seletedReasion
{
    NSString * str = nil;
    for (PickerItemModel * itemModel in self.model.pickItemsDataList) {
        if (itemModel.isSeleted) {
            str = itemModel.title;
        }
    }
    return str;
}

#pragma mark - TableView
- (UITableView *)tableView
{
    if (!_tableView) {
        
        UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
        _tableView.autoresizesSubviews = UIViewAutoresizingFlexibleWidth;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];

    }
    return _tableView;
}
@end
