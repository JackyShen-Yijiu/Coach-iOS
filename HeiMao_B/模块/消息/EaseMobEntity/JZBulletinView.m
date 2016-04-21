//
//  JZBulletinView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZBulletinView.h"
#import "JZBulletinCell.h"
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
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
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
        
        listCell.backgroundColor = [UIColor clearColor];
        
    }

    
    return listCell;
    
}
#pragma mark - 代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 1;
    
}

#pragma mark - 网络请求，加载数据
-(void)loadData {
    
    
}

-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}

-(void)viewDidLayoutSubviews {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])  {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}


@end
