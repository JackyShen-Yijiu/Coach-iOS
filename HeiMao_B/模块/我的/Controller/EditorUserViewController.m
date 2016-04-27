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
#define KpickViewH  200
#define ktitleViewH 45


@interface EditorUserViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
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

// 教龄选择器

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *bgPick;

@property (nonatomic, strong) UILabel *teachageLabel;

@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *teachAgeArray;

@property (nonatomic, strong) NSString *resultAgeStr;

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
- (NSArray *)teachAgeArray{
    if (_teachAgeArray == nil) {
        _teachAgeArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40"];
    }
    return _teachAgeArray;
}
- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - KpickViewH)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.32;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
        [_bgView addGestureRecognizer:tapGe];
    }
    return _bgView;
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
        
        if (YBIphone6Plus) {
            
            _footerLabel.font = [UIFont systemFontOfSize:12 *JZRatio_1_1_5];

        }else {
            
            _footerLabel.font = [UIFont systemFontOfSize:12];

        }
        _footerLabel.numberOfLines = 0;
        _footerLabel.textColor = JZ_FONTCOLOR_LIGHT;
    }
    return _footerLabel;
}
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0 , CGRectGetMaxY(self.bgPick.frame), self.view.width, KpickViewH - ktitleViewH)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
- (UIView *)bgPick{
    if (_bgPick == nil) {
        _bgPick = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - KpickViewH , self.view.width, ktitleViewH)];
        _bgPick.backgroundColor = [UIColor whiteColor];
        _bgPick.userInteractionEnabled = YES;
    }
    return _bgPick;
}
- (UILabel *)teachageLabel{
    if (_teachageLabel == nil) {
        _teachageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
        
        if (YBIphone6Plus) {
            
            _teachageLabel.font = [UIFont systemFontOfSize:14 * JZRatio_1_1_5];

        }else {
            
            _teachageLabel.font = [UIFont systemFontOfSize:14];

        }
        _teachageLabel.textColor  = JZ_FONTCOLOR_DRAK;
        _teachageLabel.text = @"教龄";
    }
    return _teachageLabel;
}
- (UIButton *)sureButton{
    if (_sureButton == nil) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.frame = CGRectMake(self.view.width - 20 - 50, 0, 50, 44);
        _sureButton.backgroundColor = [UIColor clearColor];
        [_sureButton addTarget:self action:@selector(didClickSure:) forControlEvents:UIControlEventTouchUpInside];
        [_sureButton setTitleColor:JZ_BlueColor forState:UIControlStateNormal];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        
        if (YBIphone6Plus) {
            _sureButton.titleLabel.font = [UIFont systemFontOfSize:14 *JZRatio_1_1_5];

        }else {
            _sureButton.titleLabel.font = [UIFont systemFontOfSize:14];

        }
        
    }
    return _sureButton;
}
- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgPick.height - 1, self.view.width, 1)];
        _lineView.backgroundColor = HM_LINE_COLOR;
    }
    return _lineView;
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
   NSString *subjectStr = @"";
    if (array.count == 0) {
        subjectStr = @"未设置";
    }else if(array.count){
        for (NSDictionary *dic in array) {
            subjectStr = [subjectStr stringByAppendingString:dic[@"name"]];
        }
    }

    NSString *trainName = [UserInfoModel defaultUserInfo].trainfieldlinfo[@"name"]; // 训练场地
    
    
    NSArray *item3 = @[
                        [self strTolerance:coachNumber],
                        [self strTolerance:seniority],
                        [self strTolerance:workWay],
                        [self strTolerance:subjectStr],
                        [self strTolerance:trainName]
                        
                    
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
    
    [super viewWillAppear:YES];
//    [self startAddData];
    self.footerLabel.text = [UserInfoModel defaultUserInfo].introduction;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = JZ_BACKGROUNDCOLOR_COLOR;
    self.title = @"个人信息";
    
    if (YBIphone6Plus) {
        
        UIColor * color = [UIColor whiteColor];
        UIFont *font = [UIFont systemFontOfSize:JZNavBarTitleFont];
        
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        [dict setObject:color forKey:NSForegroundColorAttributeName];
        [dict setObject:font forKey:NSFontAttributeName];
        
        self.navigationController.navigationBar.titleTextAttributes = dict;
        
    }
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    if ([UIDevice jeSystemVersion] >= 7.0f) {
//        //当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt
    // 设置tableView的footview
    [self.footerView addSubview:self.footerLabel];
    self.tableView.tableFooterView = self.footerView;
    
    [self.view addSubview:self.tableView];
    
    // 手机号码改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumChange) name:kPhoneNumChange object:nil];
    // 教练证改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drivingNumChange) name:kDrivingNumChange object:nil];
    // 教龄改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyjialinKey) name:modifyjialinKey object:nil];
    // 可授科目改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(teachSubjectKey) name:kteachSubjectKey object:nil];
    // 训练场地改变
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trainGroundKey) name:ktrainGroundKey object:nil];
    
    // 个性说明在视图将要显示的时候进行重新加载数据,所以不需添加通知了
}
#pragma mark --- 手势方法
- (void)removeView{
    [self.bgView removeFromSuperview];
    [self.pickerView removeFromSuperview];
    [self.bgPick removeFromSuperview];

    
}
- (void)startAddData{
    // 训练场地
    NSString * trainName = [[UserInfoModel defaultUserInfo].trainfieldlinfo objectStringForKey:@"name"];
    
    if (trainName == nil) {
        trainName = @"未设置";
    }
    NSLog(@"trainName:%@",trainName);
   
    
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
//    self.strArray = [NSArray arrayWithObjects:trainName,workSetDes,string, nil];
    [self.tableView reloadData];

}
// 手机号码改名
- (void)phoneNumChange{
    NSIndexPath *path  =  [NSIndexPath indexPathForRow:3 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
//  教练证改变
- (void)drivingNumChange {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
 //教龄
-(void)modifyjialinKey
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
 //可授科目
- (void)teachSubjectKey {
    NSIndexPath *path = [NSIndexPath indexPathForRow:3 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
 //训练场地
- (void)trainGroundKey {
    NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
//个人说明改变
- (void)signatureChange {
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

//- (void)worktimeKey {        //工作时间
//    NSIndexPath *path = [NSIndexPath indexPathForRow:6 inSection:1];
//    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
//}

#pragma mark ---- Action
- (void)didClickSure:(UIButton *)btn{
    // 当教龄改变时向服务器提交修改数据
    if ([self.resultAgeStr integerValue] != [UserInfoModel defaultUserInfo].Seniority) {
        [self commintCoachAgeData];
    }
    [self.bgView removeFromSuperview];
    [self.pickerView removeFromSuperview];
    [self.bgPick removeFromSuperview];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (0 == indexPath.section) {
        
        if (YBIphone6Plus) {
            
            return 80 * JZRatio_1_5;
        }else {
            return 80;

        }
        
    }
    
    if (YBIphone6Plus) {
        
        return 44 * JZRatio_1_5;
    }else {
        return 44;
        
    }
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
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
            if (2 == indexPath.row || 1 == indexPath.row) {
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
//        [self.view addSubview:self.pickerView];
//        [self.view addSubview:self.bgView];
//        [self.view addSubview:self.bgPick];
//        [self.bgPick addSubview:self.teachageLabel];
//        [self.bgPick addSubview:self.sureButton];
//        [self.bgPick addSubview:self.lineView];
        

        
    }
//    if (2 == indexPath.section && 2 == indexPath.row) {
//        // 工作性质
//        
//        WorkNatureController *workNatureVC = [[WorkNatureController alloc] init];
//        [self.navigationController pushViewController:workNatureVC animated:YES];
//        
//    }
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
    
//            }else if (indexPath.section==1&&indexPath.row==6){ // 工作时间
//        WorkTimeViewController *workTime = [[WorkTimeViewController alloc] init];
//        [self.navigationController pushViewController:workTime animated:YES];

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
    NSString *qiniuUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kQiniuUpdateUrl];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        weakself.qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[UserInfoModel defaultUserInfo].userID];
        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
           
            if (info) {
                NSLog(@"key = %@",key);
                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
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
                        [[NSNotificationCenter defaultCenter] postNotificationName:kHeadImageChange object:nil];
                        [self.tableView reloadData];

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

#pragma mark - pickerView data source and delegate

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.teachAgeArray.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.teachAgeArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *resultString = _teachAgeArray[row];
    self.resultAgeStr = resultString;

}

- (void)clickCancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -- 向服务器提交 教龄修改后的数据
- (void)commintCoachAgeData {
    
    
    NSString *updateUserInfoUrl = [NSString stringWithFormat:@"%@/%@",HOST_TEST_DAMIAN,kupdateUserInfo];
    
    NSDictionary *dicParam = @{@"Seniority":self.resultAgeStr,@"coachid":[UserInfoModel defaultUserInfo].userID};
    
    [JENetwoking startDownLoadWithUrl:updateUserInfoUrl postParam:dicParam WithMethod:JENetworkingRequestMethodPost withCompletion:^(id data) {
        
        if (!data) {
            [self showTotasViewWithMes:@"网络连接错误，请稍后再试"];
            return ;
        }
        
        NSDictionary *dataParam = data;
        NSNumber *messege = dataParam[@"type"];
        NSString *msg = [NSString stringWithFormat:@"%@",dataParam[@"msg"]];
        
        if (messege.intValue == 1) {
            
            ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:@"修改成功" controller:self];
            [alerview show];
            [UserInfoModel defaultUserInfo].Seniority = [self.resultAgeStr integerValue];
            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:2];
            [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];

            
        }else {
            if(msg){
                ToastAlertView *alerview = [[ToastAlertView alloc] initWithTitle:msg controller:self];
                [alerview show];
            }
        }
        
    }];
}

@end
