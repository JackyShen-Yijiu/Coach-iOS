//
//  JZMyController.m
//  HeiMao_B
//
//  Created by ytzhang on 16/3/25.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZMyController.h"
#import "TopCollectionCell.h"
#import "BottomCollectionCell.h"
#import "MyHeaderView.h"
#import "MyWalletViewController.h"
#import "SetupViewController.h"
#import "VacationViewController.h"
#import "InformationMessageController.h"
#import "EditorUserViewController.h"
#import "ExamClassViewController.h"
#import "WorkTimeViewController.h"

#define kHeight 216
@interface JZMyController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *topimgArray;
@property (nonatomic, strong) NSArray *topTitleArray;
@property (nonatomic, strong) NSArray *topDetailArray;

@property (nonatomic, strong) NSArray *bottomTitleArray;
@property (nonatomic, strong) NSArray *bottomImgArray;
@property (nonatomic, strong) MyHeaderView *headerView;
@property (nonatomic, strong) UIImageView *signatureImgView;



@end

@implementation JZMyController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNarBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    [self.view addSubview:self.collectionView];
    [self initArray];
    [self initUI];
    [self initNationcenter];
   
}
- (void)initNationcenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(classTypeChange) name:kclassTypeChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(worktimeChange) name:kworktimeChange object: nil];
}
- (void)initNarBar{
    self.myNavigationItem.title = nil;
    self.myNavigationItem.titleView = nil;
    self.myNavigationItem.rightBarButtonItem = nil;
    self.myNavigationItem.rightBarButtonItems = nil;
    self.myNavigationItem.leftBarButtonItem = nil;
    self.myNavigationItem.title = [UserInfoModel defaultUserInfo].name;
    CGRect backframe= CGRectMake(0, 0, 14, 14);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = backframe;
    [backButton setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(dealGoBack:) forControlEvents:UIControlEventTouchUpInside];
    self.myNavigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];

    
}

- (void)initArray{
    self.topimgArray = @[@"class",@"time"];
    self.topTitleArray = @[@"授课班型",@"工作时间"];
    
    // 授课班型数据
    NSString *classTypeStr = nil;
    if ([[UserInfoModel defaultUserInfo].classModel isEqualToString:@""] || [UserInfoModel defaultUserInfo].classModel == nil ) {
        
        classTypeStr = @"未设置";
    }else{
        classTypeStr = [UserInfoModel defaultUserInfo].classModel;
    }
    // 工作时间数据
    NSString *workTimeStr = [self workTimeData];
    
    self.topDetailArray = @[classTypeStr,workTimeStr];
    
    self.bottomImgArray = @[@"rest",@"wallet",@"Information",@"set"];
    self.bottomTitleArray = @[@"休假",@"钱包",@"资讯",@"设置"];
}
- (void)initUI{
    self.headerView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, -kHeight, self.view.frame.size.width, kHeight) withUserPortrait:[UserInfoModel defaultUserInfo].portrait withUserPhoneNum:[UserInfoModel defaultUserInfo].driveschoolinfo[@"name"] withYNum:[NSString stringWithFormat:@"%ld",[UserInfoModel defaultUserInfo].fcode]];
    _headerView.tag = 201;
    [self.collectionView addSubview:self.headerView];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     CGPoint point = scrollView.contentOffset;
    NSLog(@"point%f",point.y);
     if (point.y < -kHeight) {
         CGRect rect = [self.collectionView viewWithTag:201].frame;
         rect.origin.y = point.y;
         rect.size.height = -point.y;
         [self.collectionView viewWithTag:201].frame = rect;
         
     }
 }
