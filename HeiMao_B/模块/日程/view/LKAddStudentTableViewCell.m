//
//  AddStudentTableViewCell.m
//  添加学员
//
//  Created by 雷凯 on 16/3/28.
//  Copyright © 2016年 leifaxian. All rights reserved.
//

#import "LKAddStudentTableViewCell.h"
#import "Masonry.h"

@implementation LKAddStudentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self = [[NSBundle mainBundle]loadNibNamed:@"LKAddStudentTableViewCell" owner:self options:nil].lastObject;
        

        self.studentNameLabel.backgroundColor = [UIColor whiteColor];
        
        
//        self.studyDetilsLabel.text = @"studyDetilsLabel";
        
        self.studentIconView.image = [UIImage imageNamed:@"JZCoursehead_null"];
        
        self.studentIconView.layer.cornerRadius = 24;
        
        self.studentIconView.layer.masksToBounds = YES;
        
      
    }
    return self;
}


- (void)setModel:(LKAddStudentData *)model
{
    _model = model;
    
    self.studentNameLabel.text = [NSString stringWithFormat:@"%@",_model.name];
    

}




@end
