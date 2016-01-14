//
//  PersonalizeLabelCell.m
//  HeiMao_B
//
//  Created by 胡东苑 on 16/1/13.
//  Copyright © 2016年 ke. All rights reserved.
//

#import "PersonalizeLabelCell.h"

@interface PersonalizeLabelCell () <UITextFieldDelegate> {
    NSInteger _i;
}

@end

@implementation PersonalizeLabelCell

- (void)awakeFromNib {
    // Initialization code
}

- (UILabel *)personlizeLabel {
    if (!_personlizeLabel) {
        _personlizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 60, 16)];
        _personlizeLabel.font = [UIFont systemFontOfSize:14];
//        _personlizeLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_personlizeLabel];
    }
    return _personlizeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.personlizeLabelArray = @[@"aaaaaaaaaa",@"bbbbb",@"ccccccccccccc",@"ddddddd",@"eeeeeeeeeeeeeee",@"ffffffffffffff",@"ggggggggggg",@"hhhhhhhhhhh",@"iiiiiiiiiiii",@"jjjjjjjjjjjj",@"kkkkkkkkkkkkk",@"llllllllllllllllllll",@"mm"];
    }
    return self;
}

- (void)initUIWithArray:(NSArray *)arr withLabel:(NSString *)string {
    self.personlizeLabel.text = string;
    _personlizeLabelArray = arr;
    CGFloat width = 100;
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    for (int i = 0;i < self.personlizeLabelArray.count;i++) {
        NSString *str = self.personlizeLabelArray[i];
        CGSize labelSize = [self getLabelWidthWithString:str];
        CGFloat widthSum = 0;
        for (NSNumber *contentWidth in widthArray) {
            widthSum += contentWidth.floatValue;
        }
        if (lineNum == 1) {
            
//            CGFloat right = [UIScreen mainScreen].bounds.size.width;
//            CGFloat left = widthSum + labelSize.width + (widthArray.count)*24.f + 100.f;
            
            if (widthSum + labelSize.width + (widthArray.count)*24 + 100 > [UIScreen mainScreen].bounds.size.width) {
                lineNum += 1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(labelSize.width)];
            }else {
                width = widthArray.count*24 +widthSum +100;
                [widthArray addObject:@(labelSize.width)];
            }
        }else {
            if (widthSum + labelSize.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
                lineNum +=1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(labelSize.width)];
            }else {
                width = 15+widthArray.count*24 +widthSum ;
                [widthArray addObject:@(labelSize.width)];
            }
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width,lineNum*15 +14*(lineNum -1) ,labelSize.width , labelSize.height)];
        label.text = str;
        label.backgroundColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
    }
}
+ (CGFloat)cellHeightWithArray:(NSArray *)arr {
    CGFloat width = 100;
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    for (int i = 0;i < arr.count;i++) {
        NSString *str = arr[i];
        CGSize labelSize = [[self alloc] getLabelWidthWithString:str];
        NSInteger widthSum = 0;
        for (NSNumber *contentWidth in widthArray) {
            widthSum += contentWidth.integerValue;
        }
        if (lineNum == 1) {
            
            //            NSInteger right = [UIScreen mainScreen].bounds.size.width;
            //            NSInteger left = widthSum + labelSize.width + (widthArray.count)*24 + 100;
            
            if (widthSum + labelSize.width + (widthArray.count)*24 + 100 > [UIScreen mainScreen].bounds.size.width) {
                lineNum += 1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(labelSize.width)];
            }else {
                width = widthArray.count*24 +widthSum +100;
                [widthArray addObject:@(labelSize.width)];
            }
        }else {
            if (widthSum + labelSize.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
                lineNum +=1;
                width = 15;
                [widthArray removeAllObjects];
                [widthArray addObject:@(labelSize.width)];
            }else {
                width = 15+widthArray.count*24 +widthSum ;
                [widthArray addObject:@(labelSize.width)];
            }
        }
    }
    NSLog(@"_______________%f",lineNum);
    return 30 +15*(lineNum-1) +lineNum*14;
}

#pragma mark -  no titleLabel

- (void)initUIWithNoTitleWithArray:(NSArray *)arr WithTextFieldIsExist:(BOOL)isExist withLabelColorArray:(NSArray *)colorArr{
    if (isExist) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(15, 15, [UIScreen mainScreen].bounds.size.width-30, 30)];
        tf.placeholder = @"请输入你想要添加的标签";
        tf.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.1];
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        [self.contentView addSubview:tf];
    }
    CGFloat width = 15;
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    for ( _i = 0; _i < arr.count;_i++) {
        NSString *str = arr[_i];
        CGSize labelSize = [self getLabelWidthWithString:str];
        CGFloat widthSum = 0;
        for (NSNumber *contentWidth in widthArray) {
            widthSum += contentWidth.floatValue;
        }
        if (widthSum + labelSize.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
            lineNum +=1;
            width = 15;
            [widthArray removeAllObjects];
            [widthArray addObject:@(labelSize.width)];
        }else {
            width = 15+widthArray.count*24 +widthSum ;
            [widthArray addObject:@(labelSize.width)];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(width,lineNum*15 +14*(lineNum -1) ,labelSize.width , labelSize.height)];
        if (isExist) {
            label.frame = CGRectMake(width,45+lineNum*15 +14*(lineNum -1) ,labelSize.width , labelSize.height);
        }
        label.text = str;
        label.tag = _i;
        label.userInteractionEnabled = YES;
        NSNumber *num = colorArr[_i];
        if (num.integerValue == 1) {
            label.backgroundColor = [UIColor redColor];
        }else{
            label.backgroundColor = [UIColor grayColor];
        }
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)];
        [label addGestureRecognizer:tap];
    }

}

- (void)labelClick:(UITapGestureRecognizer *)tap {
    _tapTagLabel(tap.view.tag);
}

+ (CGFloat)cellHeightWithNoTitleWithArray:(NSArray *)arr WithTextFieldIsExist:(BOOL)isExist{
    CGFloat width = 15;
    CGFloat lineNum = 1;
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];    //存宽度
    for (int i = 0;i < arr.count;i++) {
        NSString *str = arr[i];
        CGSize labelSize = [[self alloc] getLabelWidthWithString:str];
        CGFloat widthSum = 0;
        for (NSNumber *contentWidth in widthArray) {
            widthSum += contentWidth.floatValue;
        }
        if (widthSum + labelSize.width + (widthArray.count+1)*24 > [UIScreen mainScreen].bounds.size.width) {
            lineNum +=1;
            width = 15;
            [widthArray removeAllObjects];
            [widthArray addObject:@(labelSize.width)];
        }else {
            width = 15+widthArray.count*24 +widthSum ;
            [widthArray addObject:@(labelSize.width)];
        }
    }
    if (isExist) {
        return 45 + 30 +15*(lineNum-1) +lineNum*14;
    }
    return 30 +15*(lineNum-1) +lineNum*14;
}

#pragma mark - getSize

- (CGSize)getLabelWidthWithString:(NSString *)string {
    CGRect bounds = [string boundingRectWithSize:
                     CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                     NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil];
    return bounds.size;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _addTag(textField.text);
    [textField resignFirstResponder];
    textField.text = @"";
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
