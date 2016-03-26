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

#define kHeight 216
@interface JZMyController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *topimgArray;
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
   
}
- (void)initNarBar{
//    self.myNavigationItem.title = nil;
//    self.myNavigationItem.titleView = nil;
//    self.myNavigationItem.rightBarButtonItem = nil;
//    self.myNavigationItem.rightBarButtonItems = nil;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

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
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signatureSetUp)];
        [_signatureImgView addGestureRecognizer:tapGes];
    }
    return _signatureImgView;
}

@end
