//
//  DVVSendMessageToStudentView.m
//  HeiMao_B
//
//  Created by 大威 on 16/2/3.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "DVVSendMessageToStudentView.h"
#import "DVVSendMessageToStudentCell.h"
#import "DVVToast.h"

#define kCellIdentifier @"kCellIdentifier"

@interface DVVSendMessageToStudentView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *dataTabelView;
@property (nonatomic, copy) DVVSendMessageToStudentViewBlock touchUpInsideBlock;

@end

@implementation DVVSendMessageToStudentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mobileDict = [NSMutableDictionary dictionary];
        
        [self addSubview:self.dataTabelView];
        [self configViewModel];
    }
    return self;
}

- (void)beginNetworkRequest {
    [_viewModel dvvNetworkRequestRefresh];
}

- (void)setStudentType:(NSUInteger)studentType {
    _studentType = studentType;
    _viewModel.studentType = _studentType;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _dataTabelView.frame = self.bounds;
}

#pragma mark - config view model
- (void)configViewModel {
    
    _viewModel = [DVVStudentListViewModel new];
    _viewModel.defaultIndex = 0;
    
    __weak typeof(self) ws = self;
    [_viewModel dvvSetRefreshSuccessBlock:^{
        for (DVVStudentListDMData *dmData in _viewModel.dataArray) {
            // 保存所有的电话号码
            NSString *string = [NSString stringWithFormat:@"%@", dmData.mobile];
            
            if (string && string.length) {
                [_mobileDict setValue:@"1" forKey:string];
            }
            
            NSMutableArray *mobileArray = [NSMutableArray array];
            for (NSString *string in _mobileDict.allKeys) {
                NSString *flage = [_mobileDict objectForKey:string];
                if ([flage integerValue]) {
                    [mobileArray addObject:string];
                }
            }
            
            if (_touchUpInsideBlock) {
                _touchUpInsideBlock(nil, mobileArray);
            }
            
        }
        
        [ws.dataTabelView reloadData];
    }];
    [_viewModel dvvSetNilResponseObjectBlock:^{
        // 服务器没有数据
        if (_viewModel.dataArray.count) {
            [DVVToast showMessage:@"已经全部加载完毕"];
        }else {
            if (1 == _studentType) {
                [DVVToast showMessage:@"暂时没有理论学员"];
            }else if (2 == _studentType) {
                [DVVToast showMessage:@"暂时没有上车学员"];
            }else if (3 == _studentType) {
                [DVVToast showMessage:@"暂时没有领证学员"];
            }
        }
    }];
    [_viewModel dvvSetRefreshErrorBlock:^{
        [DVVToast showMessage:@"数据加载失败"];
    }];
    [_viewModel dvvSetNetworkErrorBlock:^{
        [DVVToast showMessage:@"网络错误"];
    }];
}

#pragma mark - action
- (void)selectButtonAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    DVVStudentListDMData *dmData = _viewModel.dataArray[sender.tag];
    
    NSString *string = [NSString stringWithFormat:@"%@", dmData.mobile];
    if (string && string.length) {
        if (sender.selected) {
            [_mobileDict setValue:@"1" forKey:string];
        }else {
            [_mobileDict setValue:@"0" forKey:string];
        }
    }
    NSMutableArray *mobileArray = [NSMutableArray array];
    for (NSString *string in _mobileDict.allKeys) {
        NSString *flage = [_mobileDict objectForKey:string];
        if ([flage integerValue]) {
            [mobileArray addObject:string];
        }
    }
    
    if (_touchUpInsideBlock) {
        _touchUpInsideBlock(sender, mobileArray);
    }
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DVVSendMessageToStudentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[DVVSendMessageToStudentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        [cell.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.selectButton.tag = indexPath.row;
    DVVStudentListDMData *dmData = _viewModel.dataArray[indexPath.row];
    [cell refreshData:dmData];
    
    // 检查选中状态
    NSString *string = [NSString stringWithFormat:@"%@", dmData.mobile];
    if (string && string.length) {
        NSString *flage = [_mobileDict objectForKey:string];
        if ([flage integerValue]) {
            cell.selectButton.selected = YES;
        }else {
            cell.selectButton.selected = NO;
        }
    }
    
    return cell;
}

#pragma mark - lazy load
- (UITableView *)dataTabelView {
    if (!_dataTabelView) {
        _dataTabelView = [UITableView new];
        _dataTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dataTabelView.dataSource = self;
        _dataTabelView.delegate = self;
        // 如果是固定高度的话在这里设置比较好
        _dataTabelView.rowHeight = 100.f;
        _dataTabelView.tableFooterView = [UIView new];
    }
    return _dataTabelView;
}

#pragma mark - set block
- (void)setSelectButtonTouchUpInsideBlock:(DVVSendMessageToStudentViewBlock)handle {
    _touchUpInsideBlock = handle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
