//
//  JZBulletinView.m
//  HeiMao_B
//
//  Created by 雷凯 on 16/4/21.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "JZBulletinView.h"
#import "JZBulletinCell.h"
//#import "JZBulletinData.h"
#import <YYModel.h>

static NSString *JZBulletinCellID = @"JZBulletinCellID";

@interface JZBulletinView ()<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic, strong) NSMutableArray *listDataArray;


@end
@implementation JZBulletinView
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        
        self.dataSource = self;
        
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        

        [self loadData];
   
        [self setRefresh];
        
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
       
        NSLog(@"网络请求，加载数据responseObject:%@",responseObject);
        
        NSArray *resultData = responseObject[@"data"];
        if ([[responseObject objectForKey:@"type"] integerValue]) {
            NSArray *array = resultData;
            if (!array.count) {
                
                [self.vc showTotasViewWithMes:@"暂无公告"];
            }
            
            
            
            for (NSDictionary *dict in array) {
                
                JZBulletinData *listModel = [JZBulletinData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
            }
            
            [self reloadData];
            
            
        }else {
            
            [self.vc showTotasViewWithMes:@"网络出错啦"];

            
        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.vc showTotasViewWithMes:@"网络出错啦"];
        
    }];
 
}

#pragma mark - 执行刷新操作
- (void)setRefresh{
    WS(ws);
    
    self.refreshFooter.beginRefreshingBlock = ^{
        [ws networkRequestLoadMore];
    };
}
-(void)networkRequestLoadMore {
    
    JZBulletinData *dataModel = self.listDataArray.lastObject;
    
    NSLog(@"seqindexseqindex == %zd",dataModel.seqindex);
    
    [NetWorkEntiry getBulletinWithSchoolId:[UserInfoModel defaultUserInfo].schoolId withUserId:[UserInfoModel defaultUserInfo].userID index:dataModel.seqindex count:10 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        if (![responseObject[@"data"] count]) {
            
            [self.refreshFooter endRefreshing];
            self.refreshFooter.scrollView = nil;
            [self.vc showTotasViewWithMes:@"已经加载所有数据"];
            return;
            
        }

        NSArray *resultData = responseObject[@"data"];
        if ([[responseObject objectForKey:@"type"] integerValue]) {
            NSArray *array = resultData;
            for (NSDictionary *dict in array) {
                
                JZBulletinData *listModel = [JZBulletinData yy_modelWithDictionary:dict];
                
                [self.listDataArray addObject:listModel];
                
            }
            [self.refreshFooter endRefreshing];
            

            [self reloadData];
            
            
            
        }else {
            
            [self.vc showTotasViewWithMes:@"网络出错啦"];

        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.vc showTotasViewWithMes:@"网络出错啦"];
        
    }];

}


#pragma mark - lazy
-(NSMutableArray *)listDataArray {
    
    if (!_listDataArray) {
        
        _listDataArray = [[NSMutableArray alloc]init];
    }
    
    return _listDataArray;
}





@end
