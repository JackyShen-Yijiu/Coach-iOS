//
//  EditorUserViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "EditorUserViewController.h"
#import "PFActionSheetView.h"
#import "JEPhotoPickManger.h"
#import "ToolHeader.h"
#import "JENetwoking.h"
#import "GenderViewController.h"
#import "SignatureViewController.h"
#import "ModifyNameViewController.h"
#import "IDCardNumViewController.h"
#import <QiniuSDK.h>
#import "PhoneNumViewController.h"
#import "JsonTransformManager.h"
#import "DrivingNumViewController.h"
#import "PersonalizeLabelCell.h"
#import "PersonaizeLabelController.h"
#import "PersonlizeModel.h"
#import "modifyjialinViewController.h"

#import "TrainingGroundViewController.h"
#import "WorkTimeViewController.h"
#import "TeachSubjectViewController.h"
#import "EditorUseTopCell.h"
#import "EditorUseBottomCell.h"
#import "WorkNatureController.h"




//static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";
static NSString *const ktagArrChange = @"ktagArrChange";

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)


@interface EditorUserViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *dataArray;

@property (nonatomic, strong) NSArray *imgArray;

@property (strong, nonatomic) UIImageView *userHeadImage;

@property (strong, nonatomic) NSArray *detailDataArray;

@property (strong, nonatomic) NSString *qiniuToken;

@property (strong, nonatomic) NSMutableArray *systemTagArray;

@property (strong, nonatomic) NSMutableArray *customTagArray;

@property (strong, nonatomic) NSArray *strArray;

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UILabel *footerLabel;

@end

@implementation EditorUserViewController
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@""],@[@"姓名",@"性别",@"身份证",@"手机号码"],@[@"教练证",@"教龄",@"工作性质",@"可授科目",@"训练场地"],@[@"个人说明"]];
    }
    return _dataArray;
}
- (NSArray *)imgArray{
    if (_imgArray == nil) {
        _imgArray = @[@[@""],@[@"name.png",@"sex",@"card",@"phone"],@[@"permit",@"age",@"work",@"teach",@"site"],@[@"explain"]];
    }
    return _imgArray;
}
- (NSMutableArray *)systemTagArray {
    if (!_systemTagArray) {
        _systemTagArray = [[NSMutableArray alloc] init];
    }
    return _systemTagArray;
}

