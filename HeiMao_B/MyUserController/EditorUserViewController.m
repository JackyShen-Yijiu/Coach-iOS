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

//static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";
static NSString *const ktagArrChange = @"ktagArrChange";

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)


@interface EditorUserViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIImageView *userHeadImage;
@property (strong, nonatomic) NSArray *detailDataArray;
@property (strong, nonatomic) NSString *qiniuToken;

@property (strong, nonatomic) NSMutableArray *systemTagArray;
@property (strong, nonatomic) NSMutableArray *customTagArray;

@end

@implementation EditorUserViewController
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"",@"姓名"],@[@"身份证",@"联系电话",@"教练证",@"驾龄",@"性别"],@[@"个性标签",@"个人说明"]];
    }
    return _dataArray;
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

- (NSArray *)detailDataArray {
    
    NSString * name = [UserInfoModel defaultUserInfo].name;
    NSArray * item1 = @[@"",[self strTolerance:name]
                        ];
    
    NSString * idcardnumber = [UserInfoModel defaultUserInfo].idcardnumber;
    NSString * tel = [UserInfoModel defaultUserInfo].tel;
    NSString * dirving = [UserInfoModel defaultUserInfo].drivinglicensenumber;
    NSString * gender = [UserInfoModel defaultUserInfo].Gender;
    NSArray * item2 = @[
                        [self strTolerance:idcardnumber],
                        [self strTolerance:tel],
                        [self strTolerance:dirving],
                        [self strTolerance:[NSString stringWithFormat:@"%lu",[UserInfoModel defaultUserInfo].Seniority]],
                        [self strTolerance:gender],
                        ];
    
    NSString * intruduce = [UserInfoModel defaultUserInfo].introduction;    
    NSArray * item3 = @[
                         @"",
                         [self strTolerance:intruduce]
                         ];
    
    _detailDataArray = @[item1,
                         item2,
                         item3];
    return _detailDataArray;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [self startNetWork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑信息";
    
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(genderChange) name:kGenderChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signatureChange) name:kSignatureChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nameChange) name:kmodifyNameChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nickNameChange) name:kIDCardChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAddressChange) name:kPhoneNumChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(drivingNumChange) name:kDrivingNumChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tagArrayChange) name:ktagArrChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyjialinKey) name:modifyjialinKey object:nil];

}

- (void)startNetWork {
    
    NSString *coachTags = [NSString stringWithFormat:@"%@/%@",[NetWorkEntiry domain],kcoachTags];
    [JENetwoking startDownLoadWithUrl:coachTags postParam:@{@"coachid":[UserInfoModel defaultUserInfo].userID} WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        [self.systemTagArray removeAllObjects];
        [self.customTagArray removeAllObjects];
        NSLog(@"%@",data);
        NSDictionary *dic = data;
        if ([[dic objectForKey:@"type"] integerValue] == 1) {
            NSArray *systemTagArr = [[data objectForKey:@"data"] objectForKey:@"systemtag"];
            NSArray *customTagArr = [[data objectForKey:@"data"] objectForKey:@"selft"];
            for (NSDictionary *subSystemTagDic in systemTagArr) {
                [self.systemTagArray addObject:[PersonlizeModel converJsonDicToModel:subSystemTagDic]];
            }
            for (NSDictionary *subCustomTagDic in customTagArr) {
                [self.customTagArray addObject:[PersonlizeModel converJsonDicToModel:subCustomTagDic]];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:ktagArrChange object:nil];
        }
    }];
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
- (void)signatureChange {     //个人说明改变
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)tagArrayChange {     //标签数组改变
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 && indexPath.row == 0) {
        return 240;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        NSArray *arr = @[];
        if (self.systemTagArray) {
            NSMutableArray *tagArr = [[NSMutableArray alloc] init];
           
            for (PersonlizeModel *model in self.systemTagArray) {
                if (model.is_audit.integerValue == 0 && model.is_choose.integerValue == 1) {
                    [tagArr addObject:model.tagname];
                }
            }
            for (PersonlizeModel *model in self.customTagArray) {
                if (model.is_audit.integerValue == 0) {
                    [tagArr addObject:model.tagname];
                }
            }
            arr = [tagArr copy];
        }
        return [PersonalizeLabelCell cellHeightWithArray:arr];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        NSString *string = self.detailDataArray[indexPath.section][indexPath.row];
        CGRect bounds = [string boundingRectWithSize:
                         CGSizeMake([[UIScreen mainScreen] bounds].size.width - 30, 10000) options:
                         NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil];
        return 20+bounds.size.height+10;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy_1"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"yy_1"];
        }
        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.numberOfLines = 0;
        return cell;
    }
    if (indexPath.row == 0 && indexPath.section == 2) {
        PersonalizeLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yy"];
        for (UIView *view in cell.contentView.subviews) {
            UILabel *label = (UILabel *)view;
            if (![label.text isEqualToString:@"个性标签"]) {
                [view removeFromSuperview];
            }
        }
        if (!cell) {
            cell = [[PersonalizeLabelCell alloc] initWithStyle:0 reuseIdentifier:@"yy"];
        }
        NSArray *arr = @[];
        NSMutableArray *tagBackgroundColorArr = [[NSMutableArray alloc] init];
        if (self.systemTagArray.count >0) {
            NSMutableArray *tagArr = [[NSMutableArray alloc] init];
            for (PersonlizeModel *model in self.systemTagArray) {
                if (model.is_audit.integerValue == 0 && model.is_choose.integerValue == 1) {
                    [tagArr addObject:model.tagname];
                    [tagBackgroundColorArr addObject:model.color];
                }
            }
            for (PersonlizeModel *model in self.customTagArray) {
                if (model.is_audit.integerValue == 0) {
                    [tagArr addObject:model.tagname];
                    [tagBackgroundColorArr addObject:model.color];
                }
            }
            arr = [tagArr copy];
        }
        [cell initUIWithArray:arr withLabel:self.dataArray[indexPath.section][indexPath.row] withBackGroundColorArr:[tagBackgroundColorArr copy]];
        return cell;
    }
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
        self.userHeadImage.image = [UIImage imageNamed:@"littleImage.png"];
        [cell.contentView addSubview:self.userHeadImage];
        if ([UserInfoModel defaultUserInfo].portrait) {
            [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.text = self.detailDataArray[indexPath.section][indexPath.row];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [JEPhotoPickManger pickPhotofromController:self];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
      ModifyNameViewController *modifyName = [[ModifyNameViewController alloc] init];
      [self.navigationController pushViewController:modifyName animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 4) {
        GenderViewController *gender = [[GenderViewController alloc] init];
        [self.navigationController pushViewController:gender animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 1) {
        SignatureViewController *signature = [[SignatureViewController alloc] init];
        [self.navigationController pushViewController:signature animated:YES];
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        IDCardNumViewController *idcar = [[IDCardNumViewController alloc] init];
        [self.navigationController pushViewController:idcar animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 1) {
        PhoneNumViewController *phoneNum = [[PhoneNumViewController alloc] init];
        [self.navigationController pushViewController:phoneNum animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        DrivingNumViewController *driving = [[DrivingNumViewController alloc] init];
        [self.navigationController pushViewController:driving animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        PersonaizeLabelController *plc = [[PersonaizeLabelController alloc] init];
        plc.systemTagArray = self.systemTagArray;
        plc.customTagArray = self.customTagArray;
        [self.navigationController pushViewController:plc animated:YES];
    }else if (indexPath.section==1&&indexPath.row==3){
        modifyjialinViewController *vc = [[modifyjialinViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
