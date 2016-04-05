//
//  ExamClassViewController.m
//  BlackCat
//
//  Created by 董博 on 15/9/17.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "ExamClassViewController.h"
#import "ExamClassCollectionViewCell.h"
#import "ExamClassModel.h"
#import "ToolHeader.h"
#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)

static NSString *const kExamClassType = @"userinfo/getcoachclasstype";

static NSString *const kUpClassType = @"userinfo/coachsetclass";

@interface ExamClassViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *naviBarRightButton;
@property (strong, nonatomic) ExamClassModel *examclassmodel;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *classModel;
@end

@implementation ExamClassViewController
- (UIButton *)naviBarRightButton {
    if (_naviBarRightButton == nil) {
        _naviBarRightButton = [WMUITool initWithTitle:@"完成" withTitleColor:[UIColor whiteColor] withTitleFont:[UIFont systemFontOfSize:16]];
        _naviBarRightButton.frame = CGRectMake(0, 0, 44, 44);
        [_naviBarRightButton addTarget:self action:@selector(clickRight:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _naviBarRightButton;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout  = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kSystemWide, kSystemHeight-64) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ExamClassCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"班型设置";
    self.collectionView.backgroundColor = RGBColor(247, 249, 251);
    [self.view addSubview:self.collectionView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.naviBarRightButton];
    DYNSLog(@"right = %@",self.naviBarRightButton);
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self startDownLoad];
}

- (void)startDownLoad {
    
    [self.dataArray removeAllObjects];

    NSString *urlString = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kExamClassType];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"data:%@",data);
        
        NSDictionary *dataParam = data;
        
        NSNumber *messege = dataParam[@"type"];
        
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
       
        if (messege.intValue == 1) {
            
            NSArray *array = dataParam[@"data"];
            
            for (NSDictionary *dic in array) {
                
                ExamClassModel *model = [[ExamClassModel alloc] init];
                model.classid = dic[@"classid"];
                model.classname = dic[@"classname"];
                model.price = dic[@"price"];
                model.onsaleprice = dic[@"onsaleprice"];
                model.address = dic[@"address"];
                model.is_choose = [dic[@"is_choose"] integerValue];
                
                [self.dataArray addObject:model];
                
            }
            
        }else {
            [self showTotasViewWithMes:msg];
        }
        
        [self.collectionView reloadData];
    }];
}
#pragma mark - 完成
- (void)clickRight:(UIButton *)sender {
    
    BOOL isSeleted = NO;
    for (ExamClassModel * model in self.dataArray) {
        isSeleted = model.is_choose;
        if (isSeleted) {
            break;
        }
    }
    
    if (isSeleted == NO) {
        [self showTotasViewWithMes:@"未选择班型"];
        return;
    }
    
    //NSString *urlString = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kUpClassType];
    NSMutableString * str = [NSMutableString stringWithCapacity:0];
    
    for (ExamClassModel * model in self.dataArray) {
        if (model.is_choose) {
            [str appendFormat:@"%@,",model.classid];
        }
    }
    
    NSDictionary *param = @{@"coachid":[UserInfoModel defaultUserInfo].userID,@"classtypelist":str};
    NSLog(@"param:%@ str:%@",param,str);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [NetWorkEntiry modifyExamClassCoachid:[UserInfoModel defaultUserInfo].userID classtypelist:str success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        NSDictionary *dataParam = responseObject;
        
        NSNumber *messege = dataParam[@"type"];
        
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
       
       
        
        if (messege.intValue == 1) {
            [UserInfoModel defaultUserInfo].setClassMode = YES;
//            [UserInfoModel defaultUserInfo].classModel = self.classModel;
            NSLog(@"%@",[UserInfoModel defaultUserInfo].classModel);
            [self showTotasViewWithMes:@"设置成功"];
             [[NSNotificationCenter defaultCenter] postNotificationName:kclassTypeChange object:nil];
            [self.myNavController popViewControllerAnimated:YES];
        }else {
            [self showTotasViewWithMes:msg];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    /*
    [JENetwoking startDownLoadWithUrl:urlString postParam:param WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        NSLog(@"data:%@",data);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        [UserInfoModel defaultUserInfo].setClassMode  =  YES;
       
        if (messege.intValue == 1) {
            [self showTotasViewWithMes:@"设置成功"];
            [self.myNavController popViewControllerAnimated:YES];
        }else {
            [self showTotasViewWithMes:msg];
        }
    }];
     */
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    collectionView.hidden = YES;
    if (self.dataArray.count > 0) {
        collectionView.hidden = NO;
        return self.dataArray.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    ExamClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        DYNSLog(@"创建错误");
    }
    
    ExamClassModel *model = self.dataArray[indexPath.row];
    
    cell.drivingName.text = model.classname;
    cell.moneyLabel.text = [NSString stringWithFormat:@"%@",model.price];
    cell.drivingAdress.text = model.address;
    NSLog(@"model.is_choose:%d",model.is_choose);
    
    [cell setSelectedState:model.is_choose];
  
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(kSystemWide-20, 70);
    return cellSize;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 0, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ExamClassModel *  model =  self.dataArray[indexPath.row];
    self.classModel = model.classname;
    NSLog(@"%@",self.classModel);
    model.is_choose = !model.is_choose;
    [collectionView reloadData];
}

@end
