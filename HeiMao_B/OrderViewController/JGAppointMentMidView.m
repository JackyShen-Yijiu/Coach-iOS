//
//  JGAppointMentMidView.m
//  BlackCat
//
//  Created by bestseller on 15/10/3.
//  Copyright © 2015年 lord. All rights reserved.
//

#import "JGAppointMentMidView.h"
#import "ToolHeader.h"
#import "AppointmentCollectionViewCell.h"
#import "AppointmentCoachTimeInfoModel.h"
//#import "BLInformationManager.h"
//#import "CoachViewController.h"
#import "BLInformationManager.h"

@interface JGAppointMentMidView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) NSIndexPath *firstPath;

@end

@implementation JGAppointMentMidView

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

 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppointmentCoachTimeInfoModel *model = self.dataArray[indexPath.row];
    
    DYNSLog(@"clickModel = %d",model.is_selected);
    
    DYNSLog(@"self.upDateArray.count:%lu",self.upDateArray.count);
    
    if (model.is_selected == NO) {
        
       
        DYNSLog(@"Selected");
        if (self.upDateArray.count>=4) {
            
            ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"您最多可预约4个课时"];
            [alertView show];
            
            return;
            
        }
        
        if (self.upDateArray.count == 0) {
            
            AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.startTimeLabel.textColor = MAINCOLOR;
            cell.finalTimeLabel.textColor = MAINCOLOR;
            cell.remainingPersonLabel.textColor = MAINCOLOR;
            model.is_selected = YES;
            [self.upDateArray addObject:model];
            [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
            
            return;
        }
        
        for (AppointmentCoachTimeInfoModel *UpDatemodel in self.upDateArray) {
            
            DYNSLog(@"upDateModel = %ld",UpDatemodel.indexPath);
            if ((model.indexPath + 1 == UpDatemodel.indexPath )|| (model.indexPath-1 == UpDatemodel.indexPath)) {
                //            [SVProgressHUD showInfoWithStatus:@"请选择相邻的时间段"];
                AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.startTimeLabel.textColor = MAINCOLOR;
                cell.finalTimeLabel.textColor = MAINCOLOR;
                cell.remainingPersonLabel.textColor = MAINCOLOR;
                model.is_selected = YES;
                [self.upDateArray addObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
                
                return;
            }
        }
        
        
        ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"请选择连续的时间"];
        [alertView show];
        
    }else if (model.is_selected == YES) {
        
        if (self.upDateArray.count == 4) {
            
            NSArray *array = [BLInformationManager sharedInstance].appointmentData;
            
            NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(AppointmentCoachTimeInfoModel *  _Nonnull obj1, AppointmentCoachTimeInfoModel *  _Nonnull obj2) {
                //obj1.coursetime.numMark < obj2.coursetime.numMark
                return obj1.coursetime.numMark > obj2.coursetime.numMark ;
            }];
            AppointmentCoachTimeInfoModel *fistModel = resultArray.firstObject;
            AppointmentCoachTimeInfoModel *lastModel = resultArray.lastObject;
            if ([fistModel.infoId isEqualToString:model.infoId]||[lastModel.infoId isEqualToString:model.infoId]) {
                DYNSLog(@"unSelected");
                AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.startTimeLabel.textColor = [UIColor blackColor];
                cell.finalTimeLabel.textColor = [UIColor blackColor];
                cell.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
                model.is_selected = NO;
                [self.upDateArray removeObject:model];
                [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
                [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
                return;
            }else {
                ToastAlertView * alertView = [[ToastAlertView alloc] initWithTitle:@"次操作会造成预约时间不连续!"];
                [alertView show];
            }
            return;
        }
        DYNSLog(@"unSelected");
        AppointmentCollectionViewCell *cell = (AppointmentCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.startTimeLabel.textColor = [UIColor blackColor];
        cell.finalTimeLabel.textColor = [UIColor blackColor];
        cell.remainingPersonLabel.textColor = TEXTGRAYCOLOR;
        model.is_selected = NO;
        [self.upDateArray removeObject:model];
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        [BLInformationManager sharedInstance].appointmentData = self.upDateArray;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCellChange" object:nil];
        
    }
    
}


@end