- (NSMutableArray *)customTagArray {
    if (!_customTagArray) {
        _customTagArray = [[NSMutableArray alloc] init];
    }
    return _customTagArray;
}
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 66)];
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}
- (UILabel *)footerLabel{
    if (_footerLabel == nil) {
        _footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, self.view.width - 16, 50)];
        _footerLabel.font = [UIFont systemFontOfSize:12];
        _footerLabel.numberOfLines = 0;
        _footerLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _footerLabel;
}
- (NSArray *)detailDataArray {
    /*
     {
     Gender = "\U7537";
     Seniority = 0;
     address = "\U6d77\U6dc0\U533a\U4e2d\U5173\U6751";
     carmodel =     {
     code = C1;
     modelsid = 1; 1 直营教练  2 挂靠教练
     name = "\U624b\U52a8\U6321\U6c7d\U8f66";
     };
     cartype = "";
     coachid = 564227ec1eb4017436ade69c;
     coachnumber = 5455454848456645;
     coachtype = 1;
     commentcount = 10;
     createtime = "2015-11-10T17:21:04.368Z";
     displaycoachid = 100061;
     driveschoolinfo =     {
     id = 56c71dc8de346bda5466f8ef;
     name = "\U4e00\U6b65\U9a7e\U6821 \U592a\U539f\U5206\U6821";
     };
     drivinglicensenumber = 130503196404010719vsv;
     email = "";
     fcode = "";
     headportrait =     {
     height = "";
     originalpic = "http://7xnjg0.com1.z0.glb.clouddn.com/564227ec1eb4017436ade69c1455614511222";
     thumbnailpic = "";
     width = "";
     };
     idcardnumber = "56565656525845****";
     introduction = "\U5982\U679c\U5728\U5b66\U8f66\U8fc7\U7a0b\U4e2d\U9047\U5230\U4e86\U4e00\U4e2a\U57f9\U8bad\U7ecf\U9a8c\U4e30\U5bcc\U4e14\U6027\U683c\U723d\U6717\U7684\U6559\U7ec3\Uff0c\U90a3\U4e48\U4f60 \U5c06\U5ea6\U8fc7\U4e00\U4e2a\U6109\U5feb\U7684\U5b66\U8f66\U8fc7\U7a0b\U3002\U8010\U5fc3\U7684\U6559\U5b66\U6001\U5ea6\Uff0c\U72ec\U7279\U7684\U6559\U5b66\U7406\U5ff5\U6765\U8fce\U63a5\U6bcf\U4e00\U4f4d\U5b66\U5458\U3002   \U54c8\U54c8";
     invitationcode = 1061;
     "is_lock" = 0;
     "is_shuttle" = 0;
     "is_validation" = 1;
     leavebegintime = 1469155140;
     leaveendtime = 1477104000;
     logintime = "2016-03-25T11:52:56.697Z";
     md5Pass = e10adc3949ba59abbe56e057f20f883e;
     mobile = 18444444001;
     name = "\U5218\U5947\U82b3";
     passrate = 99;
     platenumber = "<null>";
     serverclass = 8;
     shuttlemsg = "\U6682\U4e0d\U63d0\U4f9b\U63a5\U9001\U670d\U52a1";
     starlevel = 5;
     studentcoount = 10;
     subject =     (
     {
     "_id" = 56d949f20402bf7762d86af5;
     name = "\U79d1\U76ee\U4e8c";
     subjectid = 2;
     },
     {
     "_id" = 56d949f20402bf7762d86af4;
     name = "\U79d1\U76ee\U4e09";
     subjectid = 3;
     }
     );
     tagslist =     (
     {
     "_id" = 56a0d121a835f788669cb3db;
     color = "#ffb814";
     tagname = "\U4e94\U661f\U7ea7\U6559\U7ec3";
     tagtype = 0;
     },
     {
     "_id" = 569e34ba77e15ea1406264ad;
     color = "#ef56b9";
     tagname = "\U5f88\U597d";
     tagtype = 1;
     },
     {
     "_id" = 569eddcb77e15ea1406264b7;
     color = "#20d1bc";
     tagname = "\U4f60\U5c31";
     tagtype = 1;
     },
     {
     "_id" = 56a096c5b23b45e15310833b;
     color = "#20d1bc";
     tagname = "\U80e1\U5929";
     tagtype = 1;
     },
     {
     "_id" = 56a0d09cbb44dfc956b95822;
     color = "#45cbfb";
     tagname = "\U660e\U5e74";
     tagtype = 1;
     },
     {
     "_id" = 56a0e00df1bd513a58ffc23a;
     color = "#ef56b9";
     tagname = "\U62b9\U54af";
     tagtype = 1;
     },
     {
     "_id" = 56a0e02bf1bd513a58ffc23b;
     color = "#d755f2";
     tagname = "\U4e86\U89e3";
     tagtype = 1;
     }
     );
     token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI1NjQyMjdlYzFlYjQwMTc0MzZhZGU2OWMiLCJ0aW1lc3RhbXAiOiIyMDE2LTAzLTI1VDExOjUyOjU2LjY5N1oiLCJhdWQiOiJibGFja2NhdGUiLCJpYXQiOjE0NTg5MDY3NzZ9.fjkjrUQ3e6ahq-_dDbZdeG-9ZuTiD95i0W4DbeBflNQ";
     trainfieldlinfo =     {
     id = 561636cc21ec29041a9af88e;
     name = "\U4e00\U6b65\U9a7e\U6821\U7b2c\U4e00\U8bad\U7ec3\U573a";
     };
     usersetting =     {
     classremind = 1;
     newmessagereminder = 1;
     reservationreminder = 1;
     };
     validationstate = 3;
     worktimedesc = "\U5468\U4e00\U5468\U4e8c\U5468\U4e09\U5468\U56db\U5468\U4e94\U5468\U516d 0:00--23:00";
     worktimespace =     {
     begintimeint = 0;
     endtimeint = 23;
     };
     workweek =     (
     1,
     2,
     3,
     4,
     5,
     6
     );
     }
     
     */

    // 数组一
     NSArray *item1 = @[@""];
    
    // 数组二
    NSString * name = [UserInfoModel defaultUserInfo].name;
    NSString * gender = [UserInfoModel defaultUserInfo].Gender;
    NSString * idcardnumber = [UserInfoModel defaultUserInfo].idcardnumber;
    NSString * tel = [UserInfoModel defaultUserInfo].tel;
    NSArray *item2 = @[[self strTolerance:name],[self strTolerance:gender],[self strTolerance:idcardnumber],[self strTolerance:tel]];
    
    // 数组三
    NSString *coachNumber = [NSString stringWithFormat:@"%lu",[UserInfoModel defaultUserInfo].coachNumber];
    NSString *seniority = [NSString stringWithFormat:@"%lu",[UserInfoModel defaultUserInfo].Seniority];
    NSString *workWay = nil;
    if (0 == [UserInfoModel defaultUserInfo].coachtype) {
        workWay = @"挂靠教练";
    } else if (1 == [UserInfoModel defaultUserInfo].coachtype){
        workWay = @"直营教练";
    }
    //可授科目
    NSArray *array = [UserInfoModel defaultUserInfo].subject;
    NSMutableString *string = [[NSMutableString alloc] init];
    if (array.count == 0) {
        [string appendString:@"未设置"];
    }else if(array.count == 1){
        [string appendString:[[array firstObject] objectForKey:@"name"]];
    }else{
        [string appendString:@"已设置"];
    }

    NSString *trainName = [UserInfoModel defaultUserInfo].trainfieldlinfo[@"name"]; // 训练场地
    
    
    NSArray *item3 = @[
                        [self strTolerance:coachNumber],
                        [self strTolerance:seniority],
                        [self strTolerance:workWay],
                        [self strTolerance:trainName],
                        [self strTolerance:string]
                    
                        ];
    // 数组四
    NSString * intruduce = [UserInfoModel defaultUserInfo].introduction;
    NSArray * item4 = @[[self strTolerance:intruduce]];
                        
    
    _detailDataArray = @[item1,
                         item2,
                         item3,
                         item4];
    return _detailDataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSystemWide, kSystemHeight - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
//    [self startAddData];
    self.footerLabel.text = [UserInfoModel defaultUserInfo].introduction;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    self.title = @"个人信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    if ([UIDevice jeSystemVersion] >= 7.0f) {
//        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    // 设置tableView的footview
    [self.footerView addSubview:self.footerLabel];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(genderChange) name:kGenderChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signatureChange) name:kSignatureChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChange) name:kmodifyNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameChange) name:kIDCardChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAddressChange) name:kPhoneNumChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drivingNumChange) name:kDrivingNumChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tagArrayChange) name:ktagArrChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyjialinKey) name:modifyjialinKey object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trainGroundKey) name:ktrainGroundKey object:nil]; // 训练场地
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(worktimeKey) name:kworktimeKey object:nil]; // 工作时间
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teachSubjectKey) name:kteachSubjectKey object:nil]; // 可授科目

}
- (void)startAddData{
    // 训练场地
    NSString * trainName = [[UserInfoModel defaultUserInfo].trainfieldlinfo objectStringForKey:@"name"];
    NSLog(@"trainName:%@",trainName);
    if (trainName==nil) {
        trainName = @"未设置";
    }
    
    // 工作时间
    NSArray * weekArray = [[UserInfoModel defaultUserInfo] workweek];
    
    NSLog(@"weekArray:%@",weekArray);
    NSLog(@"weekArray.count:%lu",weekArray.count);
    
    BOOL isInclude = [weekArray containsObject:@(7)];
    NSLog(@"isInclude:%d",isInclude);
    if (isInclude) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:weekArray];
        [tempArray removeObject:@(7)];
        weekArray = tempArray;
        [UserInfoModel defaultUserInfo].workweek = weekArray;
    }
    
    NSString * workSetDes = @"未设置";
    
    if (weekArray) {
        
        NSArray *newArray = [self bubbleSort:weekArray];
        NSLog(@"newArray:%@",newArray);
        for (int i = 0;i<newArray.count;i++) {
            NSLog(@"i:%d",[newArray[i] intValue]);
        }
        
        if (newArray && newArray.count>0) {
            
            NSMutableString *mutableStr = [NSMutableString string];
            
            if (newArray.count==7) {
                
                [mutableStr appendString:@"周一至周日"];
                
            }else{
                
                for (int i = 0; i<newArray.count; i++) {
                    
                    NSString *endDate = [NSString stringWithFormat:@"%@",[self dateStringWithDateNumber:[newArray[i] integerValue]]];
                    [mutableStr appendString:endDate];
                    
                }
                
            }
            
            workSetDes = mutableStr;
            
        }
        
    }
    
    //可授科目
    NSArray *array = [UserInfoModel defaultUserInfo].subject;
    NSMutableString *string = [[NSMutableString alloc] init];
    if (array.count == 0) {
        [string appendString:@"未设置"];
    }else if(array.count == 1){
        [string appendString:[[array firstObject] objectForKey:@"name"]];
    }else{
        [string appendString:@"已设置"];
    }
    self.strArray = [NSArray arrayWithObjects:trainName,workSetDes,string, nil];
    [self.tableView reloadData];

}
- (NSArray *)bubbleSort:(NSArray *)arg{//冒泡排序算法
    
    NSMutableArray *args = [NSMutableArray arrayWithArray:arg];
    
    for(int i=0;i<args.count-1;i++){
        
        for(int j=i+1;j<args.count;j++){
            
            if (args[i]>args[j]){
                
                int temp = [args[i] intValue];
                
                [args replaceObjectAtIndex:i withObject:args[j]];
                
                args[j] = @(temp);
                
            }
        }
    }
    return args;
}


