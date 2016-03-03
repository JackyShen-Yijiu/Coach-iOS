//
//  JEPhotoPickManger.m
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "JEPhotoPickManger.h"
#import "PFActionSheetView.h"
#import <AVFoundation/AVFoundation.h>
//#import "ToolHeader.h"
@interface JEPhotoPickManger ()
@property (weak, nonatomic) UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate> *fromVc;

@end
@implementation JEPhotoPickManger


+ (void)pickPhotofromController:(UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)fromController{
    
    [PFActionSheetView showAlertWithTitle:nil message:nil cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选取"] withVc:fromController completion:^(NSUInteger selectedOtherButtonIndex) {
        
        if (selectedOtherButtonIndex == 0) {// 相机
            
            //判断是否拥有权限
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            NSLog(@"status = %i",authStatus);
            switch (authStatus) {
                    
                case AVAuthorizationStatusNotDetermined:
                {
                    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                        if (granted)
                        {
                            NSLog(@"User Granted");
                        }
                        else
                        {
                            NSLog(@"User Denied");
                        }
                    }];
                    break;
                }
                case AVAuthorizationStatusRestricted:
                    
                case AVAuthorizationStatusDenied:
                {
                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"相机授权" message:@"没有权限访问您的相机，请在“设置－隐私－相机”中允许使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                    [alterView show];
                    break;
                }
                    
                default:
                {
                    NSLog(@"拍照");
                    
                    // 调用相机
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.allowsEditing = YES;
                    picker.delegate = fromController;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                    picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                    
                    [fromController presentViewController:picker animated:YES completion:nil];
                    
                    //拍照
                    //从相册获取
                    break;
                    
                }
            }
           
        }else if (selectedOtherButtonIndex == 1) {// 相册
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.delegate = fromController;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
            picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                         NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
            
            [fromController presentViewController:picker animated:YES completion:nil];
   
        }
    }];
    
}

@end
