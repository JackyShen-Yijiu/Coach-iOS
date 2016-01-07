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

//static NSString *const kupdateUserInfo = @"userinfo/updateuserinfo";

#define kDefaultTintColor   RGB_Color(0x28, 0x79, 0xF3)


@interface EditorUserViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) UIImageView *userHeadImage;
@property (strong, nonatomic) NSArray *detailDataArray;
@property (strong, nonatomic) NSString *qiniuToken;
@end

@implementation EditorUserViewController
- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"头像",@"用户名"],@[@"身份证",@"联系电话",@"驾驶证"],@[@"性别",@"自我介绍"]];
    }
    return _dataArray;
}

- (NSArray *)detailDataArray {
    
    NSString * name = [UserInfoModel defaultUserInfo].name;
    NSArray * item1 = @[@"",
                        [self strTolerance:name]
                        ];
    
    NSString * idcardnumber = [UserInfoModel defaultUserInfo].idcardnumber;
    NSString * tel = [UserInfoModel defaultUserInfo].tel;
    NSString * dirving = [UserInfoModel defaultUserInfo].drivinglicensenumber;
    NSArray * item2 = @[
                        [self strTolerance:idcardnumber],
                        [self strTolerance:tel],
                        [self strTolerance:dirving]
                        ];
    
    NSString * Gender = [UserInfoModel defaultUserInfo].Gender;
    NSString * intruduce = [UserInfoModel defaultUserInfo].introduction;    
    NSArray * item3 = @[
                         [self strTolerance:Gender],
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

}
- (void)drivingNumChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)addAddressChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)nickNameChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)nameChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)genderChange {
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)signatureChange {
    NSIndexPath *path = [NSIndexPath indexPathForItem:1 inSection:2];
    [self.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0 && indexPath.section == 0) {
        self.userHeadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.userHeadImage.image = [UIImage imageNamed:@"littleImage.png"];
        cell.accessoryView = self.userHeadImage;
        if ([UserInfoModel defaultUserInfo].portrait) {
            [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[UserInfoModel defaultUserInfo].portrait] placeholderImage:[UIImage imageNamed:@"littleImage.png"]];
        }
    }else {
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
    else if (indexPath.section == 2 && indexPath.row == 0) {
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
//        PhoneNumViewController *phoneNum = [[PhoneNumViewController alloc] init];
//        [self.navigationController pushViewController:phoneNum animated:YES];
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        DrivingNumViewController *driving = [[DrivingNumViewController alloc] init];
        [self.navigationController pushViewController:driving animated:YES];
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
    NSString *qiniuUrl = [NSString stringWithFormat:BASEURL,kQiniuUpdateUrl];
    [JENetwoking startDownLoadWithUrl:qiniuUrl postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSDictionary *dataDic = data;
        weakself.qiniuToken = dataDic[@"data"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        NSString *keyUrl = [NSString stringWithFormat:@"%@-%@.png",[NSString currentTimeDay],[UserInfoModel defaultUserInfo].userID];
        [upLoadManager putData:gcdPhotoData key:keyUrl token:weakself.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
           
            if (info) {
                NSLog(@"key = %@",key);
                NSString *upImageUrl = [NSString stringWithFormat:kQiniuImageUrl,key];
                NSString *updateUserInfoUrl = [NSString stringWithFormat:BASEURL,kupdateUserInfo];
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
