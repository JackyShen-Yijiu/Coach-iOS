//
//  JZBulletinView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZBulletinView.h"
#import "JZBulletinCell.h"
#import "JZBulletinData.h"
#import <YYModel.h>

static NSString *JZBulletinCellID = @"JZBulletinCellID";

@interface JZBulletinView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *listDataArray;

@end
@implementation JZBulletinView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        [self setSeparatorInset:UIEdgeInsetsZero];
        
        [self loadData];
        
        
        
    }
    return self;
    
}


#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JZBulletinCell *listCell = [tableView dequeueReusableCellWithIdentifier:JZBulletinCellID];
    
    if (!listCell) {
        
        listCell = [[JZBulletinCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:JZBulletinCellID];
        listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        listCell.backgroundColor = [UIColor whiteColor];
        
    }
    
    JZBulletinData *dataModel = self.listDataArray[indexPath.row];
    listCell.data = dataModel;

    
    return listCell;
    
}
#pragma mark - 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JZBulletinData *dataModel = self.listDataArray[indexPath.row];
    
    
    
    return [JZBulletinCell cellHeightDmData:dataModel];
    
}

#pragma mark - 网络请求，加载数据
-(void)loadData {
    
    [NetWorkEntiry getBulletinWithSchoolId:[UserInfoModel defaultUserInfo].schoolId withUserId:[UserInfoModel defaultUserInfo].userID index:0 count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        
        NSArray *resultData = responseObject[@"data"];
        if ([[responseObject objectForKey:@"type"] integerValue]) {
            NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZBulletinData *listModel = [JZBulletinData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
            [self reloadData];
            
            
        }

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    
    
}

-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}


#pragma mark - 分割线两端置顶
-(void)viewDidLayoutSubviews {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])  {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
