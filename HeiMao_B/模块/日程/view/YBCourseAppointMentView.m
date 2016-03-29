//
//  YBCourseAppointMentView.m
//  HeiMao_B
//
//  Created by JiangangYang on 16/3/28.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "YBCourseAppointMentView.h"
#import "YBAppointMentUserCell.h"

@interface YBCourseAppointMentView ()<UICollectionViewDataSource,UICollectionViewDelegate>

// 中间预约学员
@property (nonatomic,strong) UICollectionView *coureStudentCollectionView;

@end

@implementation YBCourseAppointMentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.itemSize = CGSizeMake(coureSundentCollectionW, coureSundentCollectionH);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        self.coureStudentCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        self.coureStudentCollectionView.backgroundColor = [UIColor redColor];
        self.coureStudentCollectionView.delegate = self;
        self.coureStudentCollectionView.dataSource = self;
        [self.coureStudentCollectionView registerClass:[YBAppointMentUserCell class] forCellWithReuseIdentifier:@"YBAppointMentUserCell"];
        [self addSubview:self.coureStudentCollectionView];
        
    }
    return self;
}

- (CGFloat)courseAppointMentViewWithCourseData:(YBCourseData *)model
{
    
    self.model = model;
    
    NSInteger studentCount = model.coursestudentcount;
    NSInteger hangshu = studentCount % 5;
    NSLog(@"hangshu:%ld",(long)hangshu);
    CGFloat coureStudentCollectionViewH = (coureSundentCollectionH + 16) * (hangshu + 1);
    NSLog(@"setModel coureStudentCollectionViewH:%f",coureStudentCollectionViewH);
    
    return coureStudentCollectionViewH;
}

- (void)setModel:(YBCourseData *)model
{
    _model = model;
    
    [self.coureStudentCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
    
    return _model.coursestudentcount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"YBAppointMentUserCell";
    YBAppointMentUserCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    cell.iconImageView.image = [UIImage imageNamed:@"JZCourseadd_student"];
    
    cell.nameLabel.text = @"姓名";
    
    if (_model.coursereservationdetial.count<indexPath.row) {
        
        NSDictionary *dict = _model.coursereservationdetial[indexPath.row];
        
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dict[@"userid"][@"headportrait"][@"originalpic"]]] placeholderImage:[UIImage imageNamed:@"JZCourseadd_student"]];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",dict[@"userid"][@"name"]];
        
    }else{
        
        cell.iconImageView.image = [UIImage imageNamed:@"JZCourseadd_student"];
        
        cell.nameLabel.text = @"姓名";
    }
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
}

@end
