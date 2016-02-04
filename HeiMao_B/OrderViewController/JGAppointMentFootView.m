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

@interface JGAppointMentFootView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) NSIndexPath *firstPath;

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
        flowLayout.itemSize = CGSizeMake(175, 75);
        flowLayout.sectionInset = UIEdgeInsetsMake(7, 10, 7, 10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 90) collectionViewLayout:flowLayout];
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
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData {
        
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:coachTimeData];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
    
    NSLog(@"self.dataArray.count:%lu",(unsigned long)self.dataArray.count);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.indexPath = nil;
    return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"JGAppointMentFootCell";
    JGAppointMentFootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    
    if (self.dataArray && self.dataArray.count>0) {
        
        cell.selectedAppView.hidden = NO;
        cell.addBtn.hidden = YES;
        
        HMCourseModel *model = self.dataArray[indexPath.row];
        cell.coachTimeInfo = model;
        
    }else{
        
        cell.selectedAppView.hidden = YES;
        cell.addBtn.hidden = NO;
        [cell.addBtn addTarget:self action:@selector(addBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

- (void)addBtnDidClick{
    NSLog(@"%s",__func__);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    HMCourseModel *model = self.dataArray[indexPath.row];
    
    
}

@end