#pragma  mark ---- 头像点击进入编辑
- (void)dealGoBack:(UIButton *)btn{
    EditorUserViewController *editor = [[EditorUserViewController alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
}
#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (0 == section) {
        return 2 ;
    } else if (1 == section){
        return 4;
    }
    return 0;
    
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (0 == section) {
        return CGSizeMake(self.view.frame.size.width, 1);
    }
    if (1 == section) {
        return CGSizeMake(self.view.frame.size.width, 10);
    }
    

    return CGSizeMake(0, 0);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
         static NSString * CellIdentifier = @"topcell";
        [_collectionView registerClass:[TopCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
        TopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        cell.imgView.image = [UIImage imageNamed:self.topimgArray[indexPath.row]];
        cell.classTypeLabel.text = self.topTitleArray[indexPath.row];
        cell.contentLabel.text = self.topDetailArray[indexPath.row];
        return cell;
    }
    if (1 == indexPath.section) {
        static NSString * CellIdentifier = @"bottomCell";
        [_collectionView registerClass:[BottomCollectionCell class] forCellWithReuseIdentifier:CellIdentifier];
        BottomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.bottomImgArray[indexPath.row]];
        cell.titleLabel.text = self.bottomTitleArray[indexPath.row];
        return cell;
    }

    return nil;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPat{
    if (0 == indexPat.section) {
        if (0 == indexPat.row) {
            // 授课班型
            ExamClassViewController *examClassVC = [[ExamClassViewController alloc] init];
            [self.navigationController pushViewController:examClassVC animated:YES];
            
        }
        if (1 == indexPat.row) {
            // 工作时间
            WorkTimeViewController *worktimeVC = [[WorkTimeViewController alloc] init];
            [self.navigationController pushViewController:worktimeVC animated:YES];
            
            
        }
    }
    
    
    
    if (1 == indexPat.section) {
        if (0 == indexPat.row) {
            // 休假
            VacationViewController *vacation = [[VacationViewController alloc] init];
            [self.navigationController pushViewController:vacation animated:YES];
        }
        if (1 == indexPat.row) {
            // 钱包
            MyWalletViewController *myWallet = [[MyWalletViewController alloc] init];
            [self.navigationController pushViewController:myWallet animated:YES];
        }
        if (2 == indexPat.row) {
            // 资讯
            InformationMessageController *informationMessage = [[InformationMessageController alloc] init];
            [self.navigationController pushViewController:informationMessage animated:YES];

        }
        if (3 == indexPat.row) {
            // 设置
            SetupViewController *setUp = [[SetupViewController alloc] init];
            [self.navigationController pushViewController:setUp animated:YES];
        }

    }
    
   
}

#pragma mark - collectionView flowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        CGFloat w = self.view.frame.size.width - 1;
        return CGSizeMake( w / 2, 88);
    } else if (1 == indexPath.section) {
        CGFloat w = self.view.frame.size.width - 3;
        return CGSizeMake( w / 4, 88);
    }
    
    return CGSizeMake(0, 0);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}
// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

#pragma mark --- 授课班型和工作时间改变的通知
- (void)classTypeChange{
    // 授课班型
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[path]];
}
- (void)worktimeChange{
    // 工作时间
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[path]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ---- 工作时间相关排序

- (NSString *)workTimeData{
    // 工作时间
    NSArray * weekArray = [[UserInfoModel defaultUserInfo] workweek];
    
    NSLog(@"weekArray:%@",weekArray);
    NSLog(@"weekArray.count:%lu",weekArray.count);
    
    BOOL isInclude = [weekArray containsObject:@(7)];
    NSLog(@"isInclude:%d",isInclude);
    if (isInclude) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:weekArray];
        [tempArray removeObject:@(7)];
        weekArray = tempArray;
        [UserInfoModel defaultUserInfo].workweek = weekArray;
    }
    
    NSString * workSetDes = @"未设置";
    
    if (weekArray) {
        
        NSArray *newArray = [self bubbleSort:weekArray];
        NSLog(@"newArray:%@",newArray);
        for (int i = 0;i<newArray.count;i++) {
            NSLog(@"i:%d",[newArray[i] intValue]);
        }
        
        if (newArray && newArray.count>0) {
            
            NSMutableString *mutableStr = [NSMutableString string];
            
            if (newArray.count==7) {
                
                [mutableStr appendString:@"周一至周日"];
                
            }else{
                
                for (int i = 0; i<newArray.count; i++) {
                    
                    NSString *endDate = [NSString stringWithFormat:@"%@",[self dateStringWithDateNumber:[newArray[i] integerValue]]];
                    [mutableStr appendString:endDate];
                    
                }
                
            }
            
            workSetDes = mutableStr;
            
        }
        
    }
    return workSetDes;

}
- (NSArray *)bubbleSort:(NSArray *)arg{//冒泡排序算法
    
    NSMutableArray *args = [NSMutableArray arrayWithArray:arg];
    
    for(int i=0;i<args.count-1;i++){
        
        for(int j=i+1;j<args.count;j++){
            
            if (args[i]>args[j]){
                
                int temp = [args[i] intValue];
                
                [args replaceObjectAtIndex:i withObject:args[j]];
                
                args[j] = @(temp);
                
            }
        }
    }
    return args;
}


- (NSString *)dateStringWithDateNumber:(NSInteger)number
{
    if (number==0) {
        return @"周日";
    }else if (number==1){
        return @"周一";
    }else if (number==2){
        return @"周二";
    }else if (number==3){
        return @"周三";
    }else if (number==4){
        return @"周四";
    }else if (number==5){
        return @"周五";
    }else if (number==6){
        return @"周六";
    }
    return nil;
}

#pragma mark ---- Lazy 加载

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // 自动布局方式
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(kHeight, 0, 0, 0);;
    }
    return _collectionView;
}
- (UIImageView *)signatureImgView{
    if (_signatureImgView == nil) {
        _signatureImgView = [[UIImageView alloc] init];
        _signatureImgView.image = [UIImage imageNamed:@"edit"];
        _signatureImgView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signatureSetUp)];
//        [_signatureImgView addGestureRecognizer:tapGes];
    }
    return _signatureImgView;
}

@end
