//
//  JGAppointMentFootView.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGAppointMentFootView.h"
#import "ToolHeader.h"
#import "JGAppointMentFootCell.h"
#import "AppointmentCoachTimeInfoModel.h"
//#import "BLInformationManager.h"
//#import "CoachViewController.h"
#import "PortraitView.h"
#import "YBSignUpStudentListController.h"
#import "YBSignUpStuentListModel.h"

@interface JGAppointMentFootView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *addBtn;

@end

@implementation JGAppointMentFootView

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 5;// 设置cell之间间距
        flowLayout.minimumLineSpacing = 5;// 设置行距
        flowLayout.itemSize = CGSizeMake(185, 75);
        flowLayout.sectionInset = UIEdgeInsetsMake(7, 10, 7, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,205, 90) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;// 隐藏水平滚动条
        _collectionView.bounces = NO;// 取消弹簧效果
        [_collectionView registerClass:[JGAppointMentFootCell class] forCellWithReuseIdentifier:@"JGAppointMentFootCell"];
        
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData {
        
    NSLog(@"coachTimeData.count:%lu",(unsigned long)coachTimeData.count);
    
    if (coachTimeData && coachTimeData.count!=0) {
        
        [self.addBtn removeFromSuperview];

        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:coachTimeData];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self.collectionView reloadData];
        
    }else{
        
        [self addSubview:self.addBtn];
        
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"JGAppointMentFootCell";
    JGAppointMentFootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    cell.selected = YES;
    
    NSLog(@"JGAppointMentFootCell self.dataArray.count:%lu",(unsigned long)self.dataArray.count);

    YBSignUpStuentListModel *model = self.dataArray[indexPath.row];
        
    cell.coachTimeInfo = model;
    
    return cell;
}


- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        
        _addBtn = [[UIButton alloc] init];
        _addBtn.backgroundColor = RGB_Color(31, 124, 235);
        _addBtn.frame = CGRectMake(self.width/2-100/2, self.height/2-45/2, 100, 45);
        [_addBtn setTitle:@"添加学员" forState:UIControlStateNormal];
        [_addBtn setTitle:@"添加学员" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addBtn;
}

- (void)addBtnDidClick{
    NSLog(@"%s",__func__);
    
    YBSignUpStudentListController *vc = [[YBSignUpStudentListController alloc] init];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self addBtnDidClick];
}

@end
