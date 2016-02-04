//
//  JGYuYueHeadView.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGYuYueHeadView.h"
#import "ToolHeader.h"
#import "AppointmentCollectionViewCell.h"
#import "AppointmentCoachTimeInfoModel.h"
//#import "BLInformationManager.h"
//#import "CoachViewController.h"

@interface JGYuYueHeadView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) NSIndexPath *firstPath;

@end

@implementation JGYuYueHeadView

- (NSMutableArray *)upDateArray {
    if (_upDateArray == nil) {
        _upDateArray = [[NSMutableArray alloc] init];
    }
    return _upDateArray;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UICollectionView *)collectionView {
    
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kSystemWide/4-0.5, 60);
//        flowLayout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = RGB_Color(236, 236, 236);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[AppointmentCollectionViewCell class] forCellWithReuseIdentifier:@"AppointmentCollectionViewCell"];
        
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = RGB_Color(236, 236, 236);
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

- (void)receiveCoachTimeData:(NSArray *)coachTimeData {
    
    [self.upDateArray removeAllObjects];
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:coachTimeData];
   
    [self.collectionView reloadData];
    
    NSLog(@"self.dataArray.count:%lu",(unsigned long)self.dataArray.count);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.indexPath = nil;
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"AppointmentCollectionViewCell";
    AppointmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    cell.backgroundColor = [UIColor whiteColor];
        
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    
    cell.coachTimeInfo = model;
    
    return cell;
}

- (void)cellWithDidClick
{
    NSLog(@"cellWithDidClick");
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];

    if ([self.delegate respondsToSelector:@selector(JGYuYueHeadViewWithCollectionViewDidSelectItemAtIndexPath:timeInfo:)]) {
        [self.delegate JGYuYueHeadViewWithCollectionViewDidSelectItemAtIndexPath:indexPath timeInfo:model];
    }
    
}

@end
