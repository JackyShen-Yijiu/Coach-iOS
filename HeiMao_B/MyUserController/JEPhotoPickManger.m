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
        if (selectedOtherButtonIndex == 0) {
            
            
            AVAuthorizationStatus state = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (state == AVAuthorizationStatusAuthorized) {
                
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                    picker.allowsEditing = YES;
                    picker.delegate = fromController;
                    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                    picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                    
                    [fromController presentViewController:picker animated:YES completion:nil];
                }
 
                
            }else{
            
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用" message:@"请在设置->极致教练->相机 里面开启服务" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
                [alert show];
                
            } //
            
        }else if (selectedOtherButtonIndex == 1) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {

                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = YES;
                picker.delegate = fromController;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
                picker.navigationBar.barTintColor = fromController.navigationController.navigationBar.barTintColor;
                picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor],
                                                             NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
                
                [fromController presentViewController:picker animated:YES completion:nil];

                //0x00007ff7f587e0a0
            }
        }
           
    }];
    
}

@end
