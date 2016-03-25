//
//  JEPhotoPickManger.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "JEPhotoPickManger.h"
#import "PFActionSheetView.h"
#import "BLPFAlertView.h"
#import "ToolHeader.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface JEPhotoPickManger ()
@property (weak, nonatomic) UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *fromVc;

@end
@implementation JEPhotoPickManger


+ (void)pickPhotofromController:(UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)fromController{
    
    [PFActionSheetView showAlertWithTitle:nil message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选取"] withVc:fromController completion:^(NSUInteger selectedOtherButtonIndex) {
        
        if (selectedOtherButtonIndex == 0) {
            
            
            // 检测摄像头的状态
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusDenied) {
                // 用户拒绝App使用
                
                [BLPFAlertView showAlertWithTitle:@"相机不可用" message:@"请在设置中开启相机服务" cancelButtonTitle:@"知道了" otherButtonTitles:@[ @"去设置" ] completion:^(NSUInteger selectedOtherButtonIndex) {
                    
                    if (0 == selectedOtherButtonIndex) {
                        // 打开应用设置面板
                        [self goAppSet];
                    }
                    
                }];
                
                return ;
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                DYNSLog(@"camera");
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = fromController;
                UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    type = UIImagePickerControllerSourceTypePhotoLibrary;
                }
                picker.sourceType = type;
                
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                
                [fromController presentViewController:picker animated:YES completion:nil];
                
            }
            
        }else if (selectedOtherButtonIndex == 1) {
            
            // 检测照片库授权状态
            ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
            if (authStatus == ALAuthorizationStatusDenied) {
                // 用户拒绝App使用
                
                [BLPFAlertView showAlertWithTitle:@"相册不可用" message:@"请在设置中开启相册服务" cancelButtonTitle:@"知道了" otherButtonTitles:@[ @"去设置" ] completion:^(NSUInteger selectedOtherButtonIndex) {
                    
                    if (0 == selectedOtherButtonIndex) {
                        // 打开应用设置面板
                        [self goAppSet];
                    }
                    
                }];
                
                return ;
            }
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = fromController;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                [fromController presentViewController:picker animated:YES completion:nil];
                
                //0x00007ff7f587e0a0
            }
        }
        
    }];
}

+ (void)goAppSet {
    
    // 打开应用设置面板
    NSURL *appSettingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:appSettingUrl];
}


@end
