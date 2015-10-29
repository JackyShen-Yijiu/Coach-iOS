//
//  CoureseRatingController.m
//  HeiMao_B
//
//  Created by kequ on 15/10/29.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "CoureseRatingController.h"

#import "CourseRatingUserInfoCell.h"
#import "CourseRatingCell.h"
#import "CourseDesInPutCell.h"
#import "CourseEnsureCell.h"

@interface CoureseRatingController()<UITableViewDelegate,UITableViewDataSource,CourseDesInPutCellDelegate,CourseEnsureCellDelegate>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)CourseDesInPutCell * inputCell;

@property(nonatomic,strong)NSArray * ratingListArray;
@property(nonatomic,strong)NSString * desStr;
@end

@implementation CoureseRatingController

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
    self.myNavigationItem.title = @"评论";
}


#pragma mark - TableViewDelegate | TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return self.ratingListArray.count;
    }
    return 1;
}

#pragma 
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 3) {
        return [self bottomViewHight];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 1 ) {
        return [self getBottomView];
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [CourseRatingUserInfoCell cellHeigth];
            break;
        case 1:
            return [CourseRatingCell cellHigth];
            break;
        case 2:
            return [CourseDesInPutCell cellHeight];
            break;
        case 3:
            return [CourseEnsureCell cellHeigthWithTitle:NO];
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CourseRatingUserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseRatingUserInfoCell class])];
        if (!cell) {
            cell = [[CourseRatingUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseRatingUserInfoCell class])];
        }
        cell.model = self.studentModel;
        return cell;
    }else if (indexPath.section == 1){
        CourseRatingCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseRatingCell class])];
        if (!cell) {
            cell = [[CourseRatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseRatingCell class])];
        }
        CourseRatingModel * model  = [self.ratingListArray objectAtIndex:indexPath.row];
        [cell setModel:model];
        cell.makeLineAligent = indexPath.row == 0;
        [cell.bottonLineView setHidden:indexPath.row == self.ratingListArray.count -1 ];
        return cell;
        
    }else if (indexPath.section == 2){
        
        CourseDesInPutCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseDesInPutCell class])];
        if (!cell) {
            cell = [[CourseDesInPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseDesInPutCell class])];
            cell.delegate = self;
        }
        self.inputCell = cell;
        cell.placeLabel.text =  @"写点评论吧，对其他小伙伴有很大帮助哦";
        return cell;
        
    }else if(indexPath.section == 3){
        CourseEnsureCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CourseEnsureCell class])];
        if (!cell) {
            cell = [[CourseEnsureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CourseEnsureCell class])];
            cell.delegate = self;
        }
        [cell setTitle:@""];
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark - Data
- (void)setStudentModel:(HMStudentModel *)studentModel
{
    _studentModel = studentModel;
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)courseDesInPutCellDidTextViewWillChangeToString:(NSString *)str
{
    self.desStr = [str copy];
}

- (void)courseCellDidEnstureClick:(CourseEnsureCell *)cell
{

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

- (NSArray *)ratingListArray
{
    if (!_ratingListArray) {
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        CourseRatingModel * ratModel = nil;
        ratModel = [[CourseRatingModel alloc] init];
        ratModel.title = @"总体评价";
        ratModel.rating = 5.f;
        [array addObject:ratModel];
        
        ratModel = [[CourseRatingModel alloc] init];
        ratModel.title = @"定时";
        ratModel.rating = 5.f;
        [array addObject:ratModel];
        
        ratModel = [[CourseRatingModel alloc] init];
        ratModel.title = @"态度";
        ratModel.rating = 5.f;
        [array addObject:ratModel];
        
        ratModel = [[CourseRatingModel alloc] init];
        ratModel.title = @"能力";
        ratModel.rating = 5.f;
        [array addObject:ratModel];
        _ratingListArray = [array copy];
        
    }
    return _ratingListArray;
}

- (CGFloat)bottomViewHight
{
    return 10.f;
}
- (UIView *)getBottomView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [self bottomViewHight])];

    view.backgroundColor = RGB_Color(247, 249, 251);
    view.layer.borderColor = RGB_Color(230, 230, 230).CGColor;
    view.layer.borderWidth = 1;
    
    return view;
}
@end