- (NSString *)dateStringWithDateNumber:(NSInteger)number
{
    if (number==0) {
        return @"周日";
    }else if (number==1){
        return @"周一";
    }else if (number==2){
        return @"周二";
    }else if (number==3){
        return @"周三";
    }else if (number==4){
        return @"周四";
    }else if (number==5){
        return @"周五";
    }else if (number==6){
        return @"周六";
    }
    return nil;
}

- (void)nameChange {          //名字改变
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)nickNameChange {      //身份证改变
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)drivingNumChange {    //驾驶证改变
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)modifyjialinKey
{    //驾龄
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)addAddressChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)genderChange {        //性别改变
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
//- (void)trainGroundKey {        //训练场地
//    NSIndexPath *path = [NSIndexPath indexPathForRow:5 inSection:1];
//    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//}
//- (void)worktimeKey {        //工作时间
//    NSIndexPath *path = [NSIndexPath indexPathForRow:6 inSection:1];
//    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//}
//- (void)teachSubjectKey {        //可授科目
//    NSIndexPath *path = [NSIndexPath indexPathForRow:7 inSection:1];
//    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//}
- (void)signatureChange {     //个人说明改变
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tagArrayChange {     //标签数组改变
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (0 == indexPath.section) {
        return 80;
    }
    return 44;
//    if (indexPath.section == 2 && indexPath.row == 1) {
//        NSString *string = self.detailDataArray[indexPath.section][indexPath.row];
//        CGRect bounds = [string boundingRectWithSize:
//                         CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
//                         NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil];
//        return 20+bounds.size.height+10;
//    }
//    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
////    if (section == 0) {
////        return 0;
////    }
////    return 20;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        static NSString *IDtopCell = @"topCell";
        EditorUseTopCell *editorCell = [tableView dequeueReusableCellWithIdentifier:IDtopCell];
        if (!editorCell) {
            editorCell = [[EditorUseTopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDtopCell];
        }
        if ([UserInfoModel defaultUserInfo].portrait) {
            [editorCell.iconImgeView sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
        
        
        return editorCell;
    } else{
        static NSString *IDBottomCell = @"bottomCell";
        EditorUseBottomCell *editorBottomCell = [tableView dequeueReusableCellWithIdentifier:IDBottomCell];
        if (!editorBottomCell) {
            editorBottomCell = [[EditorUseBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDBottomCell];
        }
        // 隐藏右侧的箭头
        if (1 == indexPath.section) {
            if (0 == indexPath.row || 1 == indexPath.row || 2 == indexPath.row) {
                editorBottomCell.arrowImageView.hidden = YES;
            }
        }
        if (2 == indexPath.section) {
            if (2 == indexPath.row) {
                editorBottomCell.arrowImageView.hidden = YES;
            }
        }
        // 隐藏详情展示
        if (3 == indexPath.section) {
             editorBottomCell.detailLabel.hidden = YES;
        }
        
        editorBottomCell.iconImgeView.image = [UIImage imageNamed:self.imgArray[indexPath.section][indexPath.row]];
        editorBottomCell.titleLabel.text =  self.dataArray[indexPath.section][indexPath.row];
        editorBottomCell.detailLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
        
        return editorBottomCell;

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    if (indexPath.section == 2 && indexPath.row == 1) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_1"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yy_1"];
//        }
//        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
//        cell.detailTextLabel.numberOfLines = 0;
//        return cell;
//    }
//    static NSString *cellId = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    if ((indexPath.row == 5 && indexPath.section == 1) || (indexPath.row == 6 && indexPath.section == 1) || (indexPath.row == 7 && indexPath.section == 1)) {
//        NSLog(@"indexPath.section = %lu,indexPath.row= %lu",indexPath.section,indexPath.row);
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
//        cell.textLabel.textColor = [UIColor blackColor];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.detailTextLabel.text = self.strArray[indexPath.row - 5];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
//
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
//        cell.textLabel.textColor = [UIColor blackColor];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
//        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
//
//    }
//    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 头像
        [JEPhotoPickManger pickPhotofromController:self];
    }
    
    
    if (indexPath.section == 1 && 3 == indexPath.row) {
        // 手机号
        PhoneNumViewController *phoneNum = [[PhoneNumViewController alloc] init];
        [self.navigationController pushViewController:phoneNum animated:YES];
    }
   
    if (2 == indexPath.section && 0 == indexPath.row) {
         // 教练证
        DrivingNumViewController *driving = [[DrivingNumViewController alloc] init];
        [self.navigationController pushViewController:driving animated:YES];
        
    }
    if (2 == indexPath.section && 1 == indexPath.row) {
        // 教龄
        modifyjialinViewController *vc = [[modifyjialinViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (2 == indexPath.section && 2 == indexPath.row) {
        // 工作性质
        
        WorkNatureController *workNatureVC = [[WorkNatureController alloc] init];
        [self.navigationController pushViewController:workNatureVC animated:YES];
        
    }
    if (2 == indexPath.section && 3 == indexPath.row) {
        // 可授科目
        TeachSubjectViewController *teach = [[TeachSubjectViewController alloc] init];
        [self.navigationController pushViewController:teach animated:YES];
        
    }
    if (2 == indexPath.section && 4 == indexPath.row) {
        // 训练场地
        if ([UserInfoModel defaultUserInfo].schoolId) {
            TrainingGroundViewController *training = [[TrainingGroundViewController alloc] init];
            [self.navigationController pushViewController:training animated:YES];
        }

    }
    if (3 == indexPath.section ) {
        // 个人说明
        SignatureViewController *signatureVC = [[SignatureViewController alloc] init];
        [self.navigationController pushViewController:signatureVC animated:YES];
        
        
    }
    
    
    
//    }else if (indexPath.section == 1 && indexPath.row == 2) {
//        
//    }else if (indexPath.section == 2 && indexPath.row == 0) {
//        PersonaizeLabelController *plc = [[PersonaizeLabelController alloc] init];
//        plc.systemTagArray = self.systemTagArray;
//        plc.customTagArray = self.customTagArray;
//        [self.navigationController pushViewController:plc animated:YES];
//    }else if (indexPath.section==1&&indexPath.row==3){
//        
//    }else if (indexPath.section==1&&indexPath.row==5)
//    { // 训练场地
//            }else if (indexPath.section==1&&indexPath.row==6){ // 工作时间
//        WorkTimeViewController *workTime = [[WorkTimeViewController alloc] init];
//        [self.navigationController pushViewController:workTime animated:YES];
//    }else if (indexPath.section==1&&indexPath.row==7){ // 可授科目
//        
//
//    }
}
#pragma mark - delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"data = %@",info);

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info valueForKey:UIImagePickerControllerEditedImage];
    NSData *photeoData = UIImageJPEGRepresentation(photoImage, 0.5);
    self.userHeadImage.image = photoImage;
    
    
    __weak EditorUserViewController *weakself = self;
    __block NSData *gcdPhotoData = photeoData;
    NSString *qiniuUrl = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kQiniuUpdateUrl];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        weakself.qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[UserInfoModel defaultUserInfo].userID];
        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
           
            if (info) {
                NSLog(@"key = %@",key);
                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kupdateUserInfo];
                NSDictionary *headPortrait  = @{@"originalpic":upImageUrl,@"thumbnailpic":@"",@"width":@"",@"height":@""};
                
                NSDictionary *dicParam = @{@"headportrait":headPortrait,@"coachid":[UserInfoModel defaultUserInfo].userID};
                [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
                    if (!data) {
                        [self showTotasViewWithMes:@"网络异常，请稍后再试"];
                        return ;
                    }
                    
                    NSDictionary *dataParam = data;
                    NSNumber *messege = dataParam[@"type"];
                    NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
                    DYNSLog(@"msg = %@ %@",data,dataParam[@"msg"]);
                    if (messege.intValue == 1) {
                        
                        [self showTotasViewWithMes:@"修改成功"];
                        
                        [UserInfoModel defaultUserInfo].portrait =  upImageUrl;

                        [weakself.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageWithData:gcdPhotoData]];

                    }else {
                        if (msg)
                            [self showTotasViewWithMes:msg];
                    }
                }];
            }
        } option:nil];
    }];


}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.title = @"照片";
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kDefaultTintColor forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0, 0, 44, 44);
    [cancelBtn addTarget:self action:@selector(clickCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    viewController.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
